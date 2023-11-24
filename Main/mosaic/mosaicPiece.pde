class MosaicPiece {
  float x;
  float y;
  boolean dragging;
  PImage pieceImage;
  int id;
  int gridSize;
  MosaicPuzzle parent;

  MosaicPiece(int id, int col, int row, String pieceImageFile, MosaicPuzzle parent) {
    this.id = id;
    this.parent = parent;
    this.gridSize = parent.gridSize;
    x = col * gridSize + parent.x;
    y = row * gridSize + parent.y;
    pieceImage = loadImage(pieceImageFile);
    pieceImage.resize(gridSize, gridSize);
  }

  void display() {
    image(pieceImage, x, y);
  }

  boolean contains(float mx, float my) {
    mx = constrain(mx, parent.x, parent.x + parent.mWidth);
    my = constrain(my, parent.y, parent.y + parent.mHeight);
    return mx > x && mx < x + gridSize && my > y && my < y + gridSize;
  }

  void startDragging() {
    dragging = true;
  }

  void stopDragging() {
    int col = constrain(floor(mouseX / gridSize) - (parent.x / gridSize), 0, parent.cols - 1);
    int row = constrain(floor(mouseY / gridSize) - (parent.y / gridSize), 0, parent.rows - 1);
    x = col * gridSize + parent.x;
    y = row * gridSize + parent.y;
    parent.grid[col][row] = id;
    dragging = false;
  }

  void update() {
    if (dragging) {
      x = constrain(mouseX - gridSize / 2, parent.x, parent.x + parent.mWidth - gridSize);
      y = constrain(mouseY - gridSize / 2, parent.y, parent.y + parent.mHeight - gridSize);
    }
  }
}
