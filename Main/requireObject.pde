class RequireObject extends TextObject {
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean requiredCollectableOnTop;

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    Collectable collectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
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
      inventoryManager.removeCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      sceneManager.getCurrentScene().addGameObject(replaceWith);
    }
  }
}
