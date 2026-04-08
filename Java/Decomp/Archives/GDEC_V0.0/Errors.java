public class Errors {

    public static void firstLineNotABeacon () {
        System.out.println("First line of the file should be a beacon !") ;
        System.out.println("For a reminder, here are the two supported beacons :") ;
        System.out.println(":BASE") ;
        System.out.println(":RECIPE") ;
        System.exit(1);
    }

    public static void goalNotInCata () {
        System.out.println("Target item could not be found in recipes, there could be mistakes in your recipes file") ;
        System.exit(1) ;
    }

    public static void loadError() {
        System.out.println("Error while loading the recipes from the file !");
        System.exit(1);
    }

    public static void missingRecipe(String itm) {
        System.out.println("Recipe for item " + itm + " is missing !") ;
        System.exit(1) ;
    }

    public static void flag (int n) {
        System.out.println("Code execution has reached flag " + n + " !") ;
    }
}
