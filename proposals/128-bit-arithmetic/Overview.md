# 128-bit arithmetic

## Motivation

There are a number of use cases for 128-bit numbers and arithmetic in source
languages today such as:

* Aribtrary precision math - many languages have a bignum-style library which is
  an arbitrary precision integer. For example libgmp in C, numbers Python,
  `BigInt` in JS, etc. Big integers have a range of specific applications as
  well which can include being integral portions of cryptographic algorithms.

* Checking for overflow - some programs may want to check for overflow when
  performing arithmetic operations, such as seeing if a 64-bit addition
  overflowed. Using 128-bit arithmetic can be done to detect these sorts of
  situations.

* Niche bit tricks - some PRNGs use 128-bit integer state for efficient storage
  and calculation of the next state. Using 128-bit integers has also been done
  for hash table indexing as well.

Today, however, these use cases of 128-bit integers are significantly slower in
WebAssembly then they are on native platforms. The performance gap can range
from 2-7x slower than native at this time.

The goal of this proposal is to close this performance gap between native and
WebAssembly by adding new instructions which enable more efficient lowerings of
128-bit arithmetic operations.

### WebAssembly today with 128-bit arithmetic

[This is an example](https://godbolt.org/z/fMdjqvEaq) of what LLVM emits today
for 128-bit operations in source languages. Notably:

* `i64.add128` - expands to three `add` instructions plus comparisons.
* `i64.sub128` - same as `i64.add`, but with `sub` instructions.
* `i64.mul128` - this notably uses the `__multi3` libcall which is significantly
  slower than performing the operation inline.

For the same code [this is what native platforms
emit](https://godbolt.org/z/65d45ff5K). Notably:

* x86\_64 - addition/subtraction use `adc` and `sbb` to tightly couple the two
  additions/subtractions together and avoid moving the flags register into a
  general purpose register. Multiplication uses the native `mul` instruction
  which produces a 128-bit result which is much more efficient than the
  implementation of `__multi3`.
* aarch64 - addition/subtraction also use `adc` and `sbc` like x86\_64.
  Multiplication uses `umulh` to generate the upper bits of a multiplication and
  can efficiently use `madd` as well. This is a much more compact sequence than
  `__multi3`.
* riscv64 - this architecture notably does not have overflow flags and the
  generated code looks quite similar to the WebAssembly. Multiplication,
  however, has access to `mulhu` which WebAssembly does not easily provide.

For a comparison [this is the generated output of
Wasmtime](https://godbolt.org/z/46dcajxWa) for add/sub given the WebAssembly
that LLVM emits today (edited to produce a multivalue result instead of storing
it into memory). Notably:

* x86\_64 - addition/subtraction is not pattern matching to generate `adc` or
  `sbc` meaning that a compare-and-set is required.
* aarch64 - same consequences as x86\_64.
* riscv64 - the generated code mostly matches native output modulo frame pointer
  setup/teardown. On riscv64 it's expected that `i64.{add,sub}128` won't
  provide much of a performance benefit over today. Multiplication however will
  still be faster.

Overall the main cause for slowdowns are:

* On x86\_64 and aarch64 WebAssembly doesn't provide access to overflow flags
  done by `add` and `adds` and thus it's difficult for compilers to
  pattern-match and generate `adc` and `sbc`.
* On all platforms the `__multi3` libcall is significantly slower than native
  instructions because the libcall itself can't use the native instructions and
  the libcall's results are required to travel through memory (according to its
  ABI).

This proposal's native instructions for 128-bit operations should solve all of
these issues.

## Proposal

This proposal currently adds three new instructions to WebAssembly:

* `i64.add128`
* `i64.sub128`
* `i64.mul128`

These instructions all have the type `[i64 i64 i64 i64] -> [i64 i64]` where the
values are:

* i64 argument 0 - the low 64 bits of the left-hand-side argument
* i64 argument 1 - the high 64 bits of the left-hand-side argument
* i64 argument 2 - the low 64 bits of the right-hand-side argument
* i64 argument 3 - the high 64 bits of the right-hand-side argument
* i64 result 0 - the low 64 bits of the result
* i64 result 1 - the high 64 bits of the result

Each 128-bit operand and result is split into a low/high pair of `i64` values.
The semantics of add/sub/mul are the same as their 64-bit equivalents except
that they work at the level of 128-bits instead of 64-bits.

## Example


An example of implementing
[`u64::overflowing_add`](https://doc.rust-lang.org/std/primitive.u64.html#method.overflowing_add)
in Rust in WebAssembly might look like:

```wasm
(module
  (func $"u64::overflowing_add"
    (param i64 i64) (result i64 i64)
    (i64.add128
      (local.get 0) (i64.const 0) ;; lo/hi of lhs
      (local.get 1) (i64.const 0) ;; lo/hi of rhs
    )
  )
)
```

Here the two input values are zero-extended with constant 0 upper bits. The
overflow flag, the second result, is guaranteed to be either 0 or 1 depending
on whether overflow occurred.

## Spec Changes

### Structure

The definition for [numeric
instructions](https://webassembly.github.io/spec/core/syntax/instructions.html#numeric-instructions)
will be extended with:

```
instr ::= ...
		| i64.{binop128}

binop128 ::= add128
		   | sub128
		   | mul128
```

### Validation

Validation of [numeric
instructions](https://webassembly.github.io/spec/core/valid/instructions.html#numeric-instructions)
will be updated to contain:

```
i64.{binop128}

* The instruction is valid with type [i64 i64 i64 i64] -> [i64 i64]


            ----------------------------------------------------
             C ⊢ i64.{binop128} : [i64 i64 i64 i64] -> [i64 i64]

```

### Execution

Execution of [numeric
instructions](https://webassembly.github.io/spec/core/exec/instructions.html#numeric-instructions)
will be updated with:

```
i64.{binop128}

* Assert: due to validation, four values of type i64 are on the top of the stack.
* Pop the value `i64.const c4` from the stack.
* Pop the value `i64.const c3` from the stack.
* Pop the value `i64.const c2` from the stack.
* Pop the value `i64.const c1` from the stack.
* Create 128-bit value `v1` by concatenating `c1` and `c2` where `c1` is the low
  64-bits and `c2` is the upper 64-bits.
* Create 128-bit value `v2` by concatenating `c3` and `c4` where `c3` is the low
  64-bits and `c4` is the upper 64-bits.
* Let `r` be the result of computing `{binop128}(v1, v2)`
* Let `r1` be the low 64-bits of `r`
* Let `r2` be the high 64-bits of `r`
* Push the value `i64.const r1` to the stack
* Push the value `i64.const r2` to the stack


    (i64.const c1) (i64.const c2) (i64.const c3) (i64.const c4) i64.{binop128}
                             ↪ (i64.const r1) (i64.const r2)
                             (if r1:r2 = {binop128}(c1:c2, c3:c4))
```

### Binary Format

The binary format for [numeric
instructions](https://webassembly.github.io/spec/core/binary/instructions.html#numeric-instructions)
will be extended with:

```
instr ::= ...
        | 0xFC 19:u32   ⇒ i64.add128
        | 0xFC 20:u32   ⇒ i64.sub128
        | 0xFC 21:u32   ⇒ i64.mul128
```

> **Note**: opcodes 0-7 are `*.trunc_sat_*` instructions, 8-17 are bulk-memory
> and reference-types `{table,memory}.{copy,fill,init}`, `{elem,data}.drop`, and
> `table.grow`. Opcode 18 is proposed to be `memory.discord`.

### Text Format

The text format for [numeric
instructions](https://webassembly.github.io/spec/core/text/instructions.html#numeric-instructions)
will be extended with:

```
plaininstr_l ::= ...
               | 'i64.add128' ⇒ i64.add128
               | 'i64.sub128' ⇒ i64.sub128
               | 'i64.mul128' ⇒ i64.mul128
```

## Implementation Status

... TODO ...

## Alternatives

### Alternative: Overflow Flags

... TODO ...

### Alternative: Widening multiplication

Instead of `i64.mul128` it would be sufficient to add instructions such as
`i64.mul_wide_{u,s}` which are typed as `[i64 i64] -> [i64 i64]` and are defined
as producing a 128-bit result by multiplying the two 64-bit provided values.
This corresponds to `mul` and `imul` on x86-64 and has [equivalents on other
platforms as well](https://godbolt.org/z/eojr3MdWz). This is a lower-level
primitive than `i64.mul128` and is well-supported across architectures. Given
the current shape of the proposal, however, it "feels cleaner" to have
`i64.mul128`. The `i64.mul_wide_u` instruction can be encoded as `i64.mul128`
with constant 0 values for the upper bits and `i64.mul_wide_s` can be encoded
similarly with a right-shift of the low bits. This means that `i64.mul128`
should be sufficient for expressing the use cases of `i64.mul_wide_{s,u}`.

### Alternative: Why not add an `i128` type to WebAssembly?

Frontends compiling to WebAssembly are currently required to lower
source-language-level `i128` types into two 64-bit halves. This is done by LLVM,
for example, when lowering its internal `i128` type to WebAssembly. Adding
`i128` to WebAssembly would make this translation lower and remove the need for
`i64.add128` for example by instead being `i128.add`.

This alternative though is a major change to WebAssembly and can be a very large
increase in complexity for engines. Given the relatively niche use cases for
128-bit integers this is seen as an imbalance in responsibilities where a
relatively rarely used feature of 128-bit integers would require a significant
amount of investment in engines to support.

Native ISAs also typically do not have a 128-bit integer type. This means that
most operations need to be emulated with 64-bit values anyway such as
bit-operations or loads/stores. Loads/stores of 128-bit values in WebAssembly
can raise questions of tearing in threaded settings in addition to
partially-out-of-bounds loads/stores as well.

This leads to the conclusion to not add `i128` to WebAssembly and instead use
the other types already present in WebAssembly.

### Alternative: Why not use `v128` as an operand type?

WebAssembly already has a 128-bit value type of `v128` from the simd proposal.
Compilers typically keep this value in vector registers, however, such as
`%xmmN`. An operation like `i64.add128` would then have to move `%xmmN` into
general purpose registers, perform the operation, and then move it back to the
`%xmmN` register. This is hypothesized to pessimize performance.

Alternatively compilers could keep track of whether the value is in and `%xmmN`
vector register or in a general purpose register, but this is seen as a
significant increase in complexity for code translators.

Overall it seemed best to use `i64` operands instead of `v128` as it more
closely maps what native platforms do by operating on values in general-purpose
registers.

### Alternative: Why not add `i64.div128_{u,s}`?

Native ISAs generally do not have support for 128-bit division. The x86-64 ISA
has the ability to divide a 128-bit value by a 64-bit value producing a 64-bit
result, but this doesn't map to the desired semantics of `i64.div128_{u,s}` to
be equivalent to `i64.div_{u,s}` for example.

LLVM additionally for native platforms [unconditionally lowers 128-bit
division](https://godbolt.org/z/4xbGvbxja) to a host libcall of the `__udivti3`
function. It's expected that a host-provided implementation of `__udivti3` is
unlikely to be significantly faster than `__udivti3`-compiled-to-WebAssembly.
