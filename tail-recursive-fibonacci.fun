fun fibAux( n ¸ penultimate ¸ ultimate ) =
    if n == 0 then penultimate
    else    
        if n == 1 then ultimate
        else fibAux( n - 1 ¸ ultimate ¸ penultimate + ultimate ),

fun fib(p) =
    fibAux( p ¸ 0 ¸ 1 )