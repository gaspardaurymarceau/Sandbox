public class ItmQt {
    public String itm ;
    public int qt ;
    ItmQt (String item , int quantity) {
        this.itm = item ;
        this.qt = quantity ;
    }

    @Override
    public String toString () {
        return (qt + " * " + itm) ;
    }
}