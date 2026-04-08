public class ChangeListInFor {
    public static main void (String[] args) {}
        int[] test = new int[10] ;
        for (int i = 0 ; i < test.length ; i++) {
            test = new int[10 - i] ;
        }
        System.out.println(test.length) ;
    }
}