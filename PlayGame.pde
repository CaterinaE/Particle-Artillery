// the playing of the game, this shows the function of the tank and shell

class PlayGame implements GameSet {
  private Class<? extends GameSet> next = PlayGame.class;

  public void updateGame (final char key, Game game) {
    switch (key) {
      
       // will fire the shell
      case  ' ': 
      
      game.shootShell();
      break;  
       
      // move the tanks right or left
      case  'a':
      case 's': 
      
      game.moveTank(key);
        
      break;
      default:
       
       // update the game for the current player
        game.playerTurn().updateGame(key);
    }
  }

  public void updateGame (Game game) {

   
    // the game will end
    if (game.endGame()) {
     
      
      next = Score.class;
    }
    
    
    else {
      
  //the game will updated
  game.update();
 
 
 
    }
  }


  public void draw(final Game game) {
    
    game.draw();
  }


  public boolean change() {
    return next != PlayGame.class;
  }

  public Class<? extends GameSet>  willChange() {
    return next;
  } 
}
