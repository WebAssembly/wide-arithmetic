open Values

val eval_unop : Ast.unop -> num -> num
val eval_binop : Ast.binop -> num -> num -> num
val eval_testop : Ast.testop -> num -> bool
val eval_relop : Ast.relop -> num -> num -> bool
val eval_cvtop : Ast.cvtop -> num -> num
val eval_binop128 : Ast.binop128 -> num -> num -> num -> num -> num * num
val eval_binop_wide : Ast.binop_wide -> num -> num -> num * num
