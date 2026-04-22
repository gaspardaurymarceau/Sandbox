package Chore;
public class Chore {

    public static String pickone (String[] tasks) {
        int pick = (int) Math.ceil ((double) (Math.random() * tasks.length)) - 1 ;
        return tasks[pick] ;
    }

    public static void main (String[] args) {
        System.out.println(Texts.kicker + pickone (Texts.tasks));
    }
}
