module Pair = struct
    type ('a , 'b) t = 'a * 'b
    let make (a : 'a) (b : 'b) : ('a , 'b) t = (a , b)
    let first ((f , _) : ('a , 'b) t) : 'a = f
    let second ((_ , s) : ('a , 'b) t) : 'b = s
    let swap ((f , s) : ('a , 'b) t) : ('b , 'a) t = (b , a)
end  
