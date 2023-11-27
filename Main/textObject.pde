class TextObject extends GameObject {
  private String text;
  private PImage backgroundImage;
  private boolean hasBackground;
  protected boolean displayText;
  private float textWidth;
  private float textHeight;
  private float textSize;

  public TextObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, String text) {
    this(identifier, x, y, owidth, oheight, gameObjectImageFile, text, "");
  }

  public TextObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, String text, String backgroundImageFile) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.text = text;
    hasBackground = !backgroundImageFile.equals("");
    if (hasBackground) {
      backgroundImage = loadImage(backgroundImageFile);
    }
    displayText = false;
    textSize = 50;
    calculateTextArea(); //Automatically calculates the area
    //necessary to display the entire text.
  }
  @Override
    public void draw() {
    super.draw();
    if (displayText && text != "") {
      if (hasBackground) {
        image(backgroundImage, width/3 - 50, height * 6/7 - 60, textWidth + 30, textHeight);
        fill(0);
        textSize(textSize);
        text(text, width/3, height * 6/7);
      } else {
        fill(255);
        rect(width/3 - 50, height * 6/7 - 60, textWidth + 30, textHeight, 8);
        fill(0);
        textSize(textSize);
        text(text, width/3, height * 6/7);
      }
    }
  }
  @Override
    public void mouseClicked() {
    displayText = false;
    if (mouseIsHovering) {
      displayText = true;
    }
  }

  public void calculateTextArea() {
    textWidth = textWidth(text) * (textSize / 10);
    float remaining = textWidth - 100;
    textWidth = (textWidth > 1000) ? 1000 : textWidth;
    textHeight = 50;
    while (remaining > 300)
    {
      textHeight += 30;
      remaining -= 300;
    }
  }
}
