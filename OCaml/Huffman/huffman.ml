(* TO DO :
 * Update all function descriptions after adding the bal argument
 * Build the huffTree -> code list function
 * Build the string -> code list function
 * Build the string -> code list -> string function
 * Build the string -> string * huffTree function
 * build the string -> huffTree -> string function
 *)



(* Type definition *)

type assocEnc = (char * string) list ;;
type freq = char * int ;;
type huffTree = Node of huffTree * int * huffTree | Leaf of freq ;;
type code = char * string


(* Logic *)

(* An implementation of string_of_char (sadly not named in camlCase to keep the usual syntax of "x_of_y") 
 * Creates a string of length 1 made of the caracter used as its argument.
 *)

let string_of_char : char -> string = String.make 1 ;;

(* This function takes a character and a frequency list as its arguments.
 * If the character is already represented in the frequency list, its frequency counter is increased by 1.
 * If it is not in the list, then a new counter is created, initialized at 1.
 * Please note that this function changes the order of the frequency list !
 * COMPLEXITY = O(n) with n being the length of the frequency list
 *)

let addToFreq (ch : char) : freq list -> freq list =
        let rec aux (acc : freq list) = function
                | [] -> (ch , 1)::acc
                | h::t -> if fst h = ch then ((ch , (snd h) + 1)::t) @ acc else aux (h::acc) t
        in aux []
;;

(* This function takes a string as its argument.
 * It outputs a frequency list for each character present in the list.
 * COMPLEXITY = O(n^2) with n being the length of the text (because this function uses addToFreq for each character)
 *)

let textToFreq (text : string) : freq list =
        let len = String.length text in
        let rec aux k freq = if k >= len then freq else
                aux (k + 1) (addToFreq text.[k] freq)
        in aux 0 []
;;

(* This function takes a frequency list as its argument.
 * It outputs a list of huffTree leaves, each containing one of the char-int tuples (freq type) from the input list
 * COMPLEXITY = O(n) with n being the length of the list
 *)

let freqToHuffList : freq list -> huffTree list =
        let rec aux acc = function
                | [] -> []
                | h::t -> aux ((Leaf h)::acc) t
        in aux []
;;

(* This function is only used for testing, and might get deleted
 * It prints the contents of the input frequency list to the console
 * COMPLEXITY = O(n) with n being the length of the list
 *)

let printFreqList : freq list -> unit =
        let rec aux = function
                | (ch , fr)::t -> let out = "(" ^ string_of_char ch ^ " , " ^ string_of_int fr ^ ")" in
                        print_string (out ^ " ;") ; print_newline () ; aux t
                | [] -> print_string  "]"
        in print_string "[" ; aux
;;

(* This function takes a huffTree as its argument.
 * It outputs the int component (either from a Node directly or from a Leaf's freq tuple).
 *)

let getWeight : huffTree -> int = function
        | Node (_ , w , _) -> w
        | Leaf fr -> snd fr
;;

(* This function takes a huffTree and a huffTree list (supposed to be sorted by weight) as its arguments.
 * It outputs the list, with the element added to it at the right place to keep the list sorted.
 * COMPLEXITY = O(n) with n being the length of the list
 *)

let rec insort (e : huffTree) : huffTree list -> huffTree list = function
        | [] -> [e]
        | (h::t) as l -> if getWeight h > getWeight e then e::l else h::(insort e t)
;;

(* This polymorphic function takes a list with elements of type 'a as its argument.
 * It "wraps" each element in its own list (of length 1), and outputs the list of these wrapped elements.
 * COMPLEXITY = O(n) with n being the length of the list
 *)

let rec wrap : 'a list -> 'a list list = function
        | [] -> []
        | h::t -> [h]::(wrap t)
;;

(* This function takes two huffTree lists (supposed to be sorted by weight)  as its arguments.
 * Let m and n be the lengths of the first and second list (respectively).
 * The function outputs the combination of those two lists, which is a list of length m+n (which indicates that duplicates are kept).
 * COMPLEXITY = O(m+n)
 *)

let rec merge (l1 : 'a list) (l2 : 'a list) (order : int -> int -> bool) () : 'a list = match l1 , l2 with
        | [] , _ -> l2
        | _ , [] -> l1
        | h1::t1 , h2::t2 -> if order (getWeight h1) (getWeight h2) then h1::(merge t1 l2) else h2::(merge t2 l1)
;;

(* This function takes a list of huffTree lists (which are all supposed to be ordered).
 * If the list is empty or contains only one element, it is returned as is. If not, it merges its "sub-lists" two by two, and outputs the obtained list
 * COMPLEXITY = O(m*n) with m being the length of the list, and n being the sum of the length of the two biggest "sub-lists"
 *)

let rec flattenMerge ?(order = (<)) (bal : 'a -> int ) : 'a list list -> 'a list list = function
        | [] -> []
        | [x] -> [x]
        | lh1::lh2::t -> (merge lh1 lh2)::(flattenMerge t)
;;

(* This function takes a huffTree list as its argument.
 * It sorts the list, using previously implemented functions to implement the merge sorting algorithm.
 * COMPLEXITY = O(n*ln(n)) with n being the length of the input list
 *)

let rec mergeSort ?(order = (<)) (bal : 'a -> int) (l : 'a list) : 'a list =
        let rec aux = function
                | [] -> []
                | [x] -> x
                | l' -> aux (flattenMerge bal l')
        in aux (wrap l)
;;

(* This function takes a freq list as its argument.
 * It then builds a binary tree, using Huffman's algorithm, making sure that the characters with the highest frequency have shorter paths.
 * This is achieved by sorting the list, then repeatedly merging the two lightest huffTrees
 * The resulting Node is always added back to the list using the insort function, ensuring that the list always stays sorted.
 * This, in turn, makes it faster to find the two lightest huffTrees, for these are always the first two in the list !
 * COMPLEXITY = O(n*ln(n)) with n being the length of the list
 *)

let buildTree (fl : freq list) : huffTree =
        let rec aux = function
                | [] -> failwith "buildTree : list is empty !"
                | [tr] -> tr
                | h1::h2::t -> aux (insort (Node (h1 , (getWeight h1) + (getWeight h2) , h2)) t)
        in aux (mergeSort getWeight (freqToHuffList fl))
;;

let buildCode (ht : huffTree) : 
