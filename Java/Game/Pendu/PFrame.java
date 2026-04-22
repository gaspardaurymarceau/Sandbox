import javax.swing.JFrame ;

public class PFrame extends JFrame {

    /*private static final int WIDTH = 800 ;
    private static final int HEIGHT = 600 ;*/
    PFrame () {
        this.add(new PPanel()) ;
        this.setTitle("Pendu") ;
        this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE) ;
        this.setResizable(false) ;
        /*this.setSize(WIDTH, HEIGHT);*/
        this.pack() ;
        this.setLocationRelativeTo(null) ;
        this.setVisible(true) ;
    }
}