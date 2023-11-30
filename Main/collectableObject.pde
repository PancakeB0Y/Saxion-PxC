class CollectableObject extends GameObject {
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;

  public CollectableObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, Collectable collectable) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, collectable, null);
  }

  public CollectableObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, Collectable collectable, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.collectable = collectable;
    if (replaceWith != null) {
      this.replaceWith = replaceWith;
      this.willReplaceByAnotherGameObject = true;
    } else {
      this.willReplaceByAnotherGameObject = false;
    }
  }

  @Override
    public void draw() {
    super.draw();
  }

  //@Override
  //  public void mouseClicked() {
  //  if (mouseIsHovering) {
  //    interactSound.play();
  //    inventoryManager.addCollectable(collectable);
  //    sceneManager.getCurrentScene().removeGameObject(this);
  //    if (willReplaceByAnotherGameObject) {
  //      sceneManager.getCurrentScene().addGameObject(replaceWith);
  //    }
  //  }
  //}
  
  @Override
    public void mousePressed() {
    if (mouseIsHovering) {
      interactSound.play();
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if (willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);
      }
    }
  }
}
