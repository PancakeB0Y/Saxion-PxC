class SequencePuzzle extends CloseUp {
  IntList piecesOrder = new IntList(0, 1, 2, 3, 4, 5);
  ArrayList<SequencePiece> pieces = new ArrayList<SequencePiece>();
  ArrayList<Integer> clickedPiecesOrder = new ArrayList<Integer>() ;

  SequencePuzzle(String name, int x, int y, int mWidth, int mHeight, String backgroundImageFile) {
    super(name, x, y, mWidth, mHeight, backgroundImageFile);

    piecesOrder.shuffle();

    pieces.add(new SequencePiece(0, 75, 250, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
    pieces.add(new SequencePiece(1, 175, 100, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
    pieces.add(new SequencePiece(2, 325, 100, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
    pieces.add(new SequencePiece(3, 425, 250, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
    pieces.add(new SequencePiece(4, 175, 400, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
    pieces.add(new SequencePiece(5, 325, 400, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
  }

  void draw() {
    if (hasImage) {
      image(closeUpImage, x, y);
    }
    for (SequencePiece curPiece : pieces) {
      curPiece.display();
    }
  }

  void mousePressed() {
    //Check whether the mouse click is within one of the squares
    for (SequencePiece curPiece : pieces) {
      curPiece.mousePressed();
    }

    clickedPiecesOrder = new ArrayList<Integer>();
    for (int i = 0; i < piecesOrder.size(); i++) {
      SequencePiece curPiece = pieces.get(piecesOrder.get(i));
      if (curPiece.selected) {
        clickedPiecesOrder.add(curPiece.id);
      }

      if (!compare()) {
        for (SequencePiece curPiece2 : pieces) {
          curPiece2.selected = false;
        }
        clickedPiecesOrder = new ArrayList<Integer>();
      } else if(compare() && clickedPiecesOrder.size() == piecesOrder.size()){
        isWon = true;
        println("books beaten");
        beatenPuzzleSound.play();
      }
    }
  }

  boolean compare() {
    boolean areEqual = true;
    for (int i = 0; i < clickedPiecesOrder.size(); i++) {
      if (clickedPiecesOrder.get(i) != piecesOrder.get(i)) {
        areEqual = false;
        break;
      }
    }

    return areEqual;
  }
}
