(* IMPORTS *)

open Bogue

module W = Widget
module L = Layout

let maxInputSize = 256 ;;
let outputSize = 256 ;;
let windowName = "gObct : goldrev's OCaml base conversion tool" ;;

(* LOGIC *)

type numBase = string * int ;;

let digOfChar : char -> int = function
        | '0' -> 0
        | '1' -> 1
        | '2' -> 2
        | '3' -> 3
        | '4' -> 4
        | '5' -> 5
        | '6' -> 6
        | '7' -> 7
        | '8' -> 8
        | '9' -> 9
        | _ -> failwith "intOfDigit : input cannot be resolved to a digit"
;;

let validateSyntaxInt (s : string) : bool =
        let len = String.length s in
        let rec aux k = if k = 0 then true else match s.[k] with
                | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9' -> aux (k - 1)
                | _ -> false
        in aux (len - 1)
;;

let validateNB ((num , base) : numBase) : bool =
        if num = "" || num.[0] = '0' || base < 2 || not (validateSyntaxInt num) then false else
        let len = String.length num in
        let rec aux k = if k >= len then true else
                let dgt = digOfChar num.[k] in
                if dgt < base && dgt >= 0 then aux (k + 1) else false
        in aux 1
;;

let nBToInt (((num , base) as nb) : numBase) : int =
        if num = "0" then 0 else
                if validateNB nb then
                        (let len = String.length num in
                        let rec aux k acc = if k >= len then acc else
                                aux (k + 1) (base * acc + (digOfChar num.[k]))
                in aux 0 0)
                else failwith "binToInt : input cannot be resolved to a valid binary number, maybe there are unnecessary zeros"
;;

let validateInt (s : string) : bool = validateSyntaxInt s && (int_of_string s) >= 0 ;;

let inputToNB ((num , base) : string * string) : numBase =
        if validateInt base then num , (int_of_string base) else failwith "inputToNB : base cannot be resolved to an integer"

;;

let intToNB ((num , base) : numBase) : string =
        if validateInt num then
                if num = "0" then "0" else
                        (let intNum = int_of_string num in 
                        let rec aux n nb = match n with
                                | 0 -> nb
                                | _ -> aux (n / base) ((string_of_int (n mod base)) ^ nb)
                        in aux intNum "")
        else failwith "intToBin : input cannot be resolved to an integer"
;;

let process (num , baseIn , baseOut : string * string * string) : string =
        intToNB (string_of_int (nBToInt (inputToNB (num , baseIn))),
        if validateInt baseOut then int_of_string baseOut else failwith "process : output base could not be resolved to an integer")
;;

(* GUI *)

let numLabel = W.label ~align:Draw.Min "Input your number here :" ;;
let inputNum = W.text_input ~prompt:"Number" ~max_size:maxInputSize () ;;
let baseInLabel = W.label ~align:Draw.Min "Input its base here :" ;;
let inputBase = W.text_input ~prompt:"Input base" ~max_size:maxInputSize () ;;
let baseOutLabel = W.label ~align:Draw.Min "Input the desired base for the output here" ;;
let outputBase = W.text_input ~prompt:"Output base" ~max_size:maxInputSize () ;;
let output = W.text_display ~w:outputSize "Output" ;;
let action  _ =
                (W.get_text inputNum , W.get_text inputBase , W.get_text outputBase)
                |> process
                |> Text_display.update_verbatim  (W.get_text_display output)
;;

let button = W.button ~action "Evaluate"in
let layout = L.tower_of_w ~name:windowName
        [numLabel ; inputNum ; baseInLabel ; inputBase ; baseOutLabel ; outputBase ; output ; button] in
L.set_width layout (maxInputSize * 4) ;
let main = 
        Bogue.of_layout layout
        |> Bogue.run
in
main ;;
