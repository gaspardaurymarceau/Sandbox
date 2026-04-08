import java.awt.event.* ;
import java.io.BufferedReader;
import java.io.FileReader;
import java.awt.* ;
import javax.swing.* ;
import java.util.Random ;


public class PPanel extends JPanel implements ActionListener {


    static final int WIDTH = 800 ;
    static final int HEIGHT = 600 ;
    int lives = 7 ;
    boolean running = false ;
    Random random ;
    String word ;
    String playfield ;
    static final String dictName = "dico_fr.txt" ;
    static final int dictSize = 336531 ;
    static final String[] dict = new String[dictSize] ;
    static boolean dictLoaded = false;


    PPanel () {
        random = new Random() ;
        this.setPreferredSize(new Dimension(WIDTH , HEIGHT)) ;
        this.setBackground(Color.black) ;
        this.setFocusable(true) ;
        this.addKeyListener(new userInput()) ;
        startGame() ;
    }

    
    public void startGame () {
        genWord() ;
        running = true ;
    }

    public static void loadError() {
        System.out.println("Erreur de chargement du fichier texte !");
        System.exit(1);
    }

    public static void loadDict() {
        try {
            BufferedReader br = new BufferedReader(new FileReader(dictName)) ;
            for (int i = 0; i < dictSize; i++) {
                dict[i] = br.readLine() ;
                if (dict[i] == null) {
                    loadError() ;
                }
            }
            dictLoaded = true ;
            br.close() ;
        } catch (Exception e) {
            loadError() ;
        }
    }

    public void genWord () {
        int pos = random.nextInt(dictSize) ;
        System.out.println(pos) ;
    }

    @Override
    public void actionPerformed (ActionEvent e) {
        if (running) {
        }
        repaint() ;
    }

    public class userInput extends KeyAdapter {
        @Override
        public void keyPressed (KeyEvent e) {

        }
    }
}
