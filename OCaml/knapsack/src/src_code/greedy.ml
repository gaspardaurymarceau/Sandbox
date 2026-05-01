open Common

let solve_greedy (inst : instance) : solution =
  let sorted = sort_items inst.items in
  let rec fill bag w v = function
    | [] -> (bag,v)
    | h::t when w + h.weight > inst.capacity -> fill bag w v t
    | h::t -> fill (h.id::bag) (w + h.weight) (v + h.value) t
  in
  let sol = fill [] 0 0 sorted in
  {
    total_value = snd sol;
    chosen_items = fst sol
  }
