public class Pyramid {
    public static String mult (String ch , int m) {
        String res = "" ;
        for (int i = 0 ; i < m ; i++) {
            res += ch ;
        }
        return res ;
    }
    public static void execute (int layers) {
        if (layers >= 0) {
            String stars = "*" ;
            while (layers > 0) {
                String spaces = mult (" " , layers - 1) ;
                System.out.print(spaces + stars + "\n") ;
                stars += " *" ;
                layers -= 1 ;
            }
        } else {
            String spaces = "" ;
            while (layers < 0) {
                String stars = mult ("* " , - layers) ;
                System.out.print(spaces + stars + "\n") ;
                spaces += " " ;
                layers += 1 ;
            }
        }
    }
    public static void main (String[] args) {
        execute (-20);
    }
}