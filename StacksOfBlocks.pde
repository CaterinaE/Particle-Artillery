
import java.util.LinkedList;
import java.util.List;

class StackOfBlocks {
  
  
  public List<Block> newBlocks() {
    
    
    int i = 2;
    final PVector position = new PVector(440, 200);

    List<Block> stack = new LinkedList<Block>();
    for (int col = 0; col < 7; ++col) { 
      
    if ( Math.random() < 3){
      
       i= getPoissonRandom(5);
   } 
        
        
      for (int row = 0; row < i; ++row) {
       
        // the position of the blocks
        final PVector newPosition  = position.get();
         newPosition.x  =  newPosition.x  +  col * 70; 
         newPosition.y =   newPosition.y  -  row * 50;
        
        
        // Create the block
        final Block block = new Block(newPosition);
        
        stack.add(block);
      }
    }
    return stack;
  }
  
   // generate poisson arrival 
  private int getPoissonRandom(final double m) {
    final double e = Math.exp(-m);
   
    int i = 0;
    double j = 1;
    
    do {
      ++i;
     j = j*  Math.random();
    } 
    
    while (j > e);
    
    return i - 1;
  }
}
