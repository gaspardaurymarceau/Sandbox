import java.util.LinkedList;

public class Main {

    /*
     * Objectif : Écrire une fonction "explorer" qui résout le labyrinthe.
     *
     * Il n'y a pas besoin de modifier les fichiers Labyrinthe.java et Case.java.
     *
     * On pourra utiliser :
     *
     * - La méthode voisin(char dir) de la classe Case, qui renvoie la case voisine
     * dans la direction donnée ('H', 'B', 'G', 'D'). Attention, cette méthode ne
     * vérifie pas si la case voisine est une case valide.
     *
     * - La méthode deplacer(char dir) de la classe Labyrinthe, qui déplace la
     * position courante dans la direction indiquée ('H', 'B', 'G', 'D').
     * Si la position est invalide, cela déclenche une erreur.
     *
     * - Les méthodes poserUnCaillou() et enleverUnCaillou() de la classe
     * Labyrinthe, qui permettent de marquer la position courante comme
     * déjà visitée.
     *
     * - Les attributs de la classe Labyrinthe :
     * - laby.grille : matrice qui représente le labyrinthe.
     * - laby.tailleX et laby.tailleY : taille du labyrinthe.
     * - laby.entree et laby.sortie : cases d'entrée et de sortie.
     * - laby.position : case courante.
     *
     * Les valeurs dans la grille du labyrinthe sont :
     * - 0 pour un couloir
     * - 1 pour un mur
     * - 2 pour l'entrée
     * - 3 pour la sortie
     * - 4 pour un caillou (case déjà visitée)
     * On peut aussi utiliser les constantes Labyrinthe.COULOIR, etc.
     */

    public static Labyrinthe laby;
    public static LinkedList<Character> sol;

    public static boolean done() {
        return laby.position == laby.sortie;
    }

    public static boolean valid(Case c) {
        return (
            c.x >= 0 &&
            c.y >= 0 &&
            c.x < laby.tailleX &&
            c.y < laby.tailleY &&
            laby.grille[c.x][c.y] != 1 &&
            laby.grille[c.x][c.y] != 4
        );
    }

    public static LinkedList<Character> possible() {
        LinkedList<Character> out = new LinkedList<>();
        for (char dir : new char[] { 'H', 'B', 'G', 'D' }) {
            if (valid(laby.position.voisin(dir))) {
                out.add(dir);
            }
        }
        return out;
    }

    public static char invert(char c) {
        switch (c) {
            case 'G':
                return 'D';
            case 'D':
                return 'G';
            case 'H':
                return 'B';
            case 'B':
                return 'H';
            default:
                return 'E';
        }
    }

    public static boolean explore() {
        if (done()) {
            System.out.println("Solution trouvée :");
            System.out.println(sol);
            return true;
        }
        laby.poserUnCaillou();
        System.out.println(possible());
        for (char c : possible()) {
            sol.addLast(c);
            laby.deplacer(c);
            if (!explore()) {
                sol.removeLast();
                laby.deplacer(invert(c));
            } else {
                return true;
            }
        }
        laby.enleverUnCaillou();
        return false;
    }

    public static void main(String[] args) {
        laby = new Labyrinthe("labyrinthe1.txt");
        sol = new LinkedList<Character>();
        System.out.println(explore());
    }
}
