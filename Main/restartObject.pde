class RestartObject extends GameObject {

  public RestartObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
  }

  @Override
    public void mouseClicked() {
    if (mouseIsHovering) {
      restart();
    }
  }
}
