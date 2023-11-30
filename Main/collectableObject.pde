class CollectableObject extends GameObject {
  private Collectable collectable;
  private GameObject replaceWith;
  private boolean willReplaceByAnotherGameObject;
  private String newBackgroundImageFile = "";
  private PImage newBackgroundImage;

  public CollectableObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, Collectable collectable, String newBackgroundImageFile) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, collectable, (GameObject)null);
    this.newBackgroundImageFile = newBackgroundImageFile;
    if (newBackgroundImageFile!="") {
      newBackgroundImage = loadImage(newBackgroundImageFile);
    }
  }

  public CollectableObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, Collectable collectable) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, collectable, (GameObject)null);
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

  @Override
    public void mousePressed() {
    if (mouseIsHovering) {
      interactSound.play();
      inventoryManager.addCollectable(collectable);
      sceneManager.getCurrentScene().removeGameObject(this);
      if (newBackgroundImageFile!="") {
        sceneManager.getCurrentScene().backgroundImage = newBackgroundImage;
      }
      if (willReplaceByAnotherGameObject) {
        sceneManager.getCurrentScene().addGameObject(replaceWith);
      }
    }
  }
}
