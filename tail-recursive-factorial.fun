fun fatAux(n ¸ prev) =
    if n == 0
	then prev
	else fatAux( n - 1 ¸ prev * n ),

fun fat(p) =
    fatAux( p ¸ 1)