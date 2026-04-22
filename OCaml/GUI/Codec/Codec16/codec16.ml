(* IMPORTS *)

open Bogue

module W = Widget
module L = Layout

let maxInputSize = 256 ;;
let outputSize = 256 ;;
let windowName = "gObc : goldrev's OCaml base converter" ;;

(* LOGIC *)

type numBase = string * int ;;

let digOfChar : char -> int = function
        | '0' -> 0 | '1' -> 1 | '2' -> 2 | '3' -> 3
        | '4' -> 4 | '5' -> 5 | '6' -> 6 | '7' -> 7
        | '8' -> 8 | '9' -> 9 | 'A' | 'a' -> 10 | 'B' | 'b' -> 11
        | 'C' | 'c' -> 12 | 'D' | 'd' -> 13 | 'E' | 'e' -> 14 | 'F' | 'f' -> 15
        | _ -> failwith "intOfDigit : input cannot be resolved to a digit"
;;

let strOfDig : int -> string = function
        | 0 -> "0" | 1 -> "1" | 2 -> "2" | 3 -> "3"
        | 4 -> "4" | 5 -> "5" | 6 -> "6" | 7 -> "7"
        | 8 -> "8" | 9 -> "9" | 10 -> "A" | 11 -> "B"
        | 12 -> "C" | 13 -> "D" | 14 -> "E" | 15 -> "F"
        | _ -> failwith "strOfDig : unknow digit : base 16 digits are 0123456789ABCDEF"
;;

let validateSyntaxInt (s : string) : bool =
        let len = String.length s in
        let rec aux k = if k = 0 then true else match s.[k] with
                | '0' | '1' | '2' | '3' | '4' | '5' | '6' | '7' | '8' | '9'
                | 'A' | 'a' | 'B' | 'b' | 'C' | 'c' | 'D' | 'd' | 'E' | 'e' | 'F' | 'f'
                        -> aux (k - 1)
                | _ -> false
        in aux (len - 1)
;;

let intOfString (st : string) : int =
        let len = String.length st in
        let rec aux k acc =
                if k >= len then acc 
                else aux (k + 1) (10 * acc + (digOfChar st.[k]))
        in aux 0 0
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
                else failwith "nBToInt : input cannot be resolved to a valid number, maybe there are unnecessary zeros"
;;

let validateInt (s : string) : bool = validateSyntaxInt s && (intOfString s) >= 0 ;;

let inputToNB ((num , base) : string * string) : numBase =
        if validateInt base then num , (intOfString base) else failwith "inputToNB : base cannot be resolved to an integer"

;;

let intToNB ((num , base) : numBase) : string =
        if validateInt num then
                if num = "0" then "0" else
                        (let intNum = intOfString num in 
                        let rec aux n nb = match n with
                                | 0 -> nb
                                | _ -> aux (n / base) ((strOfDig (n mod base)) ^ nb)
                        in aux intNum "")
        else failwith "intToBin : input cannot be resolved to an integer"
;;

let process (num , baseIn , baseOut : string * string * string) : string =
        intToNB (string_of_int (nBToInt (inputToNB (num , baseIn))),
        if validateInt baseOut then int_of_string baseOut else failwith "process : output base could not be resolved to an integer")
;;

(* GUI *)
let headLabel = W.html  ~h:150 "<font color=\"blue\">This tool takes a <b>positive integer</b> written in the specified input base, and returns it in the desired base.<br><br>
Both bases should be written as base 10 integers, and should be between 2 and 16 (both included)<br><br>
Accepted digits for the integer (non-base) input are :</font><br><font color=\"green\">0123456789AaBbCcDdEeFf" ;;
let numLabel = W.label ~align:Draw.Min "Input your number here :" ;;
let inputNum = W.text_input ~prompt:"Number" ~max_len:maxInputSize () ;;
let baseInLabel = W.label ~align:Draw.Min "Input its base here :" ;;
let inputBase = W.text_input ~prompt:"Input base" ~max_len:maxInputSize () ;;
let baseOutLabel = W.label ~align:Draw.Min "Input the desired base for the output here :" ;;
let outputBase = W.text_input ~prompt:"Output base" ~max_len:maxInputSize () ;;
let output = W.text_display ~h:50 ~w:(outputSize / 2) "Output" ;;
let action  _ =
                (W.get_text inputNum , W.get_text inputBase , W.get_text outputBase)
                |> process
                |> Text_display.update_verbatim  (W.get_text_display output)
;;

let button = W.button ~action "Evaluate"in
let layout = L.tower_of_w ~name:windowName
        [headLabel ; numLabel ; inputNum ; baseInLabel ; inputBase ; baseOutLabel ; outputBase ; output ; button] in
L.set_width layout ((max outputSize maxInputSize) * 2) ;
let main = 
        Bogue.of_layout layout
        |> Bogue.run
in
main ;;
