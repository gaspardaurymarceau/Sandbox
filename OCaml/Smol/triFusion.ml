let rec len l = match l with
  | [] -> 0
  | h::t -> 1 + len t
;;

let divise (l : 'a list) : 'a list * 'a list =
  let n = (len l) / 2 in
  let rec aux l1 l2 k = match k with
    | 0 -> l1 , l2
    | _ -> let h::t = l1 in aux t (h::l2) (k - 1)
  in
  aux l [] n
;;


let rec merge (l1 : 'a list) (l2 : 'a list) : 'a list = match l1 , l2 with
  | [] , _ -> l2
  | _ , [] -> l1
  | h1::t1 , h2::t2 when h1 <= h2 -> h1::(merge t1 l2)
  | _ , h2::t2 -> h2::(merge l1 t2)
;;

let rec triFusion (l : 'a list) : 'a list = match l with
  | [] -> l
  | [a] -> l
  | _ -> let l1 , l2 = divise l in merge (triFusion l1) (triFusion l2)
;;

triFusion [1;4;8;9;0;7;100;5;7;15;76;53;6;93]