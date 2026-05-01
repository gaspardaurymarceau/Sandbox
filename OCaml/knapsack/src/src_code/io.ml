open Common
open Greedy
open Exhaustive
open Bab

let string_of_sol sol =
        let out = Buffer.create 500 in
        Buffer.add_string out ("Total value : " ^ (string_of_int sol.total_value) ^ "\nItems :\n[");
        List.iter (fun n -> Buffer.add_string out (string_of_int n ^ "; ")) sol.chosen_items;
        Buffer.truncate out ((Buffer.length out) - 2);
        Buffer.add_string out "]\n";
        Buffer.contents out
        
let eval_instance (path : string) : instance =
        let ipt = Stdlib.open_in path in
        let text = really_input_string ipt (in_channel_length ipt) in
        let lines = String.split_on_char '\n' text in
        
        let eval_items_aux (idt : int) (itm : string) : item = match String.split_on_char ' ' itm with
                | v::w::[] -> {id = idt ; value = int_of_string v ; weight = int_of_string w}
                | _ -> raise (Invalid_argument ("knap : io : eval_instance : eval_items_aux :\n" ^
                                "item at line " ^ (string_of_int (idt + 1)) ^ " cannot be read !")
                        )
        in
        let rec eval_items (idt : int) : string list -> item list = function
                | [] | ""::[] -> []
                | ""::t -> eval_items idt t
                | h::t -> (eval_items_aux idt h)::(eval_items (idt + 1) t)
        in 
        match lines with
                | [] | _::[] -> raise (Invalid_argument "knap : io : eval_instance : input file must have at least two lines !")
                | header::itms ->
                                let (nb, cp) = match String.split_on_char ' ' header with
                                        | [] | _::[] | _::_::_::_ -> raise (Invalid_argument
                                                        "knap : io : eval_instance : first line cannot be read !"
                                                )
                                        | n::c::[] -> n , c
                                in
                                {nb_items = int_of_string nb ; capacity = int_of_string cp ; items = (eval_items 1 itms)}

let io : unit -> unit =
    let args = Sys.argv in
	if Array.length args != 3 && not (Array.length args = 2 && args.(1) = "-h") then 
		raise (Invalid_argument (
                        "knap : io : io : this command expects two arguments, however "^
		        ( string_of_int ((Array.length args) - 1))^
		        " were given.\n" ^
                        "Enter \"knap -h\" for more information on this command !"
                ))
	else let sol : solution = match args.(1) with
		| "-h" -> print_string
			("The Knapsack command excepts one argument for the chosen algorithm :\n"^
				"   -g for \"greedy\"\n"^
                                "   -e for \"exhaustive\"\n"^
                                "   -b for \"branch and bound\"\n"^
				"Moreover, it requires a document defining a set of items, see an example here :\n"^
				"https://geoffroy.re/docs/knapsack-bronze.txt"
			);
			Stdlib.exit 0
		| "-g" -> solve_greedy (eval_instance args.(2))
		| "-e" -> solve_exhaustive (eval_instance args.(2))
		| "-b" -> solve_branch_and_bound (eval_instance args.(2))
        | s -> raise (Invalid_argument ("knapsack : io : io : Unknown option : " ^ s ^ "\nEnter \"knap -h\" for more information on this command !"));
    in
    print_string ("Solution :\n" ^ (string_of_sol sol));
    Stdlib.exit 0
;;
