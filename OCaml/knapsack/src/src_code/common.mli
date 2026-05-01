type item = { id: int; value: int; weight: int }
type instance = { nb_items: int; capacity: int; items: item list }
type solution = { total_value : int; chosen_items: int list }

val compare_item_densities : item -> item -> int

val sort_items : item list -> item list
