public class Line {
    public enum Beaconed {BASE , RECIPE , NIL}
    public boolean isEmpty ;
    public boolean isBeacon ;
    public Recipe contents ;
    public Line (String line , Beaconed b) {
        if (line.length() == 0){
            this.isEmpty = true ;
            this.isBeacon = false ;
            this.contents = null ;
        } else {
            this.isEmpty = false ;
            if (line.charAt(0) == ':') {
                this.isBeacon = true ;
                this.contents = null ;
            } else {
                this.isBeacon = false ;
                this.contents = read(line , b) ;
            }
        }
    }

    public static Beaconed readBeacon (String line) {
        if (line.equals(":BASE")) {return Beaconed.BASE ;}
        if (line.equals(":RECIPE")) {return Beaconed.RECIPE ;}
        Errors.firstLineNotABeacon() ;
        return Beaconed.NIL ;
    }

    private static Recipe read (String l , Beaconed b) {
        if (b == Beaconed.BASE) {
            return new Recipe (l , null) ;
        } else {
            return Recipe.readRecipe(l) ;
        }
    }
}
