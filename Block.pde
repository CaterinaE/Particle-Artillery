//the blocks being used for the game
import java.util.*;

class Block extends Particle {

  public Block(final PVector position) {
   
    // the weight of the block
    super(position, 100);
  }


    // the colors of the blocks black rect with white boarders
  public void draw() {
      strokeWeight(3);
      stroke(255);
      fill(0);
      
      // the position of the gravity
      rect(positionGrav().x, positionGrav().y, 70, 40);
  }
 
  public boolean stacking(final float ground, final List<Block> blocks) {
   
    // ground is set to 700 
    if (positionGrav().y + 40 >= ground) {
      
      return true;
    }
    
     for (final Block block : blocks) {
    
        // this makes the blocks stack with each other
      if (block != this && positionGrav().x == block.positionGrav().x &&  block.positionGrav().y - positionGrav().y >= 0 &&   block.positionGrav().y - positionGrav().y <= 40) {
       
    return true;
      }
    }
    
    return false;
  }
}
