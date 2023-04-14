 // The gravity of the blocks and shell

class Gravity implements Force {
  private PVector gravity;

  public Gravity(final float gravity) {
  
    // the gravity for the game 
    this.gravity = new PVector(0, gravity);
  }
 
  // the update of the force of gravity 
  public void update(Particle particle) {
    
    particle.addForce(gravity);
  }
}
