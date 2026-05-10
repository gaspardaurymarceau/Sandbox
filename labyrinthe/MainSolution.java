import java.util.*;

public class MainSolution {

    public static Labyrinthe laby;
    public static Stack<Character> chemin = new Stack<>();

    // Vérifie si la sortie est atteinte
    // La position actuelle est dans laby.position
    public static boolean sortieAtteinte() {
        return laby.position.equals(laby.sortie);
    }

    // Vérifie si la case est dans les limites du labyrinthe
    public static boolean caseValide(Case c) {
        return (c.x >= 0 && c.x < laby.tailleX
                && c.y >= 0 && c.y < laby.tailleY);
    }

    // Vérifie si la case est libre et n'a pas déjà été visitée
    public static boolean caseLibre(Case c) {
        return (laby.grille[c.x][c.y] != Labyrinthe.MUR
                && laby.grille[c.x][c.y] != Labyrinthe.CAILLOU);
    }

    // Renvoie la liste des déplacements possibles à partir de la case c
    public static List<Character> deplacementsPossibles(Case c) {
        LinkedList<Character> possibles = new LinkedList<>();
        for (char dir : new char[] { 'H', 'B', 'G', 'D' }) {
            Case next = c.voisin(dir);
            if (caseValide(next) && caseLibre(next)) {
                possibles.add(dir);
            }
        }
        return possibles;
    }

    // Renvoie la direction opposée à celle donnée en entrée
    public static char directionOpposee(char dir) {
        switch (dir) {
            case 'G':
                return 'D';
            case 'D':
                return 'G';
            case 'H':
                return 'B';
            case 'B':
                return 'H';
            default:
                throw new IllegalArgumentException("Direction invalide: " + dir);
        }
    }

    // Explore le labyrinthe avec la méthode de backtracking
    public static boolean explorer() {
        if (sortieAtteinte()) {
            System.out.println("Sortie atteinte !");
            return true;
        }

        laby.poserUnCaillou();
        for (char dir : deplacementsPossibles(laby.position)) {
            chemin.push(dir);
            laby.deplacer(dir);
            if (explorer()) {
                return true;
            }
            chemin.pop();
            laby.deplacer(directionOpposee(dir));
        }
        laby.enleverUnCaillou();
        return false;
    }

    public static void main(String[] args) {
        laby = new Labyrinthe("labyrinthe1.txt");
        if (explorer()) {
            System.out.println("Solution : " + chemin);
        } else {
            System.out.println("Aucun chemin trouvé.");
        }
    }
}
