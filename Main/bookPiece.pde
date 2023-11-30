class BookPiece {
  float x;
  float y;
  boolean selected;
  PImage pieceImage;
  int id;
  int bookHeight;
  int gridSize;
  BookPuzzle parent;

  BookPiece (int id, int col, int y, PImage pieceImage, BookPuzzle parent) {
    this.id = id;
    this.parent = parent;
    this.gridSize = parent.gridSize;
    x = col * gridSize + parent.x;
    this.y = y + parent.mHeight - pieceImage.height;
    this.pieceImage = pieceImage;
    pieceImage.resize(gridSize, pieceImage.height);
  }

  void display() {
    image(pieceImage, x, y);
    if(selected) 
    {
      fill(50, 0, 0, 50);
      rect(x, y, gridSize , pieceImage.height);
    }
  }
  
  void mousePressed(){
    if(contains(mouseX, mouseY)){
      selected = true;
    }
  }

  boolean contains(float mx, float my) {
    mx = constrain(mx, parent.x, parent.x + parent.mWidth);
    my = constrain(my, parent.y, parent.y + parent.mHeight);
    return mx > x && mx < x + gridSize && my > y && my < y + pieceImage.height;
  }
}
