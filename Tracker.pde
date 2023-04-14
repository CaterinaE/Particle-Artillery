
interface GameSet {
  public void updateGame( final Game game);
  public void updateGame(final char input, final Game game);
  public void draw(final Game game);
 public boolean change(); 
  public Class<? extends GameSet> willChange();

 }
 
 
class Tracker {
  
  // The game status 
  private GameSet[]  situation;
  private int status;

  public Tracker(final GameSet[]  situation) {
    this. situation =  situation;
    
  }

  public void update(Game game) {
     
    // load the current status
     situation[status].updateGame(game);
  }

  public void update(Game game, final char key) {
   
    
     situation[status].updateGame(key, game);
     testChange();
  }

  public void draw(final Game game) {
    
    // Display the current  game
     situation[status].draw(game);
  }

 
  private void setState(final Class<? extends GameSet> nextGame) {
    for (int i = 0; i <  situation.length; ++i) {
      if (nextGame.isInstance(situation[i])) {
        status = i;
        
      }
    }
  }

  private void testChange() {
    // is the game changing 
    if (situation[status].change()) {
      
      
      setState(situation[status].willChange());
    }
  }
}
