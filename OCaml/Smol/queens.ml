let repeat (s : string) : int -> string =
        let rec aux (acc : string) = function
                | 0 -> acc
                | n -> aux (acc ^ s) (n - 1)
        in aux ""


let print_sol (size : int) (sol : int list) : unit =
        let rec aux (pos : int) : int -> string =  function
                | k when k = size -> "" (* Should not happen... *)
                | k when k = pos -> " █ |" ^ (repeat "   |" (size - pos - 1))
                | k -> "   |" ^ (aux pos (k + 1))
        in
        let sep : string = "+" ^ (repeat "---+" size) ^ "\n" in
        print_string sep;
        List.iter (fun x -> print_string ((aux x 0) ^ "\n" ^ sep)) sol;
        print_string "\n"

let possible (size : int) (cur : int list) =
  let next_line = List.length cur in
  let rec check_position line pos = function
    | [] -> true
    | h::t -> (
        not (
          h = pos ||
          h + next_line = pos + line ||
          pos + next_line = h + line
        )
      ) && (check_position (line + 1) pos t)
  in
  let rec aux = function
    | max when max = size -> []
    | k -> if (check_position 0 k cur) then k::(aux (k + 1)) else aux (k + 1)
  in
  aux 0
    
let rec append (e : 'a) : 'a list -> 'a list = function
  | [] -> [e]
  | h::t -> h::(append e t) 
               
let rec eval (size : int) (cur : int list) : int list list =
  if List.length cur = size then [cur] else
    let rec aux = function
      | [] -> []
      | h::t -> (eval size (append h cur)) @ (aux t)
    in
    aux (possible size cur)
      
let queens (size : int) : int list list = eval size []

let main : unit =
        let arg : string array = Sys.argv in
        if Array.length arg != 2 then failwith "Wrong arguments. You just have to add the size. One integer and that's all !"
        else
                let size = int_of_string arg.(1) in
                List.iter (print_sol size) (queens size)
;;
main
