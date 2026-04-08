let currify f = fun (x , y) -> f x y ;;

let uncurrify f = fun x y -> f (x , y);;
