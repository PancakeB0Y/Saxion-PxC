class CloseUpCollectable extends Collectable {
  protected PImage closeUpImage;
  private int closeUpX;
  private int closeUpY;
  private int closeUpWidth;
  private int closeUphHeight;

  public CloseUpCollectable(String name, String gameObjectImageFile, String closeUpImageFile) {
    super(name, gameObjectImageFile);
    closeUpImage = loadImage(closeUpImageFile);
    isOpen = false;

    closeUpWidth = 950;
    closeUphHeight = 800;
    closeUpX = width/2 - closeUpWidth/2 - inventoryWidth/2;
    closeUpY = height/2 - closeUphHeight/2;
  }

  void draw() {
    if (isOpen) {
      image(closeUpImage, closeUpX, closeUpY, closeUpWidth, closeUphHeight);
    }
  }

  void mousePressed() {
    if (!isOpen) {
      return;
    }

    if (mouseX < closeUpX || mouseX > closeUpX + closeUpX || mouseY < closeUpY || mouseY > closeUpY + closeUphHeight) {
      isOpen = false;
    }
  }
}
