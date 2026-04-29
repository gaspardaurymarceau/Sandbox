type grid = bool array array

exception No_Solution

let rec repeat (s : string) : int -> string =
        let rec aux (acc : string) : int -> string = function
                | 0 -> acc
                | n -> aux (acc ^ s) (n - 1)
        in
        aux ""

let print_grid (g : grid) : unit =
        let len = Array.length g in
        if len = 0 then () else
                print_string ("+" ^ (repeat "---+" len) ^ "\n");
                for i = 0 to len - 1 do
                        print_string "|";
                        for j = 0 to len - 1 do
                                print_string (" " ^ (if g.(i).(j) then "█" else " ") ^ " |");
                        done;
                print_string ("\n+" ^ (repeat "---+" len) ^ "\n")
                done

let grid_of_coordinates_list (size : int) : (int * int) list -> grid = 
        let g = Array.make_matrix size size false in
        let rec aux = function
                | [] -> g
                | (x,y)::t -> g.(x).(y) <- true; aux t
        in
        aux


let verif : grid -> bool = Array.for_all (Array.for_all not)

let gen_all_moves (size : int) : (int * int) list =
        List.init (size * size) (fun n -> (n / size), (n mod size))

let apply (x,y : int * int) : grid -> unit = Array.iteri (
        fun i l -> Array.mapi_inplace (fun j e -> e <>
        ((i = x && (j = y || j = y + 1 || j = y - 1)) ||
        (j = y && (i = x + 1 || i = x - 1)))
                ) l
        )

let rec solve_aux (g : grid) (partial_sol : (int * int) list) (moves : (int * int) list) : (int * int) list option =
        if verif g then Some partial_sol else match moves with
                | [] -> None
                | h::t -> match solve_aux g partial_sol t with
                        | None -> (apply h g; let tmp = solve_aux g (h::partial_sol) t in apply h g; tmp)
                        | (Some _) as sol -> sol

let main (grid_to_solve : grid) : unit =
        let size : int = Array.length grid_to_solve in
        match solve_aux grid_to_solve [] (gen_all_moves size) with
                | None -> raise No_Solution
                | Some sol -> print_grid (grid_of_coordinates_list size sol)

let template : grid = [|
        [|false; true; false; false; false|];
        [|true; false; true; false; true|];
        [|true; false; true; true; true|];
        [|false; false; true; true; false|];
        [|true; true; false; true; true|]
|];;

let smol_template : grid = [|
        [|true; true; true|];
        [|true; false; true|];
        [|false; false; false|]
|] in

main smol_template
