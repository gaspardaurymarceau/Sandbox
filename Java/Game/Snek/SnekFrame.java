import javax.swing.JFrame ;

public class SnekFrame extends JFrame {

    /*private static final int WIDTH = 800 ;
    private static final int HEIGHT = 600 ;*/
    SnekFrame () {
        this.add(new SnekPanel()) ;
        this.setTitle("snek") ;
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE) ;
        this.setResizable(false) ;
        /*this.setSize(WIDTH, HEIGHT);*/
        this.pack() ;
        this.setLocationRelativeTo(null) ;
        this.setVisible(true) ;
    }
}