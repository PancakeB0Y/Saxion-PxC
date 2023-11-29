class Scene {
  private String sceneName;
  private PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;

  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;
  
  private SoundFile sound;
  private boolean displayInventory;

  public Scene(String sceneName, String backgroundImageFile, SoundFile sound) {
    this(sceneName, backgroundImageFile, true, sound);
  }

  public Scene(String sceneName, String backgroundImageFile) {
    this(sceneName, backgroundImageFile, true, null);
  }
  
  public Scene(String sceneName, String backgroundImageFile, boolean displayInventory) {
    this(sceneName, backgroundImageFile, displayInventory, null);
  }

  public Scene(String sceneName, String backgroundImageFile, boolean displayInventory, SoundFile sound) {
    this.sceneName = sceneName;
    this.backgroundImage = backgroundImageFile != "" ? loadImage(backgroundImageFile) : null;
    this.displayInventory = displayInventory;
    gameObjects = new ArrayList<GameObject>();
    markedForDeathGameObjects = new ArrayList<GameObject>();
    recentlyAddedGameObjects = new ArrayList<GameObject>();
    this.sound = sound;
  }

  public void addGameObject(GameObject object) {
    recentlyAddedGameObjects.add(object);
  }

  public void removeGameObject(GameObject object) {
    markedForDeathGameObjects.add(object);
  }

  public void updateScene() {
    if (markedForDeathGameObjects.size() > 0) {
      for (GameObject object : markedForDeathGameObjects) {
        gameObjects.remove(object);
      }
      markedForDeathGameObjects  = new ArrayList<GameObject>();
    }
    if (recentlyAddedGameObjects.size() > 0) {
      for (GameObject object : recentlyAddedGameObjects) {
        gameObjects.add(object);
      }
      recentlyAddedGameObjects  = new ArrayList<GameObject>();
    }
  }

  public void draw() {
    if (displayInventory) {
      if (backgroundImage!=null) {
        image(backgroundImage, 0, 0, wwidth - inventoryWidth, wheight);
      } else {
        background(100);
      }
      for (GameObject object : gameObjects) {
        object.draw();
      }
      inventoryDisplay.draw();
    } else {
      if (backgroundImage!=null) {
        image(backgroundImage, 0, 0, wwidth, wheight);
      } else {
        background(100);
      }
      for (GameObject object : gameObjects) {
        object.draw();
      }
    }
  }

  public void mouseMoved() {
    for (GameObject object : gameObjects) {
      object.mouseMoved();
    }
  }

  public void mouseClicked() {
    for (GameObject object : gameObjects) {
      object.mouseClicked();
    }
  }

  public void mouseReleased() {
    if (displayInventory) {
      inventoryDisplay.mouseReleased();
    }
    for (GameObject object : gameObjects) {
      object.mouseReleased();
    }
  }

  public void mouseDragged() {
    for (GameObject object : gameObjects) {
      object.mouseDragged();
    }
  }

  public void mousePressed() {
    for (GameObject object : gameObjects) {
      object.mousePressed();
    }
    if (displayInventory) {
      inventoryDisplay.mousePressed();
    }
  }

  public String getSceneName() {
    return this.sceneName;
  }
}
