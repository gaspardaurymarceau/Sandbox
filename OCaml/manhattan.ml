let rec man m n = match m , n with
        | 0 , _ | _ , 0 -> 1
        | _ -> (man (m - 1)  n) + (man m (n - 1))
;;
print_int (man 3 3) ;;
