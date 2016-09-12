import syntaxtree.*;
import visitor.*;

public class Main {
   public static void main(String [] args) {
      try {
         Node root = new MiniJavaParser(System.in).Goal();
         System.out.println("Program parsed successfully");
         root.accept(new sample(),null);
         root.accept(new SecondParse(),null);
      }
      catch (ParseException e) {
         System.out.println(e.toString());
      }
   }
} 



