class MosaicPuzzle extends CloseUp {
  private int gridSize;
  private int cols;
  private int rows;
  private int[][] grid;
  private ArrayList<PImage> pieceImages = new ArrayList<PImage>();
  private ArrayList<MosaicPiece> pieces = new ArrayList<MosaicPiece>();

  private float tempX = 0;
  private float tempY = 0;

  MosaicPuzzle(String name, int x, int y, int mWidth, int mHeight, String minigameImageFile) {
    super( name, x, y, mWidth, mHeight, minigameImageFile);
    gridSize = this.mWidth/4;

    cols = this.mWidth / gridSize;
    rows = this.mHeight / gridSize;

    grid = new int[cols][rows];

    //splits the image into smaller rectangles
    for (int row = 0; row < rows; row++) {
      for (int column = 0; column < cols; column++) {
        PImage sprite = createImage (gridSize, gridSize, ARGB);
        sprite.copy(
          closeUpImage,
          column * gridSize,
          row * gridSize,
          gridSize,
          gridSize,
          0, 0, gridSize, gridSize
          );
        pieceImages.add(sprite);
      }
    }

    arrangePieces();
  }

  //randomly arranges the pieces
  void arrangePieces() {
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        int i = checkPuzzlePiece();
        grid[c][r] = i;

        //if (pieces.size() <16) {
          pieces.add(new MosaicPiece(i, c, r, pieceImages.get(i), this));
        //} else {
        //  pieces.set(r + c, new MosaicPiece(i, c, r, pieceImages.get(i), this));
        //}
      }
    }
  }

  int checkPuzzlePiece() {
    int i = (int)random(0, pieceImages.size());
    for (MosaicPiece piece : pieces) {
      if (i == piece.id) {
        i = checkPuzzlePiece();
      }
    }
    return  i;
  }

  void draw() {
    if (!isOpen) {
      return;
    }

    drawGrid();

    for (MosaicPiece piece : pieces) {
      piece.display();
    }
    for (MosaicPiece piece : pieces) {
      if (piece.dragging) {
        piece.display();
      }
    }
  }

  void drawGrid() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        fill(0);
        rect(i * gridSize + x, j * gridSize + y, gridSize, gridSize);
      }
    }
  }

  void mousePressed() {
    if (!isOpen || isWon) {
      return;
    }
    // Check whether the mouse click is within one of the squares
    for (MosaicPiece piece : pieces) {
      if (piece.contains(mouseX, mouseY)) {
        tempX = piece.x;
        tempY = piece.y;
        piece.startDragging();
      }
    }
  }

  void mouseReleased() {
    if (!isOpen || isWon) {
      return;
    }

    // Stop dragging all squares when the mouse button is released
    for (MosaicPiece piece : pieces) {
      if (piece.contains(mouseX, mouseY)) {
        if (!piece.dragging) {
          piece.x = tempX;
          piece.y = tempY;
          grid[((int)tempX - x) / gridSize][((int)tempY - y) / gridSize] = piece.id;
        } else {
          piece.stopDragging();
        }
      } else if (piece.dragging) {
        piece.x = tempX;
        piece.y = tempY;
        piece.dragging = false;
      }
    }

    int winConditionCheck = 0;
    boolean hasWon = true;
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (winConditionCheck++ != grid[c][r])
        {
          hasWon = false;
        }
      }
    }

    if (hasWon) {
      isWon = true;
      println("mosaic beaten");
      beatenPuzzleSound.play();
    }
  }

  void mouseDragged() {
    if (!isOpen || isWon) {
      return;
    }
    // Drag the squares that are currently being dragged
    for (MosaicPiece piece : pieces) {
      piece.update();
    }
  }

  void mouseClicked() {
    if (!isOpen) {
      return;
    }

    if (mouseX < x || mouseX > x + mWidth || mouseY < y || mouseY > y + mHeight) {
      isOpen = false;
      if (!isWon) {
        //Resets the puzzle if is exited before completion
        pieces = new ArrayList<MosaicPiece>();
        arrangePieces();
      }
    }
  }
}
