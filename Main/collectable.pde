class Collectable {
  private String name;
  private String gameObjectImageFile;
  public PImage gameObjectImage;
  //Could be expanded to add an amount, for example

  public Collectable(String name, String gameObjectImageFile) {
    this.name = name;
    this.gameObjectImageFile = gameObjectImageFile;
    if (gameObjectImageFile != "") {
      this.gameObjectImage = loadImage(gameObjectImageFile);
    }
  }

  public String getName() {
    return name;
  }

  public String getGameObjectImageFile() {
    if (gameObjectImageFile != "" ) {
      return gameObjectImageFile;
    }
    return "";
  }

  @Override
    public boolean equals(Object obj) {
    if (obj == this) {
      return true;
    }
    if (obj == null || obj.getClass() != this.getClass()) {
      return false;
    }
    Collectable otherCollectable = (Collectable) obj;
    return otherCollectable.getName().equals(this.name);
  }

  @Override
    public int hashCode() {
    final int prime = 13;
    return prime * this.name.hashCode();
  }
}
