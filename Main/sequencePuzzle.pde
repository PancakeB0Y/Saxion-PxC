class SequencePuzzle extends CloseUp {
  IntList piecesOrder = new IntList(0, 1, 2, 3, 4);
  ArrayList<SequencePiece> pieces = new ArrayList<SequencePiece>();
  ArrayList<Integer> clickedPiecesOrder = new ArrayList<Integer>() ;

  SequencePuzzle(String name, int x, int y, int mWidth, int mHeight, String backgroundImageFile) {
    super(name, x, y, mWidth, mHeight, backgroundImageFile);

    piecesOrder.shuffle();

    pieces.add(new SequencePiece(0, 400, 380, null, loadImage("sequencePiece1.png"), 170, this));
    pieces.add(new SequencePiece(1, 550, 80, null, loadImage("sequencePiece2.png"), 170, this));
    pieces.add(new SequencePiece(2, 935, 80, null, loadImage("sequencePiece3.png"), 170, this));
    pieces.add(new SequencePiece(3, 1100, 380, null, loadImage("sequencePiece4.png"), 170, this));
    pieces.add(new SequencePiece(4, 750, 650, null, loadImage("sequencePiece5.png"), 190, this));
    //pieces.add(new SequencePiece(5, 325, 400, loadImage("jumpscare.png"), loadImage("crystal.png"), 100, this));
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
    super.mousePressed();

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
        println("selected wrong");
        for (SequencePiece curPiece2 : pieces) {
          curPiece2.selected = false;
        }
        clickedPiecesOrder = new ArrayList<Integer>();
      } else if (compare() && clickedPiecesOrder.size() == piecesOrder.size()) {
        isWon = true;
        println("books beaten");
        beatenPuzzleSound.play();
      }
    }

    for (int i = 0; i < piecesOrder.size(); i++) {
      SequencePiece curPiece = pieces.get(piecesOrder.get(i));
      if (curPiece.contains(mouseX, mouseY)) {
        if (compare() && clickedPiecesOrder.size() > 0) {
          glyphOnSound.play();
        } else{
          glyphOffSound.play();
        }
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
