int gridSize = 100;   // Size of the grid
int cols, rows;       // Number of columns and rows in the grid
int[][] grid;         // 2D array to keep track of the grid
ArrayList<puzzlePiece> rectangles = new ArrayList<puzzlePiece>();  //List of squares to drag
ArrayList<PImage> Images = new ArrayList<PImage>();

void setup() {
  size(400, 400);
  
 // resize(gridSize, gridSize);
  Images();
  // Determine the number of columns and rows based on the size of the screen and grid
  cols = width / gridSize;
  rows = height / gridSize;
  
  // Initialization of the grid
  grid = new int[cols][rows];

  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      int i = CheckpuzzlePiece(r, c);
      grid[c][r] = i;
      
      rectangles.add(new puzzlePiece(i, c, r, Images.get(i)));
      
    }
  }
}

int CheckpuzzlePiece(int r, int c) {
  int i = (int)random(0, Images.size());
  for (puzzlePiece rect : rectangles) {
    if (i == rect.Id) {
     i = CheckpuzzlePiece(r, c);
    }
  }      
  return  i; 
}

void draw() {
  background(255);
  drawGrid();
  
  for (puzzlePiece rect : rectangles) {
    rect.display();
  }
}

void drawGrid() {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      fill(200);
      rect(i * gridSize, j * gridSize, gridSize, gridSize);
    }
  }
}

float tempX, tempY;

void mousePressed() {
  
  // Check whether the mouse click is within one of the squares
  for (puzzlePiece rect : rectangles) {
    if (rect.contains(mouseX, mouseY)) {
      tempX = rect.x;
      tempY = rect.y;
      rect.startDragging();
    }
  }
}

void mouseReleased() {
  
  // Stop dragging all squares when the mouse button is released 
  for (puzzlePiece rect : rectangles) {
    if (rect.contains(mouseX, mouseY)) {
      if(!rect.dragging){
        rect.x = tempX;
        rect.y = tempY;
        grid[(int)tempX / gridSize][(int)tempY / gridSize] = rect.Id;    

      } else {
        rect.stopDragging();
      }
       
    }
  }
  
  int WinConditionCheck = 0;
  boolean won = true;
  for (int r = 0; r < rows; r++) {
    for (int c = 0; c < cols; c++) {
      if(WinConditionCheck++ != grid[c][r])
      {
        won = false;
      }
    }
  }
  
  if(won){    
    println("you have won the end");
  }  
}

void mouseDragged() {
  // Drag the squares that are currently being dragged
  for (puzzlePiece rect : rectangles) {
    rect.update();
  }
}
