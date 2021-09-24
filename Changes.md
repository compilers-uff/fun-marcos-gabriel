# Trabalho de conclusão do curso de Compiladores 2021.1

Christiano Braga  
Instituto de Computação  
Universidade Federal Fluminense

- Data de entrega: 24/09/2021

**Aluno:** Marcos Gabriel Pereira Paulo
**Matrícula:** 117031087

## Objetivo

Estender a linguagem Fun e seu interpretador com suporte a definição
de uma função com um número indefinido de parâmetros e sua chamada.

## Etapas Realizadas

1. Inclusão da palavra reservada `¸` no módulo `FUN-LEX` para que o lexer consiga reconhecer o símbolo de separação de argumentos

```
---| Add ¸ keyword to separate arguments on argument list
eq keywords = ('fun '`( '`) '= '`, '~ '+ '- '* '/ '>= '> '<= '< '== 'or 'and 'if 'then 'else '¸) .
```

2. Adição do tipo List nos parâmetros de entrada na definição e chamada de funções no módulo `FUN-GRM`

```
---| Adding List to accepted function definition arguments
op fun_(_) =_ : Idn List Expr -> Expr [prec 50] .

---| Adding List to accepted function call arguments
op _(_) : Idn List -> Expr [prec 10] .
```

3. Modificações no módulo `FUN-TRAN2`, dando suporte a declaração e chamada de funções com mais de um argumento

```
---| Argument list (used to define the type)
var args : List .
---| Transforms list on formals, then compiles the remaing ids
op formalsList : List -> Formals .
eq formalsList(args) = 	if getTailId(args) == nil
				---| Compiles head and finishes recursion
                    		then compileIdn(getHeadId(args))
				---| Compiles head and calls recursively for the tail
                       		else compileIdn(getHeadId(args)) formalsList(getTailId(args))
                       	fi .
---| Transforms list on actuals, then compiles the remaingexpressions
op actualsList : List -> Actuals .
eq actualsList(args) =  if getTailExpr(args) == nil
				---| Compiles head and finishes recursion
                           	then compileExpr(getHeadExpr(args))
				---| Calls recursively for the tail and compiles head
                           	else actualsList(getTailExpr(args) compileExpr(getHeadExpr(args))
                       	fi .
---| Accepts argument list on declaration
eq compileExpr(fun I1 (args) = E) = compileDec(fun I1 (args) = E) .
---| Accepts argument list on call
eq compileExpr(I(args)) = recapp(compileIdn(I), actualsList(args)) .
---| Accepts argument list on declaration compilation
eq compileExpr((fun I1 (args) = E1, E2)) = let(compileDec(fun I1 (args) = E1), compileExpr(E2)) .
---| Accepts argument list on call compilation
op compileDec : Expr -> Dec .
eq compileDec(fun I1 (args) = E) = rec(compileIdn(I1), lambda(formalsList(args), compileExpr(E))) .
```

4. Implementação dos algoritmos de fibonacci e fatorial, utilizando recursão de cauda

```
fun fatAux(n ¸ prev) =
    if n == 0
	then prev
	else fatAux( n - 1 ¸ prev * n ),

fun fat(p) =
    fatAux( p ¸ 1)

fun fibAux( n ¸ penultimate ¸ ultimate ) =
    if n == 0 then penultimate
    else
        if n == 1 then ultimate
        else fibAux( n - 1 ¸ ultimate ¸ penultimate + ultimate ),

fun fib(p) =
    fibAux( p ¸ 0 ¸ 1 )
```
