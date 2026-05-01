type item = { id: int; value: int; weight: int }
type instance = { nb_items: int; capacity: int; items: item list }
type solution = { total_value : int; chosen_items: int list }

let compare_item_densities (a : item) (b : item) : int =
  let da : float = (float_of_int a.value) /. (float_of_int a.weight) in
  let db : float = (float_of_int b.value) /. (float_of_int b.weight) in
  Float.compare db da
    
let sort_items : item list -> item list = List.sort compare_item_densities
