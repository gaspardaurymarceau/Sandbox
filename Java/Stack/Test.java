import java.util.* ;

public class Test {
    public static void transvaser (Stack<Integer> p , Stack<Integer> q) {
        while (!p.empty()) {
            q.push(p.pop()) ;
        }
    }

    public static void afficher( Stack<Integer> p) {
        Stack<Integer> tmp = new Stack<>() ;
        while (!p.empty()) {
            int num = p.pop() ;
            System.out.println(num) ;
            tmp.push(num) ;
        }
        transvaser(tmp , p) ;
    }

    public static void deplacer (Stack<Integer> p , Stack<Integer> q) {
        Stack<Integer> tmp = new Stack<>() ;
        transvaser(p , tmp) ;
        transvaser(tmp , q) ;
    }

    // P is destroyed here : not good !
    public static void stablePairsImpairs (Stack<Integer> p , Stack<Integer> q) {
        Stack<Integer> tmp = new Stack<>() ;
        while (!p.empty()) {
            int num = p.pop() ;
            if (num % 2 == 0) {
                q.push(num) ;
            } else {
                tmp.push(num) ;
            }
            deplacer (q , tmp) ;
            transvaser (tmp , q) ;
        }
    }

    public static void stablePairsImpairsBite (Stack<Integer> p , Stack<Integer> q) {
        Stack<Integer> tmp = new Stack<>() ;
        while (!p.empty()) {
            int num = p.pop() ;
            if (num % 2 == 0) {
                q.push(num) ;
            } else {
                int moved = 0 ;
                Integer top = null ;
                if (!q.empty()) {top = q.pop() ;}
                while (!q.empty() && top % 2 == 0) {
                    tmp.push(top) ;
                    moved ++ ;
                    top = q.pop() ;
                }
                q.push(num) ;
                if (moved > 0) {q.push(top) ;} ;
                while (moved > 0) {
                    q.push(tmp.pop()) ;
                    moved -- ;
                }
            }
            tmp.push(num) ;
        }
        transvaser(tmp , p) ;
        transvaser (q , tmp) ;
        deplacer (tmp , q) ;
    }




































    public static int evaluate (String[] expr) {
        Stack<String> s = new Stack<>() ;
        for (int i = 0 ; i < expr.length ; i++) {
            if (expr[i].equals(")")) {
                int b = Integer.valueOf(s.pop()) ;
                
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    public static void main(String[] args) {
        Stack<Integer> s = new Stack<>() ;
        s.push(1) ;
        s.push(2) ;
        s.push(3) ;
        s.push(6) ;
        s.push(9) ;
        s.push(4) ;
        s.push(11) ;
        s.push(16) ;
        Stack<Integer> s2 = new Stack<>() ;
        stablePairsImpairsBite(s , s2) ;
        afficher(s2) ;
    }
}