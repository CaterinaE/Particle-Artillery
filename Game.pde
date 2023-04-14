 

  import java.awt.geom.*;
  import java.*;
  
  class Game {
 
   // the power of the tank
    public static final float powerOfTank = 0.8;
    
    private  RecordOfForce forces = new  RecordOfForce();
    private int ground;
    private Tank[] players;
    private int[] score;
    private int turn = 0;
    private Shell shell;
  
    private int[] indices;
   
    private List<Block> stack;
    private Gravity gravity;
    private Wind wind = new Wind();
   
  
    public Game(final int[] optionIndices) {
      // the options from the main menu
      indices = optionIndices;
    }
  
    public Game reset() {
      return new Game(indices);
    }
  
    public void options() {
     
      // gravity is set to 10
       gravity = new Gravity(10);
    }
    
    // create the game
    public void createGame() {
       wind.setterWind();
      
      
      // the ground level for the blocks 
      ground = 700;
      
      // the stack of  blocks
      stack = new StackOfBlocks().newBlocks();
  
  
   
   // these will display the tanks in the game
      players = new Tank[] { 
            //display tank one 
           new Tank(new PVector(100, 650), new PVector(1, 1), 75, 50),
           
         //display tank two
         new Tank(new PVector(1200, 650), new PVector(-1, 1), 75, 50)};
      
      
      // the sorces are set to zero
      score = new int[players.length];
      
      for (int i = 0; i < score.length; ++i) {
        
        score[i] = 0;
      }
    }
  
    private int nextPlayer() {
      // What is the next player's index
      return (turn + 1) % players.length;
    }
  
    public void nextTurn() {
      
      turn = nextPlayer();
       wind.setterWind();
     
    }
  
    public Tank playerTurn() {
      
      return players[turn];
    }
  
  
   
    public boolean endGame() {
      
      //the player must win by 5 points 
      for (final int score : score) {
        if (score >= 5) {
          
          return true;
        }
      }
      return false;
    }
  
  
     // shoot a shell
    public void shootShell() {
      if (shell != null) {
        return;
      }
      
       
      
      // make a shell for the players turns
      createShell(playerTurn());
      shootShell(playerTurn());
      // The shell is subject to gravity
      forces.record (gravity, shell);
      // The shell is subject to the wind
      forces.record(wind, shell);
        
    }
  
  
    // make a shell
    private void createShell(final Tank tank) {
      // The shell starts at the top/centre of the tank
      PVector shellPosition = tank.positionOfTank();
      shellPosition.x += 75 / 2;
      shellPosition.y -= 10;
      shell = new Shell(shellPosition);
    }
    
    
    
     // will shoot the shell in a direction
    private void shootShell(final Tank tank) {
      PVector shellVelocity = tank.elevatVector();
      shellVelocity.mult(tank.getPower() * powerOfTank);
     
      shellVelocity = tank.setDirection(shellVelocity);
      shell.setVelocity(shellVelocity);
    }
  
  
    // the upate of the shell
    public void update() {
     
      forces.updateForces();
      if (shell != null) {
        shell.update();
         
        shellCollision();
      }
      updateBlocks();
    }
  
  
    private void shellCollision() {
      //  the shell's collision area
      final PVector position = shell.positionGrav();
      final Rectangle2D shellArea = new Rectangle2D.Float(position.x, position.y, 10, 10);


      if (playerCollision(shellArea) ||  stackCollision(shellArea) || groundCollision()) {
            
        // the shell will be destroyed 
        shellIsDestroyed();
      }
    }
  
  
   
     //the player collision
    private boolean playerCollision(final Rectangle2D shellArea) {
     
      for (final Tank player : players) { 
     final PVector position = player.positionOfTank(); 
        
     if (shellArea.intersects(position.x, position.y, 50, 40)) {
          // Update the score; +1 for hitting the opponent,
          // or +1 to the opponent for hitting oneself.
          if (player == players[turn]) {
            score[nextPlayer()]++;
          } 
          
          else {
            
            
            score[turn]++;
          }
          
          return true;
        }
      }
      
      return false;
    }
  
   
     
     // the collision with the blocks
    private boolean stackCollision(final Rectangle2D shellArea) {
       
      Iterator<Block> iterator= stack.iterator();
      while (iterator.hasNext()) {
      
        final Block blocks = iterator.next();
        final PVector position = blocks.positionGrav();
      
        // Collision of the shell area
        if (shellArea.intersects(position.x, position.y, 50, 40)) {
          //will remove the block
          iterator.remove();
          
          return true;
        }
      }
      return false;
    }
    
    // the shell will collied with the ground
    private boolean groundCollision() {
      
      // when the shell hits the ground
      return shell.positionGrav().y >= 700;
    }
    
    
  //the shell will be destroyed
    private void shellIsDestroyed() {
      // remove the forces on the shell
      forces.removeRecord(gravity, shell);
      forces.removeRecord(wind, shell);
      
      // Remove the shell
      shell = null;
      nextTurn();
      
    }
  
    private void updateBlocks() {
      
      for (Block block : stack) {
        
        if (block.stacking(700, stack)) {
         
          //this will remove the force of the gravity of the block
          forces.removeRecord(gravity, block);
          
        }
        
        
        else {
          
          // record the force
          forces.record (gravity, block);
          
          //the blocks will be updated when destroyed 
          block.update();
        }
      }
    }
  
  
    // move the tanks left or right
    public void moveTank(final char key) {
     
      for (int i = 5; i > 0; --i) {
        
        // press a for the player to move left
      if (key == 'a') {
          
          playerTurn().moveLeft(i);
       } 
        
      else if (key == 's') {
        
         playerTurn().moveRight(i);
      }
       
     if (playerCollision()) {
       
      // press a for the player to move right
    if (key == 'a') {
           
        playerTurn().moveRight(i);
        
     } 
     
     // press a for the player to move left
       else if (key == 's') {
            playerTurn().moveLeft(i);
          }
      } 
        
      }
    }
  
    private boolean playerCollision() {
      final Tank tank = playerTurn();
      
      
      // Get the tank's collision area
      final PVector position = tank.positionOfTank();
      final Rectangle2D tankArea = new Rectangle2D.Float(position.x, position.y, 75, 50);
      //the collision for the platers
      return playerBlockCollision() || playerPlayerCollision(tankArea) ||   playerStackCollision(tankArea);
    }
  
  
    // the player's collision
    private boolean playerBlockCollision() {
      
        // will show is the player goes
      return playerTurn().positionOfTank().x < 0 || playerTurn().positionOfTank().x + 75 > displayWidth;
    }
    //https://docs.oracle.com/javase/8/docs/api/java/awt/geom/Rectangle2D.html
    private boolean playerPlayerCollision(final Rectangle2D tankArea) {
      final Tank other = players[nextPlayer()];
      final PVector positionition = other.positionOfTank();
      
      return tankArea.intersects(positionition.x, positionition.y, 75, other.height);
    }
  
    private boolean playerStackCollision(final Rectangle2D tankArea) {
      for (final Block blocks : stack) {
        final PVector position = blocks.positionGrav();
        if (tankArea.intersects(position.x, position.y, 70, 40)) {
          return true;
        }
      }
      return false;
    }
  
  
   
  
  
    public void draw() {
     
      createTheStack();
      drawPlayers();
      createShell();
    }
 
  
    
  
  
    // will make the players shell function 
    private void drawPlayers() {
       drawPlayer(); 
       
      for (final Tank shell : players) {
       
        shell.draw();
      }
    }
  
  
  
  
    private void drawPlayer() { 
     fill(255);
     textAlign(CENTER);
     text("Play's turn " + (turn + 1),670,300);
          
      
     
     // player 1 info
     textAlign(LEFT, TOP);
     text("Player 1 Score: " + score[0], 50, 450);
     text("P1 Strength: " + players[0].getPower(), 50, 500);
     text("P1 Elevation: " + players[0].elevate(), 50, 540);
     
     
      // The player 2 info
      textAlign(RIGHT, TOP);
      text("Player 2 Score: " + score[1], 1315,  450);
      text("P2 Strength: " + players[1].getPower(), 1300, 500);
      text("P2 Elevation: " + players[1].elevate(), 1330, 540);
    }
  
  
  // this will create the blocks for stack 
  private void createTheStack() { 
      
      for (final Block block : stack) {
        block.draw();
        
      }
    }
  
  
    // create the shell
    private void createShell() {
      if (shell != null) {
        
        shell.draw();
      }
    }
  
    public int[] playersScore() {
      return score;
    } 
  }
