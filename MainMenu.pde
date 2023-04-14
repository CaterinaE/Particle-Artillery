
class  MainMenu implements GameSet {
  // the change
  private Class<? extends GameSet> next =  MainMenu.class;

  // These will be displayed on the screen
   private MenuOption[] options;

   int index = 1;

  public MainMenu( final MenuOption[] options) {
    this.options = options;
  }

  public void updateGame(final char input, Game game) {
     
    
  
      // No option is currently being set
      pickAOption(Character.getNumericValue(input));
    }
   

  public void updateGame(Game game) {
    // default
  }
 

  private void pickAOption(final int index) {
 
    final MenuOption option = options[index];
      next = option.willChange;
  }
  
  
  public void draw(final Game game) {
  
    
    textSize(25);
    textAlign(LEFT, TOP);
    text("Enter 0 to play: Player 1 vs Player 2", 20, 90);
    text("a: Move the tank to the left", 20, 130);
    text("s: Move the tank to the right", 20, 160); 
    text("w: Increase shooting of the shell", 20, 190); 
    text("e: Decrease shooting of the shell", 20, 220); 
    text("+: Increase the power of the gun", 20, 250); 
    text("-: Decrease the power of the gun", 20, 280);
    text("SpaceBar: movement of a shell", 20, 310);
    
  }

 // get the options from the menu
  public int[] getOptions() {
    
    int[] values = new int[options.length];
    for (int i = 0; i < options.length; ++i) {
      values[i] = options[i].theValue();
    }
    return values;
  }
 
  

  public boolean change() {
    return next !=  MainMenu.class;
  }

  public Class<? extends GameSet> willChange() {
     game.options();
    //create the game
    game.createGame();
    return next;
  }

  public void resetTransition() {
    next =  MainMenu.class;
  }
}

  // A menu option
public static class MenuOption {
   public final  def; // default value
  
  
  public final Class<? extends GameSet>  willChange;

  private int value;

  // the single value to pick from
  public MenuOption( final int def, Class<? extends GameSet> willChange) {
    
    this.def = def;
    value = def;
    this.willChange =  willChange;
  }

  public void setTheValue(final int value) {
    
      this.value = value;
    
  }

  public int theValue() {
    return value;
  }
}
