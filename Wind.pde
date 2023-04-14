// the force of the wind
class Wind implements Force {
 
  public static final int windSpeed = 5; 
  private PVector wind = new PVector(0, 0);
    
   // the formula for the vector, force  m*g
  public void update(Particle particle) {
    particle.addForce(wind.mult(0.32));
  }

  public void setterWind() {
    
    // The  movenment of the wind
    this.wind.x = (float) Math.floor(random(10) - windSpeed);
  }
    
   // get the wind to control the movement of the shell
  public float getWind() {
    return wind.x;
  }
}
