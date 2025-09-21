# Wide Arithmetic proposal for WebAssembly.

This repository is a clone of
[`WebAssembly/spec`](https://github.com/WebAssembly/spec/). It is meant for
discussion, prototype specification, and implementation of a proposal to add
support for wide arithmetic instructions for WebAssembly. This proposal is
currently [at phase 3 in the proposals process][phase].

[phase]: https://github.com/WebAssembly/proposals

* See the [overview](./proposals/wide-arithmetic/Overview.md) for a
  high-level summary and rationale of the proposal.

* See the [modified spec](https://webassembly.github.io/wide-arithmetic/core/)
  for the formalization of this proposal. Notably...
  * [new abstract syntax](https://webassembly.github.io/wide-arithmetic/core/syntax/instructions.html#numeric-instructions)
  * [new binary opcodes (scroll down)](https://webassembly.github.io/wide-arithmetic/core/binary/instructions.html#numeric-instructions)
  * [new text opcodes (scroll down)](https://webassembly.github.io/wide-arithmetic/core/text/instructions.html#numeric-instructions)
  * [new validation](https://webassembly.github.io/wide-arithmetic/core/valid/instructions.html#numeric-instructions)
  * [new execution](https://webassembly.github.io/wide-arithmetic/core/exec/instructions.html#numeric-instructions)
  * [new helper functions](https://webassembly.github.io/wide-arithmetic/core/exec/numerics.html#xref-exec-numerics-op-iconcat-mathrm-iconcat-m-n-i-1-i-2)
