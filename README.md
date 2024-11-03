# Wide Arithmetic proposal for WebAssembly.

This repository is a clone of
[`WebAssembly/spec`](https://github.com/WebAssembly/spec/). It is meant for
discussion, prototype specification, and implementation of a proposal to add
support for wide arithmetic instructions for WebAssembly. This proposal is
currently [at phase 2 in the proposals process][phase].

[phase]: https://github.com/WebAssembly/proposals

* See the [overview](./proposals/wide-arithmetic/Overview.md) for a
  high-level summary and rationale of the proposal.

* See the [modified spec](https://webassembly.github.io/wide-arithmetic/core/)
  for the formalization of this proposal. Notably...
  * [new abstract syntax](https://webassembly.github.io/wide-arithmetic/core/syntax/instructions.html#numeric-instructions)
  * [new binary opcodes (scroll down)](https://webassembly.github.io/wide-arithmetic/core/binary/instructions.html#numeric-instructions)
  * [new text opcodes (scroll down)](https://webassembly.github.io/wide-arithmetic/core/text/instructions.html#numeric-instructions)
  * [new validation](https://webassembly.github.io/wide-arithmetic/core/valid/instructions.html#xref-syntax-types-syntax-valtype-mathsf-i64-mathsf-xref-syntax-instructions-syntax-binop-mathit-binop-mathsf-128)
  * [new execution](https://webassembly.github.io/wide-arithmetic/core/exec/instructions.html#xref-syntax-types-syntax-valtype-mathsf-i64-mathsf-xref-syntax-instructions-syntax-binop-mathit-binop-mathsf-128)
  * [new helper functions](https://webassembly.github.io/wide-arithmetic/core/exec/numerics.html#xref-exec-numerics-op-iconcat-mathrm-iconcat-m-n-i-1-i-2)

Original README from upstream repository follows...

--------------------------------------------------------------------------------

[![CI for specs](https://github.com/WebAssembly/spec/actions/workflows/ci-spec.yml/badge.svg)](https://github.com/WebAssembly/spec/actions/workflows/ci-spec.yml)
[![CI for interpreter & tests](https://github.com/WebAssembly/spec/actions/workflows/ci-interpreter.yml/badge.svg)](https://github.com/WebAssembly/spec/actions/workflows/ci-interpreter.yml)

# spec

This repository holds the sources for the WebAssembly draft specification
(to seed a future
[WebAssembly Working Group](https://lists.w3.org/Archives/Public/public-new-work/2017Jun/0005.html)),
a reference implementation, and the official testsuite.

A formatted version of the spec is available here:
[webassembly.github.io/spec](https://webassembly.github.io/spec/),

Participation is welcome. Discussions about new features, significant semantic
changes, or any specification change likely to generate substantial discussion
should take place in
[the WebAssembly design repository](https://github.com/WebAssembly/design)
first, so that this spec repository can remain focused. And please follow the
[guidelines for contributing](Contributing.md).

# citing

For citing WebAssembly in LaTeX, use [this bibtex file](wasm-specs.bib).
