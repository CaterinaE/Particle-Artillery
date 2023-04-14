//the tank movements and colors 
class Tank {
  public static final int speedOfBall = 3;

  private PVector position, direction;
  private float elevation = 45;
  private int power = 10;

  public final int width;
  public final int height;

  public Tank(final PVector position, final PVector direction, final int widthTank, final int heightTank) {
    this.position = position;
    this.direction = direction;
    width = widthTank;
    height = heightTank;
  }
  
  
   // press the keys to interact with the tank
  public void updateGame(final char key) {
   
    
    
    switch (key) {
     
      
      // increase the power 
      case '+':
        power++;
        break;
       
   // decrease the power 
      case '-':
        if (power > 1) {
          power--;
        }
        break;
 
     
       //decrease the elevation
      case 'e':
        elevation--;
        break;
        
         //increase the elevation
      case 'w':
        elevation++;
        break;
    }
  }


   // the tank will move left
  public void moveLeft(final float distance) {
    position.x =   position.x- distance;
  }

      // the tank will move right
  public void moveRight(final float distance) {
    position.x =   position.x + distance;
  }

   //dark green rectangle and a black boarder
  public void draw() {
    
    strokeWeight(3); 
    stroke(0);
    fill(119, 147, 63);
    rect(position.x, 650, 75, 50);
  }

  public PVector setDirection(PVector vector) {
    // Set a vector's direction for the gun's current direction
    vector.x =   vector.x * direction.x;
    vector.y =   vector.y * direction.y;
    return vector;
  }

   // there needs to be a get or the shell wont display
  public PVector positionOfTank() {
     return position.get();
     
  }


  //elevation of the shell
  public float elevate() {
    return elevation;
  }


  // how quickly the shell will be 
  public int getPower() {
    return power;
  }


  // this will control the movement of the shell used sin and cos to cal the elevation
  public PVector elevatVector() {
    
    // the movement of the gun in the x axis 
    final float x = (float) Math.cos(Math.toRadians(elevation));
    
    //movement of the y axis 
    final float y = (float) -Math.sin(Math.toRadians(elevation));
    
    return new PVector(x, y);
  }
}
