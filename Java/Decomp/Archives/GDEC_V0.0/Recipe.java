import java.util.*;

public class Recipe {
    public final String name ;
    public ItmQt[] ingredients ;
    public Recipe (String name , ItmQt[] ingredients) {
        this.name = name ;
        this.ingredients = ingredients ;
    }
    
    @Override
    public String toString () {
        if (this.ingredients == null) {return this.name + " is a base !" ;}

        String out = "To obtain " + this.name + " you need :\n" ;
        for (int i = 0 ; i < this.ingredients.length ; i++) {
            out += this.ingredients[i].toString() + "\n" ;
        }
        return out ;
    }

    private static String chStackToStr (Stack<Character> s , int size) {
        char[] tempName = new char[size] ;
        for (int j = size - 1 ; j >= 0 ; j--) {
            tempName[j] = s.pop() ;
        }
        return new String(tempName) ;
    }

    public static Recipe readRecipe (String line) {
        int len = line.length() ;
        Stack<Character> reader = new Stack<>() ;
        int readerSize = 0 ;
        Stack<ItmQt> ingStack = new Stack<>() ;
        int ingSize = 0 ;
        int i = 0 ;
        char ch = line.charAt(0) ;

        while (ch != '=') {
            reader.push(ch) ;
            readerSize++ ;
            i++ ;
            ch = line.charAt(i) ;
        }

        i++ ;
        String name = chStackToStr(reader, readerSize) ;
        readerSize = 0 ;
        int qt ;
        String itm ;

        while(i < len) {
            ch = line.charAt(i) ;
            int chAscii = (int) ch;
            while (chAscii >= 48 && chAscii <= 57) {
                reader.push(ch) ;
                readerSize++ ;
                i++ ;
                ch = (i < len) ? line.charAt(i) : ch ;
                chAscii = (int) ch ;
            }

            if (readerSize == 0) {
                qt = 1 ;
            } else {
                qt = Integer.valueOf(chStackToStr(reader , readerSize)) ;
            }
            readerSize = 0 ;

            while (((chAscii >= 65 && chAscii <= 90) || (chAscii >= 97 && chAscii <= 122)) && i < len) {
                reader.push(ch) ;
                readerSize++ ;
                i++ ;
                ch = (i < len) ? line.charAt(i) : ch ;
                chAscii = (int) ch ;
            }
            itm = chStackToStr(reader , readerSize) ;
            readerSize = 0 ;
            ingStack.push(new ItmQt(itm, qt)) ;
            ingSize++ ;
            i++ ;
        }

        ItmQt[] ingredients = new ItmQt[ingSize] ;
        for (int j = ingSize - 1 ; j >= 0 ; j--) {
            ingredients[j] = ingStack.pop() ;
        }
        return new Recipe(name, ingredients) ;
    }

    public static Recipe getRecipe (String itm , Recipe[] catalog) {
        for (int i = 0 ; i < catalog.length ; i++) {
            if (itm.equals(catalog[i].name)) {
                return catalog[i] ;
            }
        }
        Errors.missingRecipe(itm) ;
        return null ;
    }
}