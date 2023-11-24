MosaicPuzzle mosaicPuzzle;

void setup() {
  size(1000, 1000);
  mosaicPuzzle = new MosaicPuzzle(200, 200, 400, 400);
}

void draw() {
  mosaicPuzzle.draw();
}

void mousePressed() {
  mosaicPuzzle.mousePressed();
}

void mouseReleased() {
  mosaicPuzzle.mouseReleased();
}

void mouseDragged() {
  mosaicPuzzle.mouseDragged();
}
