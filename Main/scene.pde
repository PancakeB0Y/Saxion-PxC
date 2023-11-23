class Scene {
  private String sceneName;
  private PImage backgroundImage;
  private ArrayList<GameObject> gameObjects;

  private ArrayList<GameObject> recentlyAddedGameObjects;
  private ArrayList<GameObject> markedForDeathGameObjects;

  private boolean displayInventory;

  public Scene(String sceneName, String backgroundImageFile) {
    this(sceneName, backgroundImageFile, true);
  }

  public Scene(String sceneName, String backgroundImageFile, boolean displayInventory) {
    this.sceneName = sceneName;
    this.backgroundImage = loadImage(backgroundImageFile);
    this.displayInventory = displayInventory;
    gameObjects = new ArrayList<GameObject>();
    markedForDeathGameObjects = new ArrayList<GameObject>();
    recentlyAddedGameObjects = new ArrayList<GameObject>();
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
      image(backgroundImage, 0, 0, wwidth - inventoryWidth, wheight);
      for (GameObject object : gameObjects) {
        object.draw();
      }
      inventoryDisplay.draw();
    } else {
      image(backgroundImage, 0, 0, wwidth, wheight);
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
    if (displayInventory) {
      inventoryDisplay.mousePressed();
    }
  }

  public String getSceneName() {
    return this.sceneName;
  }
}
