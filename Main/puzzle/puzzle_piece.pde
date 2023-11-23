class puzzlePiece {
  float x, y;
  boolean dragging;
  PImage Piece;
  int Id;
  
  puzzlePiece(int id, int col, int row, PImage piece) {
    Id = id;
    x = col * gridSize;
    y = row * gridSize;
    Piece = piece;
  }

  void display() {
    image(Piece, x, y);
  }

  boolean contains(float mx, float my) {
    return mx > x && mx < x + gridSize && my > y && my < y + gridSize;
  }

  void startDragging() {
    dragging = true;
  }

  void stopDragging() {
    int col = constrain(floor(mouseX / gridSize), 0, cols - 1);
    int row = constrain(floor(mouseY / gridSize), 0, rows - 1);
    x = col * gridSize;
    y = row * gridSize;
    grid[col][row] = Id;
    dragging = false;
  }
  
  void update() {
    if (dragging) {
      x = mouseX - gridSize / 2;
      y = mouseY - gridSize / 2;
    }
  }
}
