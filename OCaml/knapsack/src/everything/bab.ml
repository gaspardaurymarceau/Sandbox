open Common

let upper_bound residual_capacity undecided_items current_value = match undecided_items with
  | [] -> current_value
  | h::t -> current_value + int_of_float (((float_of_int h.value) /. (float_of_int h.weight)) *. (float_of_int residual_capacity))

let rec explore_bab best_solution_so_far capacity undecided_items chosen_items current_value current_weight =
  if current_weight > capacity  ||
     (upper_bound (capacity - current_weight) undecided_items current_value) <= best_solution_so_far then
    {total_value = 0 ; chosen_items = []} else
    match undecided_items with
    | [] -> {total_value = current_value ; chosen_items = chosen_items}
    | h::t ->
        let wth = explore_bab best_solution_so_far capacity t (h.id::chosen_items) (current_value + h.value) (current_weight + h.weight) in
        let wtht = explore_bab (max wth.total_value best_solution_so_far) capacity t chosen_items current_value current_weight in
        if wth.total_value >= wtht.total_value then wth else wtht

let solve_branch_and_bound instance =
  explore_bab 0 instance.capacity (sort_items instance.items) [] 0 0
