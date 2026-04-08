let len l =
    let rec aux l' acc = match l' with
        | [] -> acc
        | h::t -> aux t (acc + 1)
    in
    aux l 0
;;

let split l =
    let rec aux l1 l2 n = match n with
        | 0 -> l1,l2
        | _ -> let h::t = l1 in aux t (h::l2) (n - 1)
    in
    aux l [] ((len l) / 2)
;;

let rec merge l1 l2 = match l1,l2 with
    | [],_ -> l2
    | _,[] -> l1
    | h1::t1 , h2::t2 -> if h1 <= h2 then h1::(merge t1 l2) else h2::(merge l1 t2)
;;

let rec sort l = match l with
    | [] -> l
    | [x] -> l
    | _ -> let l1,l2 = split l in merge (sort l1) (sort l2)
;;

let rec print_list l = match l with
    | [] -> print_newline ()
    | h::t -> print_int h ; print_string " " ; print_list t
;;

print_list (sort [1 ; 2 ; 6 ; 7 ; 8 ; 5 ; 3 ; 2 ; 189 ; 727 ; 420 ; 42 ; 1 ; 0 ; -6]);;


