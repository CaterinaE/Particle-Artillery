 
class Particle {
  //  The wind  resistance
  public static final float damping = 0.998;
 
  private PVector position, velocity, forceGravWind;
  private final float invMass; 
  
  // determining the force 
  public Particle(final PVector position, final float mass) {
    this.position = position ;
    velocity = new PVector(0, 0);
    invMass = 1 / mass;
    clearforceGravWind();
  }

  public void update() {
    // Update the position
    position.add(velocity);
    // Calculate the acceleration
    PVector accel = forceGravWind.mult(invMass);
     
      velocity.mult(damping);
     velocity.add(accel);
    
    //  remove the force of the wind and gravity
    clearforceGravWind() ;
  }

  public void addForce(final PVector force) {
    forceGravWind.add(force);
  }

  public void setVelocity(final PVector velocity) {
    this.velocity = velocity;
  }
 
  public PVector positionGrav() {
    return position;
  }
  
  
  // will remove the gravity and wind and update it
  private void clearforceGravWind() {
     forceGravWind = new PVector(0, 0);
  }
}
