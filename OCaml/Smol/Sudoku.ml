type petite_ligne = int * int * int ;;
type bloc = petite_ligne * petite_ligne * petite_ligne ;;
type grande_ligne = bloc * bloc * bloc ;;
type grille = grande_ligne * grande_ligne * grande_ligne ;;

(* Q1 *)

let app3 f t =
  let a , b , c = t in
  (f a , f b ,f c)
;;

let tous (f : 'a -> bool) t =
  let a , b , c = (app3 f t) in
  a && b && c
;;

let existe (f : 'a -> bool) t =
  let a , b , c = (app3 f t) in
  a || b || c
;;

let existe_paire test t =
  let a , b , c = t in
  test a b || test a c || test b c
;;

(* Q2 *)

let dans_bornes n =
  n >= 1 && n <= 9
;;

let dans_bornes_petite_ligne =
  tous dans_bornes
;;

let dans_bornes_bloc =
  tous dans_bornes_petite_ligne
;;

let dans_bornes_grille =
  tous (tous dans_bornes_bloc)
;;

(* Q3 *)

let differents_petite_ligne l = 
  not (existe_paire (fun a b -> a = b) l)
;;

let dans pl x =
  let a , b , c = pl in a = x || b = x || c = x
;;

let intersecte l1 l2 =
  let a , b , c = l1 in dans l2 a || dans l2 b || dans l2 c
;;

let differents_bloc b=
  (tous differents_petite_ligne b) && (not (existe_paire intersecte b));;

(* Q4 *)

let bloc_correct b =
  dans_bornes_bloc b && differents_bloc b
;;

let blocs_corrects =
  tous (tous bloc_correct)
;;

(* Q5 *)

let p1 t =
  let x , _ , _ = t in x
;;

let p2 t =
  let _ , x , _ = t in x
;;

let p3 t =
  let _ , _ , x = t in x
;;

let transpose9 x =
  (p1 (p1 x) , p1 (p2 x) , p1 (p3 x)) , (p2 (p1 x) , p2 (p2 x) , p2 (p3 x)) , (p3 (p1 x) , p3 (p2 x) , p3 (p3 x)) 
;;

(* Q6 *)

let transpose_lignes_blocs =
  app3 transpose9
;;

let lignes_correctes g =
  blocs_corrects (transpose_lignes_blocs g)
;;

(* Q7 *)

let transpose_blocs =
  app3 (app3 transpose9)
;;

let transpose_grille g =
  transpose9 (transpose_blocs g)
;;

let colonnes_correctes g =
  lignes_correctes (transpose_grille g)
;;

let correcte g =
  blocs_corrects g && lignes_correctes g && colonnes_correctes g
;;

let triple f = fun () -> (f() , f() , f()) ;;

let grille_aleatoire : unit -> grille =
  let case = (fun () -> (Random.int 9 + 1)) in
  triple (triple (triple (triple case)))
;;

let print_grille : grille -> unit = fun g ->(
  let print_int = fun n -> print_string (string_of_int n) in
  let space = fun () -> print_string " " in
  let separateurVertical = fun () -> print_string " | "  in
  let separateurHorizontal = fun () ->
    print_newline ();
    print_string "------+-------+------";
    print_newline() in
  let print_petite_ligne = (fun l ->
    let a , b , c = l in
    print_int a;
    space();
    print_int b;
    space();
    print_int c
  ) in
  let print_grande_ligne = (fun l ->
    let b1 , b2 , b3 = l in
    print_petite_ligne (p1 b1);
    separateurVertical();
    print_petite_ligne (p1 b2);
    separateurVertical();
    print_petite_ligne (p1 b3);
    print_newline();
    print_petite_ligne (p2 b1);
    separateurVertical();
    print_petite_ligne (p2 b2);
    separateurVertical();
    print_petite_ligne (p2 b3);
    print_newline();
    print_petite_ligne (p3 b1);
    separateurVertical();
    print_petite_ligne (p3 b2);
    separateurVertical();
    print_petite_ligne (p3 b3);
  ) in
  let a , b , c = g in
  print_grande_ligne a;
  separateurHorizontal();
  print_grande_ligne b;
  separateurHorizontal();
  print_grande_ligne c;
  print_newline();
  );;

let damnLuck = (
  fun () ->
  let g = ref (grille_aleatoire()) in
  while not (correcte !g) do
    g := grille_aleatoire()
  done;
  print_grille !g
  );;

damnLuck();;