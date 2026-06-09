import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.LinkedList;

public class Sudoku {

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
                        sudoku[i][j] = Character.getNumericValue(
                            line.charAt(j)
                        );
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

    public static Case nextEmpty(int[][] sudoku) {
        for (int i = 0; i < 9; i++) {
            for (int j = 0; j < 9; j++) {
                if (sudoku[i][j] == 0) return new Case(i, j);
            }
        }
        return null;
    }

    public static LinkedList<Integer> possible(int[][] sudoku, Case c) {
        LinkedList<Integer> out = new LinkedList<>();
        for (int k = 1; k < 10; k++) {
            boolean found = false;
            for (int i = 0; i < 9; i++) {
                found |= (sudoku[i][c.y] == k || sudoku[c.x][i] == k);
            }
            int xs = c.x / 3;
            int ys = c.y / 3;
            for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                    found |= (sudoku[3 * xs + i][3 * ys + j] == k);
                }
            }
            if (!found) out.add(k);
        }
        return out;
    }

    public static boolean resoudre(int[][] sudoku) {
        Case next = nextEmpty(sudoku);
        if (next == null) {
            afficheSudoku(sudoku);
            return true;
        }
        for (int i : possible(sudoku, next)) {
            sudoku[next.x][next.y] = i;
            if (resoudre(sudoku)) {
                return true;
            }
            sudoku[next.x][next.y] = 0;
        }
        return false;
    }

    public static void main(String[] args) {
        int[][] sudoku = readSudokuFromFile("mysudok.txt");
        afficheSudoku(sudoku);
        resoudre(sudoku);
        afficheSudoku(sudoku);
    }
}
