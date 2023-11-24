class MosaicPuzzle {
  int x;
  int y;
  int mWidth;
  int mHeight;
  int gridSize;
  int cols;
  int rows;
  int[][] grid;
  boolean isOpened;
  boolean won;
  ArrayList<String> pieceImageFiles = new ArrayList<String>();
  ArrayList<MosaicPiece> pieces = new ArrayList<MosaicPiece>();

  float tempX = 0;
  float tempY = 0;

  MosaicPuzzle(int x, int y, int mWidth, int mHeight) {
    this.x = x;
    this.y = y;
    this.mWidth = mWidth;
    this.mHeight = mHeight;
    gridSize = this.mWidth/4;

    cols = this.mWidth / gridSize;
    rows = this.mHeight / gridSize;

    grid = new int[cols][rows];

    isOpened = false;
    won = false;

    pieceImageFiles.add("0.png");
    pieceImageFiles.add("1.png");
    pieceImageFiles.add("2.png");
    pieceImageFiles.add("3.png");
    pieceImageFiles.add("4.png");
    pieceImageFiles.add("5.png");
    pieceImageFiles.add("6.png");
    pieceImageFiles.add("7.png");
    pieceImageFiles.add("8.png");
    pieceImageFiles.add("9.png");
    pieceImageFiles.add("10.png");
    pieceImageFiles.add("11.png");
    pieceImageFiles.add("12.png");
    pieceImageFiles.add("13.png");
    pieceImageFiles.add("14.png");
    pieceImageFiles.add("15.png");

    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        int i = checkPuzzlePiece(r, c);
        grid[c][r] = i;

        pieces.add(new MosaicPiece(i, c, r, pieceImageFiles.get(i), this));
      }
    }
  }

  int checkPuzzlePiece(int r, int c) {
    int i = (int)random(0, pieceImageFiles.size());
    for (MosaicPiece piece : pieces) {
      if (i == piece.id) {
        i = checkPuzzlePiece(r, c);
      }
    }
    return  i;
  }

  void draw() {
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
        fill(200);
        rect(i * gridSize + x, j * gridSize + y, gridSize , gridSize);
      }
    }
  }

  void mousePressed() {
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
      won = true;
      println("you have won the end");
    }
  }

  void mouseDragged() {
    // Drag the squares that are currently being dragged
    for (MosaicPiece piece : pieces) {
      piece.update();
    }
  }
}
