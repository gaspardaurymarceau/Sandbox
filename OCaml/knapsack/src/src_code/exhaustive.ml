open Common

let rec explore_exhaustive capacity undecided_items chosen_items current_value current_weight =
  if current_weight > capacity then {total_value = 0 ; chosen_items = []} else
    match undecided_items with
    | [] -> {total_value = current_value ; chosen_items = chosen_items}
    | h::t ->
        let wth = explore_exhaustive capacity t (h.id::chosen_items) (current_value + h.value) (current_weight + h.weight) in
        let wtht = explore_exhaustive capacity t chosen_items current_value current_weight in
        if wth.total_value >= wtht.total_value then wth else wtht

let solve_exhaustive instance = explore_exhaustive instance.capacity instance.items [] 0 0
