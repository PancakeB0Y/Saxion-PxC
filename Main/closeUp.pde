class CloseUp {
  protected String name;
  protected int x;
  protected int y;
  protected int mWidth;
  protected int mHeight;
  protected PImage closeUpImage;
  private boolean hasImage;
  protected boolean isWon;
  protected boolean isOpen;

  CloseUp(String name, int x, int y, int mWidth, int mHeight, String closeUpImageFile) {
    this.name = name;
    this.x = x;
    this.y = y;
    this.mWidth = mWidth;
    this.mHeight = mHeight;
    hasImage = !closeUpImageFile.equals("");
    if (hasImage) {
      closeUpImage = loadImage(closeUpImageFile);
      closeUpImage.resize(mWidth, mHeight);
    }
    isWon = false;
    isOpen = false;
  }

  void playMinigame() {
    isOpen = true;
  }

  void closeMinigame() {
    isOpen = false;
  }

  void draw() {
    if (!isOpen) {
      return;
    }
    if (hasImage) {
      fill(200);
      rect(x, y, mWidth, mHeight);
      image(closeUpImage, x, y, mWidth, mHeight);
    }
  }

  void mouseClicked() {
    if (!isOpen) {
      return;
    }

    if (mouseX < x || mouseX > x + mWidth || mouseY < y || mouseY > y + mHeight) {
      isOpen = false;
    }
  }

  void mouseReleased() {
    if (!isOpen || isWon) {
      return;
    }
  }

  void mouseDragged() {
  }

  void mousePressed() {
  }
}
