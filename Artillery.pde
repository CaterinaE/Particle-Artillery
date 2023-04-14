PImage img;
PFont f;

Game game;
Tracker tracker;

void setup() {
  img = loadImage("land.jpg");
  fullScreen(); 

  final PlayGame playTheGame = new PlayGame();
  final Score score = new Score();
  
  
  // this is for the main menu will show only the player vs player can click zero to start
   final  MainMenu menu = new  MainMenu(  new MenuOption[] {
     new MenuOption( 1, PlayGame.class), 
  
      });
      
     
  tracker = new Tracker(new GameSet[] { menu, playTheGame, score });


  // the font of the text
  f = createFont("Arial",30,true);  


 
  game = new Game(new int[] { 1, 2 });
}


// the text and image for the game
void draw() {
  image(img,0,0); // Using instead of background();
  textFont(f);
  fill(255);
   
  // the text is centered 
  textAlign(CENTER);
  text("Particle Artillery",660,250);
  
  
  // Will update the current game  
  tracker.update(game);
  
  // Display the 
  tracker.draw(game);
}


// enter the commands to start and play game
 void keyPressed() {
 
  
  tracker.update(game, key);
}
