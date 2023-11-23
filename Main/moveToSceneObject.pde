class MoveToSceneObject extends GameObject {
  private String nextSceneIdentifier;
  private boolean moveBack;

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack) {
    this(identifier, x, y, owidth, oheight, "", moveBack);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.moveBack = moveBack;
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
  }

  public void mouseClicked() {
    super.mouseClicked();
    if (mouseIsHovering) {
      if (moveBack) {
        sceneManager.goToPreviousScene();
      } else {
        try {
          whooshSound.play();
          sceneManager.goToScene(nextSceneIdentifier);
        }
        catch(Exception e) {
          println(e.getMessage());
        }
      }
    }
  }
}
