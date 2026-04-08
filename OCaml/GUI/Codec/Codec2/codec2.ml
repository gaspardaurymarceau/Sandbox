(* IMPORTS *)

open Bogue

module W = Widget
module L = Layout

let maxInputSize = 32 ;;
let windowName = "Placeholder name" ;;

(* LOGIC *)

let validateBin (bin : string) : bool =
        if bin = "" || bin.[0] != '1' then false else
        let len = String.length bin in
        let rec aux k = if k >= len then true else
                match bin.[k] with
                | '0' | '1' -> aux (k + 1)
                | _ -> false
        in aux 1
;;

let binToInt (bin : string) : int =
        if bin = "0" then 0 else
                if validateBin bin then
                        (let len = String.length bin in
                        let rec aux k acc = if k >= len then acc else match bin.[k] with
                        | '0' -> aux (k + 1) (2 * acc)
                        | '1' -> aux (k + 1) (2 * acc + 1)
                        | _ -> failwith "binToInt :
                                input was not a correct integer but was not detected by the validateBin function, 
                                please report this to the developer"
                in aux 1 1)
                else failwith "binToInt : input cannot be resolved to a valid binary number, maybe there are unnecessary zeros ?"
;;

let validateSyntaxInt (s : string) : bool =
        let len = String.length s in
        let rec aux k = if k = 0 then true else match s.[k] with
                | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' -> aux (k - 1)
                | _ -> false
        in aux (len - 1)
;;

let validateInt (s : string) : bool = validateSyntaxInt s && (int_of_string s) >= 0 ;;

let intToBin (num : string) : string =
        if validateInt num then
                if num = "0" then "0" else
                        (let intNum = int_of_string num in 
                        let rec aux n bin = match n with
                                | 0 -> bin
                                | _ -> if n mod 2 = 0 then aux (n / 2) ("0" ^ bin) else aux (n / 2) ("1" ^ bin)
                        in aux intNum "")
        else failwith "intToBin : input cannot be resolved to an integer"
;;

let processB2I (usrInput : string) : string = string_of_int (binToInt usrInput) ;;
let processI2B (usrInput : string) : string = intToBin usrInput ;;

(* GUI *)

let input = W.text_input ~prompt:"Input" ~max_size:maxInputSize () ;;
let output = W.label "Output" ;;
let action  _ =
        W.get_text input
        |> processI2B
        |> W.set_text output
;;

let button = W.button ~action "Evaluate"in
let layout = L.tower_of_w ~name:windowName ~align:Draw.Center
        [input ; output ; button] in
L.set_width layout ((maxInputSize * 10) + (maxInputSize / 10)) ;
let main = 
        Bogue.of_layout layout
        |> Bogue.run
in
main ;;
