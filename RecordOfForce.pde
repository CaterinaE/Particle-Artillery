// the record force of thr particle
import java.util.*;

interface Force  {
  public void update(Particle particle);
}

 

class RecordOfForce {
  // The  particles are being recorded
  private Map<Force , Set<Particle>> recorded;

  public  RecordOfForce() {
     
    recorded = new HashMap<Force , Set<Particle>>();
  }

  public void record(final Force force , final Particle particle) {
    Set<Particle> particles = recorded.get(force);
    
    
    if (particles == null) {
      
      
      // record the new particle
      particles = new HashSet<Particle>();
      recorded.put(force , particles);
    }
    
    // the particle is set
    if (!particles.contains(particle)) {
      particles.add(particle);
    }
  }

  public void removeRecord(final Force  force , final Particle particle) {
    Set<Particle> particles = recorded.get(force);
    
    // remove the particle
    if (particles != null) {
      particles.remove(particle);
    }
  }

  public void clearRecord() {
    recorded.clear();
  }

  public void updateForces() { 
    
    //this will update the forces 
    for (final Map.Entry<Force , Set<Particle>> record : recorded.entrySet()) {
       Force force = record.getKey();
      
      // Record the particle 
      for (Particle particle : record.getValue()) {
        force .update(particle);
      }
    }
  }
}
