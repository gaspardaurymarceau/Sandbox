let make_mat (t : int array array) (fl : int): unit =
    let m = Array.length t in
    let n = if m = 0 then 0 else Array.length t.(0) in
    let lc = ref fl in
    let b = Buffer.create (20 * m * n) in
    Buffer.add_string b (string_of_int !lc ^ ": malloc R0, " ^ string_of_int m ^ "\n");
    incr lc;
    for i = 0 to m - 1 do
        Buffer.add_string b (string_of_int !lc ^ ": malloc R1, " ^ string_of_int n ^ "\n");
        incr lc;
        for j = 0 to n - 1 do
            Buffer.add_string b (string_of_int !lc ^ ": move [R1" ^
                (if j = 0 then "" else ("+" ^ string_of_int j)) ^
                "], " ^ string_of_int t.(i).(j) ^ "\n");
            incr lc;
        done;
        Buffer.add_string b (string_of_int !lc ^ ": move [R0" ^
            (if i = 0 then "" else ("+" ^ string_of_int i)) ^
            "], R1\n");
        incr lc;
    done;
    print_string (Buffer.contents b)
in
let mat =
    [|
    [|1; 0; 0; 0; 0|];
    [|0; 0; 0; 0; 0|];
    [|0; 0; 0; 0; 0|];
    [|0; 0; 0; 0; 0|];
    [|0; 0; 0; 0; 1|];
    |]
in
make_mat mat 0
