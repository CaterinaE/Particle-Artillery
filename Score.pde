// this is the info of the players scores and will display the winner at the end of the game
class Score implements GameSet {
  
  
  private Class<? extends GameSet> nextGame = Score.class;

  public void updateGame(final Game game) {
    // default 
  }

//go back to main menu
  public void updateGame (final char input, final Game game) {
    if (input == ENTER) {
       
      nextGame = MainMenu.class;
  }}

  public void draw(final Game game) {
      background(255);

    // Determine who wins the game
    final int[] playScore = game.playersScore();
    final int winner =  playScore[0] >  playScore[1] ? 1 : 2;
   
     fill(0);
    textAlign(CENTER, TOP);
    textSize(100);
    text("Winner! Player " + winner, 450, 250); 
    textSize(50);
    text("Enter: To return to main menu",  450, 550); 

  }

  public boolean change() {
    return nextGame != Score.class;
  }

  public Class<? extends GameSet>  willChange() {
    game = game.reset();
    return nextGame;
  }

   
}
