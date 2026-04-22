let rec fxp (x : int) : int -> int = function
        | 0 -> 1
        | k when k mod 2 = 0 -> fxp (x * x) (k / 2)
        | k -> x * (fxp x (k - 1))
;;
print_int (fxp 2 15) ;;
