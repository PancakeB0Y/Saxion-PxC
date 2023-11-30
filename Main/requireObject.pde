class RequireObject extends TextObject {
  private Collectable collectable;
  private CloseUp minigame;
  private GameObject replaceWith;
  private SoundFile sound;
  private boolean requiredCollectableOnTop;
  private boolean removeOnDrop;
  private boolean hasMinigame;

  private boolean addedObjectOnce = false;
  private PImage newBackgroundImage;
  private String newBackgroundImageFile = "";

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    CloseUp minigame, GameObject replaceWith, SoundFile sound) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.minigame = minigame;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = false;
    hasMinigame = true;
    this.sound = sound;
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    CloseUp minigame, GameObject replaceWith, SoundFile sound, String newBackgroundImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.minigame = minigame;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = false;
    hasMinigame = true;
    this.sound = sound;
    this.newBackgroundImageFile = newBackgroundImageFile;
    if (newBackgroundImageFile!= "") {
      newBackgroundImage = loadImage(newBackgroundImageFile);
    }
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    CloseUp minigame, GameObject replaceWith, SoundFile sound) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile);
    this.minigame = minigame;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = false;
    hasMinigame = true;
    this.sound = sound;
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    Collectable collectable, GameObject replaceWith) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile, collectable, replaceWith, true, null);
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text, String backgroundImageFile,
    Collectable collectable, GameObject replaceWith, boolean removeOnDrop, SoundFile sound) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text, backgroundImageFile);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = removeOnDrop;
    hasMinigame = false;
    this.sound = sound;
  }

  
  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith, String newBackgroundImageFile) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, collectable, replaceWith, true, null, newBackgroundImageFile);
  }
  
  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, collectable, replaceWith, true, null, "");
  }

  public RequireObject(String identifier, int x, int y, int owidth, int oheight,
    String gameObjectImageFile, String text,
    Collectable collectable, GameObject replaceWith, boolean removeOnDrop, SoundFile sound, String newBackgroundImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile, text);
    this.collectable = collectable;
    this.replaceWith = replaceWith;
    requiredCollectableOnTop = false;
    this.removeOnDrop = removeOnDrop;
    hasMinigame = false;
    this.sound = sound;
    this.newBackgroundImageFile = newBackgroundImageFile;
    if (newBackgroundImageFile!= "") {
      newBackgroundImage = loadImage(newBackgroundImageFile);
    }
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
    if (!hasMinigame) {
      if (requiredCollectableOnTop) {
        if (sound != null) {
          sound.play();
        }
        if (removeOnDrop) {
          inventoryManager.removeCollectable(collectable);
        }
        sceneManager.getCurrentScene().removeGameObject(this);
        sceneManager.getCurrentScene().addGameObject(replaceWith);
        if (newBackgroundImageFile!="") {
          sceneManager.getCurrentScene().backgroundImage = newBackgroundImage;
        }
      }
    }
  }

  public void mouseMoved() {
    mouseIsHovering = false;
    if (mouseX >= x - 5 && mouseX <= x + 5 + owidth &&
      mouseY >= y - 5 && mouseY <= y + 5 + oheight) {
      mouseIsHovering = true;
    }

    if (hasMinigame && minigame.isWon && !addedObjectOnce) {
      sceneManager.getCurrentScene().removeGameObject(this);
      sceneManager.getCurrentScene().addGameObject(replaceWith);
      addedObjectOnce = true;
    }
  }
}
