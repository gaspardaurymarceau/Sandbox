type num = {value : int ; base : int} ;;

let print_num n =
  print_newline () ;
  print_int n.value ;
  print_string " in base " ;
  print_int n.base
;;

let pow nbr exp =
  let rec aux  n e acc = match e with
    | 0 -> acc
    | _ when n = 1 -> 1
    | _ when n = 0 -> 0
    | _ when e < 0 -> failwith "pow : negative power was given but output must be an integer"
    | _ when e mod 2 = 0 -> aux (n * n) (e / 2) acc
    | _ -> aux  n (e - 1) (n * acc)
  in
  aux  nbr exp 1
;;

let read nbr bs=
  let n , b = nbr.value , nbr.base in
  let rec aux n' acc p = match n' with
    | 0 -> acc
    | _ -> aux (n' / 10) (acc + ((n' mod 10) * pow b p)) (p + 1)
  in
  aux n 0 0
;;
      
let w = {value = 1011010111 ; base = 2};;
print_int (read w 10)