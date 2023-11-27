class BookPuzzle extends CloseUp {
  int gridSize;
  int cols;
  int[] grid;
  boolean Select = false;
  ArrayList<PImage> pieceImages = new ArrayList<PImage>();
  ArrayList<BookPiece> Books = new ArrayList<BookPiece>();

  float tempX = 0;
  float tempY = 0;
  
  BookPuzzle(String name, int x, int y, int bWidth, int bHeight, String minigameImageFile) {
    super( name, x, y, bWidth, bHeight, minigameImageFile);

    pieceImages.add(loadImage("Book0.png"));
    pieceImages.add(loadImage("Book1.png"));
    pieceImages.add(loadImage("Book2.png"));
    pieceImages.add(loadImage("Book3.png"));
    pieceImages.add(loadImage("Book4.png"));
    
    
    
    gridSize = bWidth/5;

    cols = pieceImages.size();

    grid = new int[cols];
    
    mWidth = cols * gridSize;
    
    for (int c = 0; c < cols; c++) {
      int i = checkPuzzlePiece(c);
      grid[c] = i;
      Books.add(new BookPiece(i, c, y, pieceImages.get(i), this));      
    }
  }

  int checkPuzzlePiece(int r) {
    int i = (int)random(0, pieceImages.size());
    for (BookPiece Book : Books) {
      if (i == Book.id) {
        i = checkPuzzlePiece(r);
      }
    }
    return  i;
  }

  void draw() {
    drawGrid();

    for (BookPiece Book : Books) {
      Book.display();
    }
  }

  void drawGrid() {
    for (int i = 0; i < cols; i++) {
        fill(200);
        rect(i * gridSize + x, y, gridSize , mHeight);      
    }
  }
int tempcol;
  void mousePressed() {
    // Check whether the mouse click is within one of the squares
    for (BookPiece Book : Books) {
      if (Book.contains(mouseX, mouseY)) {        
        if (Select) {
          for (BookPiece Book1e : Books) {
            if (Book1e.Select) {
              Book1e.x = Book.x;
              grid[tempcol] = Book.id;
              Book1e.Select = false;              
              grid[floor((Book.x - x) / gridSize)] = Book1e.id;              
              Book.x = tempX;
              chechWin();              
            }
          }          
        } else {
          tempX = Book.x;
          tempcol = floor((Book.x - x) / gridSize);
          Book.Select = true;
        }
        Select = !Select;        
      }
    } 
  }

  void chechWin() {
    int winConditionCheck = 0;
    boolean hasWon = true;
    for (int c = 0; c < cols; c++) {
      if (winConditionCheck++ != grid[c])
      {
        hasWon = false;
      }      
    }

    if (hasWon) {
      isWon = true;
      println("books beaten");
      beatenPuzzleSound.play();
    }
  }
}
