import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

class Case {
    int x;
    int y;

    public Case(int x, int y) {
        this.x = x;
        this.y = y;
    }
}

public class SudokuSolution {

    public static int nbAppels = 0;

    public static int[][] readSudokuFromFile(String filePath) {
        int[][] sudoku = new int[9][9];
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            for (int i = 0; i < 9; i++) {
                line = br.readLine();
                for (int j = 0; j < 9; j++) {
                    if (line.charAt(j) == '.') {
                        sudoku[i][j] = 0;
                    } else {
                        sudoku[i][j] = Character.getNumericValue(line.charAt(j));
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return sudoku;
    }

    public static void afficheSudoku(int[][] sudoku) {
        System.out.println("┌───────┬───────┬───────┐");
        for (int i = 0; i < 9; i++) {
            System.out.print("│ ");
            for (int j = 0; j < 9; j++) {
                if (sudoku[i][j] == 0) {
                    System.out.print("· ");
                } else {
                    System.out.print(sudoku[i][j] + " ");
                }
                if (j % 3 == 2) {
                    System.out.print("│ ");
                }
            }
            System.out.println();
            if (i == 2 || i == 5) {
                System.out.println("├───────┼───────┼───────┤");
            }
            if (i == 8) {
                System.out.println("└───────┴───────┴───────┘");
            }
        }
    }

    public static Case prochaineCaseVide(int[][] sudoku) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (sudoku[i][j] == 0) {
                    return new Case(i, j);
                }
            }
        }
        return null;
    }

    public static List<Integer> valeursPossibles(int[][] sudoku, Case c) {
        List<Integer> possibles = new LinkedList<>();
        boolean[] rencontre = new boolean[10];

        for (int i = 0; i < 9; i++) {
            rencontre[sudoku[c.x][i]] = true;
            rencontre[sudoku[i][c.y]] = true;
        }

        int carreX = (c.x / 3) * 3;
        int carreY = (c.y / 3) * 3;

        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                rencontre[sudoku[carreX + i][carreY + j]] = true;
            }
        }

        for (int num = 1; num <= 9; num++) {
            if (!rencontre[num]) {
                possibles.add(num);
            }
        }
        return possibles;
    }

    public static void resoudre(int[][] sudoku) {
        nbAppels++;
        Case c = prochaineCaseVide(sudoku);
        if (c == null) {
            System.out.println("Solution trouvée :");
            afficheSudoku(sudoku);
            System.out.println("Nombre d'appels récursifs : " + nbAppels);
            return;
        }

        for (int val : valeursPossibles(sudoku, c)) {
            sudoku[c.x][c.y] = val;
            resoudre(sudoku);
            sudoku[c.x][c.y] = 0;
        }
    }

    public static void main(String[] args) {
        int[][] sudoku = readSudokuFromFile("sudoku1.txt");
        resoudre(sudoku);
    }

}