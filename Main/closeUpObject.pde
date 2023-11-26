class CloseUpObject extends GameObject {
  private CloseUp closeUp;
  private GameObject replaceWith;

  public CloseUpObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, CloseUp closeUp) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, closeUp, null);
  }

  public CloseUpObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, CloseUp closeUp, GameObject replaceWith) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.closeUp = closeUp;
    if (replaceWith != null) {
      this.replaceWith = replaceWith;
    }
  }

  @Override
    public void draw() {
    if (closeUp.isOpen) {
      closeUp.draw();
    } else {
      super.draw();
    }
  }

  @Override
    public void mouseClicked() {
    if (closeUp.isOpen) {
      closeUp.mouseClicked();
    } else {
      super.mouseClicked();
      if (mouseIsHovering) {
        closeUp.isOpen = true;
      }
    }
  }

  @Override
    void mouseReleased() {
    if (closeUp.isOpen) {
      closeUp.mouseReleased();
    } else {
      super.mouseReleased();
    }
    
    if (closeUp.isWon && replaceWith != null) {
      closeUp.isOpen = false;
      sceneManager.getCurrentScene().removeGameObject(this);
      sceneManager.getCurrentScene().addGameObject(replaceWith);
    }
  }

  @Override
    void mouseDragged() {
    if (closeUp.isOpen) {
      closeUp.mouseDragged();
    } else {
      super.mouseDragged();
    }
  }

  @Override
    void mousePressed() {
    if (closeUp.isOpen) {
      closeUp.mousePressed();
    } else {
      super.mousePressed();
    }
  }
}
