class MoveToSceneObject extends GameObject {
  private String nextSceneIdentifier;
  private boolean moveBack;
  private SoundFile sound;

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, boolean moveBack) {
    this(identifier, x, y, owidth, oheight, "", moveBack);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, boolean moveBack) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.moveBack = moveBack;
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String nextSceneIdentifier) {
    this(identifier, x, y, owidth, oheight, "", nextSceneIdentifier, null);
  }
  
  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, nextSceneIdentifier, null);
  }

  public MoveToSceneObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, String nextSceneIdentifier, SoundFile sound) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.nextSceneIdentifier = nextSceneIdentifier;
    this.moveBack = false;
    this.sound = sound;
  }

  public void mouseClicked() {
    super.mouseClicked();
    if (mouseIsHovering) {
      if (moveBack) {
        sceneManager.goToPreviousScene();
      } else {
        try {
          if (sound != null) {
            sound.play();
          }
          sceneManager.goToScene(nextSceneIdentifier);
        }
        catch(Exception e) {
          println(e.getMessage());
        }
      }
    }
  }
}
