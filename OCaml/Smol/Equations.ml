type equation = {a : float ; b : float ; c : float} ;;
type solution = Nil | Single of float | Double of float * float ;;
let resoudre ({a;b;c} : equation) : solution =
  let delta = (b *. b) -. (4. *. a *. c) in
  match delta with
    | _ when delta < 0. -> Nil
    | 0. -> Single (-.b /. (2. *. a))
    | _ -> Double ((-.b +.  sqrt(delta)) /. (2. *. a), (-.b -.  sqrt(delta)) /. (2. *. a))
;;

let print_solution sol = match sol with
  | Nil -> print_string "Aucune solution dans R"
  | Single x0 -> print_string ("Solution : " ^ string_of_float x0)
  | Double (x1 , x2) -> print_string ("Solutions" ^ string_of_float x1 ^ " ; " ^ string_of_float x2)
;;

print_solution (resoudre {a = 5. ; b = 1000. ; c = 1.})