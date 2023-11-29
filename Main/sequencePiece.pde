class SequencePiece {
  int x;
  int y;
  boolean selected;
  PImage imageDim;
  PImage imageLit;
  int id;
  int bookHeight;
  int gridSize;
  SequencePuzzle parent;

  SequencePiece (int id, int x, int y, PImage imageDim, PImage imageLit, int gridSize, SequencePuzzle parent) {
    this.id = id;
    this.parent = parent;
    this.gridSize = gridSize;
    this.x = x;
    this.y = y;
    this.imageDim = imageDim;
    this.imageLit = imageLit;
  }

  void display() {
    image(imageDim, x + parent.x, y + parent.y, gridSize, gridSize);
    if (selected)
    {
      image(imageLit, x + parent.x, y + parent.y, gridSize, gridSize);
    }
  }

  void mousePressed() {
    if (contains(mouseX, mouseY)) {
      selected = true;
    }
  }

  boolean contains(float mx, float my) {
    mx = constrain(mx, parent.x, parent.x + parent.mWidth);
    my = constrain(my, parent.y, parent.y + parent.mHeight);
    return mx > x + parent.x && mx < x + parent.x + gridSize && my > y + parent.y && my < y + parent.y + gridSize;
  }
}
