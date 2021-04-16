import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS=30;
public final static int NUM_COLS=30;
private Life[][] buttons; //2d array of Life buttons each representing one cell
private boolean[][] buffer; //2d array of booleans to store state of buttons array
private boolean running = false; //used to start and stop program

public void setup () {
  size(400, 400);
  frameRate(6);
  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
buttons = new Life[NUM_ROWS][NUM_COLS];
for(int r=0; r<NUM_ROWS; r++)
  for(int c=0; c<NUM_COLS; c++)
    buttons[r][c]= new Life(r,c);
  //your code to initialize  buffer goes here
  buffer= new boolean[NUM_ROWS][NUM_COLS];
}

public void draw () {
  background( 0 );
  if (running == false) //pause the program
    return;
  copyFromButtonsToBuffer();

  //use nested loops to draw the buttons here
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
      if(countNeighbors(r,c)==3)
        {buffer[r][c]=true;}
      else if (countNeighbors(r,c)==2 && buttons[r][c].getLife()==true)
        {buffer[r][c]=true;}
      else
        {buffer[r][c]=false;}
      buttons[r][c].draw();
    }
  }
  copyFromBufferToButtons();
}

public void keyPressed() {
  //your code here
  if(running==true)
    running=false;
  else if(running==false)
    running=true;
}

public void copyFromBufferToButtons() {
  //your code here
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
      if(buffer[r][c]==true){
        buttons[r][c].setLife(true);}
      
      if(buffer[r][c]==false){
        buttons[r][c].setLife(false);}
    }
  }
}

public void copyFromButtonsToBuffer() {
  //your code here
  for(int r=0; r<NUM_ROWS; r++){
    for(int c=0; c<NUM_COLS; c++){
       if(buttons[r][c].getLife()==true)
         buffer[r][c]=true;
       
       if(buttons[r][c].getLife()==false)
         buffer[r][c]=false;
    } 
    }
}

public boolean isValid(int r, int c) {
  if(r<=19 && r>=0)
    if(c<=19 && c>=0)
      return true;
  return false;
}

public int countNeighbors(int row, int col) {
  int count = 0;
  if(isValid(row+1, col+1) == true && buttons[row+1][col+1].getLife()==true)
    count++;
  if(isValid(row, col+1) == true && buttons[row][col+1].getLife()==true)
    count++;
  if(isValid(row+1, col) == true && buttons[row+1][col].getLife()==true)
    count++;
  if(isValid(row-1, col-1) == true && buttons[row-1][col-1].getLife()==true)
    count++;
  if(isValid(row-1, col) == true && buttons[row-1][col].getLife()==true)
    count++;
  if(isValid(row, col-1) == true && buttons[row][col-1].getLife()==true)
    count++;
  if(isValid(row+1, col-1) == true && buttons[row+1][col-1].getLife()==true)
    count++;
  if(isValid(row-1,col+1)== true && buttons[row-1][col+1].getLife()==true)
    count++;
  return count;
}

public class Life {
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean alive;

  public Life (int row, int col) {
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    alive = Math.random() < .5; // 50/50 chance cell will be alive
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () {
    alive = !alive; //turn cell on and off with mouse press
  }
  public void draw () {    
    if (alive != true)
      fill(0);
    else 
      fill(50,150,0);
    rect(x, y, width, height);
  }
  public boolean getLife() {
    if(alive==true)
      return true;
    return false;
  }
  public void setLife(boolean living) {
   if(living==true)
      alive=true;
   if(living==false)
     alive=false;
  }
}
