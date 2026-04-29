let fibo (n : int) : int =
        let x = float_of_int n in
        let sf = Float.sqrt 5. in
        int_of_float (Float.round (((Float.pow (1. +. sf) x) -. (Float.pow (1. -. sf) x)) /. ((Float.pow 2. x) *. sf)))
in

for i = 0 to 20 do
        print_string "Fibonacci's sequence's ";
        print_int (i + 1);
        print_string (match i + 1 with
                | 1 -> "st"
                | 2 -> "nd"
                | 3 -> "rd"
                | _ -> "th"
        );
        print_string " term (at index ";
        print_int i;
        print_string ") is : ";
        print_int (fibo i); print_newline ()
done
