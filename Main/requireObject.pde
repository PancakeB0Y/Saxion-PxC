class RequireObject extends TextObject {
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean requiredCollectableOnTop;
  private boolean removeOnDrop;

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    Collectable collectable, GameObject replaceWith) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile, collectable, replaceWith, true);
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    Collectable collectable, GameObject replaceWith, boolean removeOnDrop) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = removeOnDrop;
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, collectable, replaceWith, true);
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith, boolean removeOnDrop) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = removeOnDrop;
  }

  public void mouseDragged() {
    if (mouseX >= x && mouseX <= x + owidth &&
      mouseY >= y && mouseY <= y + oheight) {
    } else {
      return;
    }

    if (inventoryManager.containsCollectable(collectable)) {
      if (inventoryDisplay.beingDragged == collectable) {
        requiredCollectableOnTop = true;
      }
    }
  }

  public void mouseReleased() {
    if (requiredCollectableOnTop) {
      breakSound.play();
      if (removeOnDrop) {
        inventoryManager.removeCollectable(collectable);
      }
      sceneManager.getCurrentScene().removeGameObject(this);
      sceneManager.getCurrentScene().addGameObject(replaceWith);
    }
  }
}
