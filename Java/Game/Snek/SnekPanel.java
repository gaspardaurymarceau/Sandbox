import java.awt.event.* ;
import java.awt.* ;
import javax.swing.* ;
import java.util.Random ;


public class SnekPanel extends JPanel implements ActionListener {


    static final int WIDTH = 800 ;
    static final int HEIGHT = 600 ;
    static final int UNIT_SIZE = 25 ;
    static final int GAME_UNITS = (WIDTH * HEIGHT) / UNIT_SIZE ;
    static final int DELAY = 150 ;
    final int x[] = new int[GAME_UNITS] ;
    final int y[] = new int[GAME_UNITS] ;
    int bodyParts = 6 ;
    int applesEaten = 0 ;
    int appleX ;
    int appleY ;
    char direction = 'R' ;
    Color bodyColor = new Color(0 , 218 , 186) ;
    boolean running = false ;
    Timer timer ;
    Random random ;


    SnekPanel () {
        random = new Random() ;
        this.setPreferredSize(new Dimension(WIDTH , HEIGHT)) ;
        this.setBackground(Color.black) ;
        this.setFocusable(true) ;
        this.addKeyListener(new MKA()) ;
        startGame() ;
    }

    public void startGame() {
        spawnApple() ;
        running = true ;
        timer = new Timer(DELAY , this) ;
        timer.start() ;
    }

    public void paintComponent (Graphics g) {
        super.paintComponent(g) ;
        draw(g) ;
    }

    public void draw (Graphics g) {
        if (running) {
            /*for (int i = 0 ; i < WIDTH ; i++) {
                g.drawLine(i * UNIT_SIZE , 0 , i * UNIT_SIZE , HEIGHT) ;
                g.drawLine(0 , i * UNIT_SIZE , WIDTH , i * UNIT_SIZE) ;
            }*/
            g.setColor(Color.red) ;
            g.fillOval(appleX , appleY , UNIT_SIZE , UNIT_SIZE) ;
            g.setColor(Color.green) ;
            g.fillRect(x[0], y[0], UNIT_SIZE, UNIT_SIZE) ;
            g.setColor(bodyColor);
            for (int i = 1 ; i < bodyParts ; i++) {
                g.fillRect(x[i], y[i], UNIT_SIZE, UNIT_SIZE); ;
            }
        } else {
            gameOver(g) ;
        }
        g.setColor(Color.red) ;
        g.setFont(new Font("Ink Free" , Font.BOLD , 40)) ;
        FontMetrics metrics = getFontMetrics(g.getFont()) ;
        g.drawString("Score: "+applesEaten, (WIDTH - metrics.stringWidth("Score: "+applesEaten)) / 2, g.getFont().getSize());
    }

    public void spawnApple () {
        appleX = random.nextInt((int)(WIDTH / UNIT_SIZE)) * UNIT_SIZE ;
        appleY = random.nextInt((int)(HEIGHT / UNIT_SIZE)) * UNIT_SIZE ;
    }
    
    public void move () {
        for (int i = bodyParts ; i > 0 ; i--) {
            x[i] = x[i - 1] ;
            y[i] = y[i - 1] ;
        }
        switch(direction) {
            case 'U' :
                y[0] -= UNIT_SIZE ;
                break ;
            case 'D' :
                y[0] += UNIT_SIZE ;
                break ;
            case 'R' :
                x[0] += UNIT_SIZE ;
                break ;
            case 'L' :
                x[0] -= UNIT_SIZE ;
                break ;
        }
    }

    public void checkApple () {
        if (x[0] == appleX && y[0] == appleY) {
            bodyParts++ ;
            applesEaten++ ;
            spawnApple() ;
            bodyColor = new Color(random.nextInt(255) , random.nextInt(255) , random.nextInt(255)) ;
        }
    }

    public void checkCollision () {
        if (x[0] < 0 || x[0] > WIDTH || y[0] < 0 || y[0] > HEIGHT) {
            running = false ;
        }
        for (int i = bodyParts ; i > 0 ; i--) {
            if (x[i] == x[0] && y[i] == y[0]) {
                running = false ;
            }
        }
        if (!running) {
            timer.stop() ;
        }
    }

    public void gameOver(Graphics g) {
        g.setColor(Color.red) ;
        g.setFont(new Font("Ink Free" , Font.BOLD , 75)) ;
        FontMetrics metrics = getFontMetrics(g.getFont()) ;
        g.drawString("Game Over", (WIDTH - metrics.stringWidth("Game over")) / 2, HEIGHT / 2);
        g.setColor(Color.red) ;
        g.setFont(new Font("Ink Free" , Font.BOLD , 40)) ;
        FontMetrics scoreMetrics = getFontMetrics(g.getFont()) ;
        g.drawString("Score: "+applesEaten, (WIDTH - scoreMetrics.stringWidth("Score: "+applesEaten)) / 2, g.getFont().getSize());
    }

    @Override
    public void actionPerformed (ActionEvent e) {
        if (running) {
            move() ;
            checkApple() ;
            checkCollision() ;
        }
        repaint() ;
    }

    public class MKA extends KeyAdapter {
        @Override
        public void keyPressed (KeyEvent e) {
            switch(e.getKeyCode()) {
                case KeyEvent.VK_Q :
                    if (!(direction == 'R')) {
                        direction = 'L' ;
                    } break ;
                case KeyEvent.VK_D :
                    if (!(direction == 'L')) {
                        direction = 'R' ;
                    } break ;
                case KeyEvent.VK_Z :
                    if (!(direction == 'D')) {
                        direction = 'U' ;
                    } break ;
                case KeyEvent.VK_S :
                    if (!(direction == 'U')) {
                        direction = 'D' ;
                    } break ;
            }
        }
    }
}
