/*
 * Classe pour représenter une case dans le labyrinthe
 * Chaque case est définie par ses coordonnées (x, y)
 */

public class Case {

    public int x;
    public int y;

    public Case(int x, int y) {
        this.x = x;
        this.y = y;
    }

    public String toString() {
        return "(" + this.x + "," + this.y + ")";
    }

    public boolean equals(Case other) {
        return this.x == other.x && this.y == other.y;
    }

    // Renvoie la case voisine dans la direction donnée
    // Ne vérifie pas les limites du labyrinthe ou les murs
    // dir = 'G' pour gauche, 'D' pour droite, 'H' pour haut, 'B' pour bas
    public Case voisin(char dir) {
        switch (dir) {
            case 'G':
                return new Case(x - 1, y);
            case 'D':
                return new Case(x + 1, y);
            case 'H':
                return new Case(x, y + 1);
            case 'B':
                return new Case(x, y - 1);
            default:
                throw new IllegalArgumentException(
                    "Direction invalide: " + dir
                );
        }
    }
}
