type cell = { n : bool ref;
              e : bool ref;
              s : bool ref;
              w : bool ref; };;

type labyrinth = cell array array;;

Random.self_init ();;

let print_svg (s : string)  : unit =
        match Sys.command "touch ocaml_print_svg.svg ; echo \"\" > ocaml_print_svg.svg" with
        | 0 -> ()
        | _ -> failwith "Could not create the file for the svg.";
        ;

        let out = Out_channel.open_text "./ocaml_print_svg.svg" in
        (Out_channel.output_string out s;
        Out_channel.flush out;
        Out_channel.close out);

        match Sys.command "open ocaml_print_svg.svg" with
        | 0 -> ()
        | _ -> failwith "Could not open the temporary file."

let cell_tpl = { n = ref true ;
                 e = ref true ;
                 s = ref true ;
                 w = ref true ; }

let init (x : int) (y : int) : labyrinth = 
  let out = Array.init x (fun _ -> Array.make y cell_tpl) in
  for i = 0 to x - 1 do
    for j = 0 to y - 1 do
      out.(i).(j) <- { n = (if j = 0 then ref true else out.(i).(j - 1).s);
                       e = ref true;
                       s = ref true;
                       w = (if i = 0 then ref true else out.(i - 1).(j).e)}
    done
  done ;
  out

let prct v r = string_of_int (int_of_float (
    Float.round ((float_of_int v) /.(float_of_int r) *. 100.))
  )

let gen_header (w : int) (h : int) (b : Buffer.t) =
  Buffer.add_string b
    ("<svg viewBox=\"0 0" ^ string_of_int w ^ " " ^ string_of_int h ^
     "\" preserveAspectRatio=\"none\" style=\"display: block; margin: 2%;" ^
     "max-width: 100%; max-height: 500px\" xmlns=\"http://www.w3.org/2000/svg\">")

let gen_layout (w : int) (h : int) (b : Buffer.t) (lab : labyrinth) =
  for i = 0 to w - 1 do
    for j = 0 to h - 1 do
      if !(lab.(i).(j).n) then
        Buffer.add_string b
          ("<line x1=\"" ^ prct i w ^ "%\" y1=\"" ^ prct j h ^
           "%\" x2=\"" ^ prct (i + 1) w ^ "%\" y2=\"" ^ prct j h ^
           "%\" stroke=\"black\" stroke-width=\"2%\" stroke-linecap=\"round\" />")
      ;
      if !(lab.(i).(j).e) then
        Buffer.add_string b
          ("<line x1=\"" ^ prct (i + 1) w ^ "%\" y1=\"" ^ prct j h ^
           "%\" x2=\"" ^ prct (i + 1) w ^ "%\" y2=\"" ^ prct (j + 1) h ^
           "%\" stroke=\"black\" stroke-width=\"2%\" stroke-linecap=\"round\" />")
      ;
      if !(lab.(i).(j).s) then
        Buffer.add_string b
          ("<line x1=\"" ^ prct i w ^ "%\" y1=\"" ^ prct (j + 1) h ^
           "%\" x2=\"" ^ prct (i + 1) w ^ "%\" y2=\"" ^ prct (j + 1) h ^
           "%\" stroke=\"black\" stroke-width=\"2%\" stroke-linecap=\"round\" />")
      ;
      if !(lab.(i).(j).w) then
        Buffer.add_string b
          ("<line x1=\"" ^ prct i w ^ "%\" y1=\"" ^ prct j h ^
           "%\" x2=\"" ^ prct i w ^ "%\" y2=\"" ^ prct (j + 1) h ^
           "%\" stroke=\"black\" stroke-width=\"2%\" stroke-linecap=\"round\" />")
      ;
    done
  done

let to_svg (lab : labyrinth) : string=
  let w = Array.length lab in
  let h = Array.length lab.(0) in
  let out = Buffer.create 4000 in
  gen_header w h out; 
  gen_layout w h out lab;
  Buffer.add_string out "</svg>" ;
  Buffer.contents out

let draw lab = print_svg (to_svg lab) ;; 

(* let rec print_tpl_list = function
    | [] -> print_newline ()
    | (x,y)::t -> print_string "(";
        print_int x;
        print_string ", ";
        print_int y;
        print_string ") ";
        print_tpl_list t
*) 

type status =
  | Start
  | End
  | From of (int * int)
  | New
    
exception Impossible_labyrinth    

let print_square = function
  | End -> print_string "End"
  | Start -> print_string "Start"
  | From (x, y) -> print_string "From (";
      print_int x;
      print_string ", ";
      print_int y;
      print_string ")"
  | New -> print_string "New"

let find_path (lab : labyrinth) (xd : int) (yd : int) (xe : int) (ye : int) =
  let exception Empty_labyrinth in
  let exception Done of (int * int) in
  
  let lin, col = (
    match Array.length lab with
    | 0 -> raise Empty_labyrinth
    | k -> k
  ), (
      match Array.length lab.(0) with
      | 0 -> raise Empty_labyrinth
      | k -> k
    )
  in
  
  (* lab  is expected not to be empty *)
  let ctl = Array.make_matrix (lin) (col) New in
  ctl.(xd).(yd) <- Start;
  ctl.(xe).(ye) <- End;
  
  let explore (x,y) =
    let sqr = lab.(x).(y) in
    let out = List.filter_map
        (function
          | None -> None
          | Some (xx,yy) -> if xx = xe && yy = ye
              then raise (Done (x, y))
              else
                (if xx >= 0 && xx < lin && yy >= 0 && yy < col &&
                    (ctl.(xx).(yy) = New)
                 then Some (xx,yy) else None
                )
        )
        [(if !(sqr.s) then None else Some (x, y+1));
         (if !(sqr.n) then None else Some (x, y-1));
         (if !(sqr.e) then None else Some (x+1, y));
         (if !(sqr.w) then None else Some (x-1, y))]
    in
    List.iter (fun (xx, yy) ->
        ctl.(xx).(yy) <- From (x,y);
      )
      out;
    out
  in
  
  let mnd l1 l2 = l1 @ (List.filter (fun x -> not (List.mem x l1)) l2) in
  
  let rec one_step ntex = function
    | [] -> ntex
    | h::t -> one_step (mnd (explore h) ntex) t
  in
  
  let rec trace_back acc ((xx,yy) as cur) = match ctl.(xx).(yy) with
    | Start -> cur::acc
    | From prv -> trace_back (cur::acc) prv
    | s -> print_square s; raise Impossible_labyrinth
  in
  
  let rec very_dangerous_infinite_recursion tex =
    try
      match (one_step [] tex) with
      | [] -> raise Impossible_labyrinth
      | l -> very_dangerous_infinite_recursion l
    with
    | Done last_before_end -> trace_back [(xe, ye)] last_before_end
  in very_dangerous_infinite_recursion [(xd, yd)]

let rec gen_path (b : Buffer.t) (w : int) (h : int) : (int * int) list -> unit = function
  | [] -> ()
  | (x, y)::t -> Buffer.add_string b
                   ("<rect x=\"" ^ prct x w ^ "%\" y=\"" ^ prct y h ^
                    "%\" width=\"" ^ prct 100 (w * 100) ^
                    "%\" height=\"" ^ prct 100  (h * 100) ^
                    "%\" fill=\"green\" stroke=\"green\" />")
      ;
      gen_path b w h t
  

let to_svg_with_path (lab : labyrinth) (sol : (int * int) list) : string =
  let w = Array.length lab in
  let h = Array.length lab.(0) in
  let out = Buffer.create 5000 in
  gen_header w h out;
  gen_path out w h sol;
  gen_layout w h out lab;
  Buffer.add_string out "</svg>";
  Buffer.contents out
    
let draw_with_path (lab : labyrinth) (sol : (int * int) list) : unit =
  print_svg (to_svg_with_path lab sol)
    
let solve_and_draw (lab : labyrinth) =
  draw_with_path lab
    (find_path lab 0 0 ((Array.length lab) - 1) ((Array.length lab.(0)) - 1))

let exists_path lab xd yd xe ye =
  try let _ = find_path lab xd yd xe ye in true with
  | Impossible_labyrinth -> false

let remove_random_wall (lab : labyrinth) : unit =
  let w, h = (Array.length lab), (Array.length lab.(0)) in 
  
  let aux_path x y d =
    (* Assuming that there is a square in direction d relatively to x and y *)
    let xe, ye = match d with
      | 0 -> x, y - 1
      | 1 -> x + 1, y
      | 2 -> x, y + 1
      | 3 -> x - 1, y
      | _ -> failwith "Bomboclaat !!!!"
    in
    exists_path lab x y xe ye
  in
  
  let rec aux () =
    let x, y = (Random.int w), (Random.int h) in
    match Random.int 4 with
    | 0 -> if y = 0 || (not !(lab.(x).(y).n)) || aux_path x y 0
        then aux ()
        else lab.(x).(y).n := false
    | 1 -> if  x = (w - 1) || (not !(lab.(x).(y).e)) || aux_path x y 1
        then aux ()
        else lab.(x).(y).e := false
    | 2 -> if y = (h - 1) || (not !(lab.(x).(y).s)) || aux_path x y 2
        then aux ()
        else lab.(x).(y).s := false
    | 3 -> if x = 0 || (not !(lab.(x).(y).w)) || aux_path x y 3
        then aux ()
        else lab.(x).(y).w := false
    | _ -> failwith "Bomboclaat !"
  in
  aux ()


let rec make (x : int) (y : int) =
  let lab = init x y in
  while not (exists_path lab 0 0 (x - 1) (y - 1)) do
    remove_random_wall lab
  done;
  lab
;;

solve_and_draw (make 20 20)
