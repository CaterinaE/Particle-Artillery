 // The shape, color and size of the shell

class Shell extends Particle {
 
  public Shell(final PVector position) {
    
    // this is the weight of the shell
    super(position, 100);
  }

  public void draw() { 
    
     //inside the circle is orange 
    fill(248, 91, 1) ;
   
   // the boarder is red
    stroke(255,0,0);
    // look like a fire ball
     ellipse( positionGrav().x, positionGrav().y, 10, 10);
  }
}

   
