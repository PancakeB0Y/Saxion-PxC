int gridSize = 100;   // Size of the grid
int cols, rows;       // Number of columns and rows in the grid
int[][] grid;         // 2D array to keep track of the grid
ArrayList<puzzlePiece> rectangles = new ArrayList<puzzlePiece>();  //List of squares to drag
ArrayList<PImage> Images = new ArrayList<PImage>();

void setup() {
  size(400, 400);
  Images();
  // Determine the number of columns and rows based on the size of the screen and grid
  cols = width / gridSize;
  rows = height / gridSize;
  
  // Initialisatie van het grid
  grid = new int[cols][rows];

  
  //for (int r = 0; r < rows; r++) {
   // for (int c = 0; c < cols; c++) {
   //   int i = (int)random(0, Images.size());
     // rectangles.add(new puzzlePiece(0, c, r, Images.get(i)));
     // Images.remove(i);
    //}
  //}
  rectangles.add(new puzzlePiece(0, 2, 2, Images.get(7)));
}

void draw() {
  background(255);
  
  // Teken het grid
  drawGrid();
  
  // Teken de te slepen vierkanten
  for (puzzlePiece rect : rectangles) {
    rect.display();
  }
}

void drawGrid() {
  // Teken het grid
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
      } else {
      rect.stopDragging();
      }
      
      
    }
    
  }
}

void mouseDragged() {
  // Drag the squares that are currently being dragged
  for (puzzlePiece rect : rectangles) {
    rect.update();
  }
}
