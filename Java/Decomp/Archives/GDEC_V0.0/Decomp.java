import java.io.BufferedReader ;
import java.io.FileReader ;
import java.util.Stack ;

public class Decomp {

    public static boolean cataLoaded = false ;
    public static Recipe[] catalog ;
    public static Recipe mainRecipe ;


    public static void cataLoad(/*String fileName*/) {
        try {
            Stack<Recipe> tempRecipes = new Stack<>() ;
            int recipeCount = 0 ;
            BufferedReader br = new BufferedReader(new FileReader("test.goldec")) ;
            String strReader = br.readLine() ;
            Line.Beaconed current = Line.Beaconed.NIL ;
            while (strReader != null) {
                Line reader = new Line (strReader , current) ;
                if (reader.isBeacon) {
                    current = Line.readBeacon(strReader) ;
                } else {
                    tempRecipes.push(reader.contents) ;
                    recipeCount++ ;
                }
                strReader = br.readLine() ;
            }

            catalog = new Recipe[recipeCount] ;
            for (int i = recipeCount - 1 ; i >= 0 ; i--) {
                catalog[i] = tempRecipes.pop() ;
            }

            cataLoaded = true ;
            br.close();

        } catch (Exception e) {
            Errors.loadError();
        }
    }

    public static void getMain (String goal) {
        for (Recipe rec : catalog) {
            if (rec.name.equals(goal)) {
                mainRecipe = rec ;
                return ;
            }
        }
        Errors.goalNotInCata() ;
        return ;
    }

    public static boolean based () {
        ItmQt[] ing = mainRecipe.ingredients ;
        if (ing == null) {
            return true ;
        }
        for (int i = 0 ; i < ing.length ; i++) {
            if (Recipe.getRecipe(ing[i].itm, catalog).ingredients != null) {return false ;}
        }
        return true ;
    }


    public static void refine () {
        Stack<ItmQt> tempIng = new Stack<>() ;
        int maxNew = 0 ;
        for (ItmQt ing : mainRecipe.ingredients) {
            ItmQt[] dec = Recipe.getRecipe(ing.itm , catalog).ingredients ;
            if (dec == null) {
                tempIng.push(ing) ;
                maxNew++ ;
            } else {
                for (ItmQt subIng : dec) {
                    tempIng.push(subIng) ;
                    maxNew++ ;
                }
            }
        }
        ItmQt[] tempIngTab = new ItmQt[maxNew];
        int write = 0 ;
        boolean placed ;
        while (!tempIng.empty()) {
            ItmQt ing = tempIng.pop() ;
            placed = false ;
            for (int i = 0 ; i < write ; i++) {
                if ((!placed) && ing.itm.equals(tempIngTab[i].itm)) {
                    tempIngTab[i].qt += ing.qt ;
                    placed = true ;
                }
            }
            if (!placed) {
                    tempIngTab[write] = ing ;
                    write++ ;
            }
        }
        ItmQt[] nextItems = new ItmQt[write] ;
        for (int i = 0 ; i < write ; i++) {
            nextItems[i] = tempIngTab[i] ;
        }
        mainRecipe.ingredients = nextItems ;
    }

    public static void main (String[] args) {
        String goal = args[0] ;
        // String filePath = args[1] ;
        cataLoad(/*filePath*/) ;
        getMain(goal) ;
        while (!based()) {
            refine() ;
        }
        System.out.println(mainRecipe) ;
    }
}
