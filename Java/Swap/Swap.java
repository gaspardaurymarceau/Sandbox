public class Swap {
    public static int[] tabSwap (int a , int b , int n) {
        int[] tmp = {a , b} ;
        for (int i = 0 ; i < n ; i++) {
            tmp[0] += tmp[1] ;
            tmp[1] = tmp[0] - tmp[1] ;
            tmp[0] = tmp[0] - tmp[1] ;
        }
        return tmp ;
    }
    public static int[] varSwap (int a , int b , int n) {
        tmp
    }
}