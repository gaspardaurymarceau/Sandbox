import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

/*
 * Classe pour représenter un labyrinthe
 *
 * Le labyrinthe est représenté par une matrice d'entiers :
 * - 0 pour un couloir
 * - 1 pour un mur
 * - 2 pour l'entrée
 * - 3 pour la sortie
 * - 4 pour une case déjà visitée (caillou)
 *
 * La case (0,0) est en bas à gauche
 * La case (tailleX - 1, tailleY - 1) est en haut à droite
 */

public class Labyrinthe {

    public int[][] grille;
    public int tailleX;
    public int tailleY;

    public Case entree;
    public Case sortie;
    public Case position;

    // Constantes pour les valeurs dans le labyrinthe
    // exemple : grille[i][j] == 1 pour un mur
    public static final int COULOIR = 0;
    public static final int MUR = 1;
    public static final int ENTREE = 2;
    public static final int SORTIE = 3;
    public static final int CAILLOU = 4;

    public Labyrinthe(String fileName) {
        int[][] grille = null;
        try (BufferedReader br = new BufferedReader(new FileReader(fileName))) {
            String line = br.readLine();
            String[] dimensions = line.split(" ");
            int tailleX = Integer.parseInt(dimensions[0]);
            int tailleY = Integer.parseInt(dimensions[1]);
            grille = new int[tailleX][tailleY];
            for (int j = tailleY - 1; j >= 0; j--) {
                // La première ligne lue est en haut du labyrinthe, donc j = tailleY - 1.
                line = br.readLine();
                for (int i = 0; i < tailleX; i++) {
                    char cell = line.charAt(i);
                    switch (cell) {
                        case ' ':
                            grille[i][j] = COULOIR;
                            break;
                        case '#':
                            grille[i][j] = MUR;
                            break;
                        case 'E':
                            grille[i][j] = ENTREE;
                            this.entree = new Case(i, j);
                            this.position = new Case(i, j);
                            break;
                        case 'S':
                            grille[i][j] = SORTIE;
                            this.sortie = new Case(i, j);
                            break;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        this.grille = grille;
        this.tailleX = grille.length;
        this.tailleY = grille[0].length;
        StdDraw.setCanvasSize(tailleX * 25, tailleY * 25);
        StdDraw.setXscale(0, tailleX);
        StdDraw.setYscale(0, tailleY);
        StdDraw.enableDoubleBuffering();
        StdDraw.setPenRadius(0.005);
        this.draw();
    }

    // Affichage du labyrinthe
    private void draw() {
        StdDraw.clear();
        for (int i = 0; i < tailleX; i++) {
            for (int j = 0; j < tailleY; j++) {
                int cell = grille[i][j];
                double x = i + 0.5;
                double y = j + 0.5;
                switch (cell) {
                    case COULOIR:
                        StdDraw.setPenColor(StdDraw.WHITE);
                        StdDraw.filledSquare(x, y, 0.5);
                        break;
                    case MUR:
                        StdDraw.setPenColor(StdDraw.GRAY);
                        StdDraw.filledSquare(x, y, 0.5);
                        break;
                    case SORTIE:
                        StdDraw.setPenColor(StdDraw.ORANGE);
                        StdDraw.filledSquare(x, y, 0.25);
                        break;
                    case CAILLOU:
                        StdDraw.setPenColor(StdDraw.BLACK);
                        StdDraw.filledSquare(x, y, 0.25);
                        break;
                }
            }
        }
        StdDraw.setPenColor(StdDraw.BLUE);
        StdDraw.filledSquare(position.x + 0.5, position.y + 0.5, 0.25);
        StdDraw.square(position.x + 0.5, position.y + 0.5, 0.4);
        StdDraw.show();
        StdDraw.pause(50);
    }

    // Se déplace dans la direction donnée
    // dir = 'G' pour gauche, 'D' pour droite, 'H' pour haut, 'B' pour bas
    public void deplacer(char dir) {
        Case next = position.voisin(dir);
        if (
            next.x < 0 || next.x >= tailleX || next.y < 0 || next.y >= tailleY
        ) {
            StdDraw.close();
            throw new IllegalArgumentException("Sorti du labyrinthe: " + next);
        }
        if (grille[next.x][next.y] == MUR) {
            StdDraw.close();
            throw new IllegalArgumentException(
                "Impossible de se déplacer dans un mur: " + next
            );
        }
        position = next;
        draw();
    }

    public void poserUnCaillou() {
        grille[position.x][position.y] = CAILLOU;
    }

    public void enleverUnCaillou() {
        grille[position.x][position.y] = COULOIR;
    }
}
