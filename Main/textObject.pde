class TextObject extends GameObject {
  private String text;
  private PImage backgroundImage;
  private boolean hasBackground;
  protected boolean displayText;
  private float textWidth;
  private float textHeight;
  private float textSize;
  private int textX = width/3 - 50;
  private int textY = height * 6/7 - 60;
  private boolean stayOnScreen = false;

  public TextObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, String text, String backgroundImageFile, int imageWidth, int imageHeight) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.text = text;
    hasBackground = !backgroundImageFile.equals("");
    if (hasBackground) {
      backgroundImage = loadImage(backgroundImageFile);
    }
    displayText = false;
    textSize = 50;
    textWidth = imageWidth;
    textHeight = imageHeight;
  }
  
  public TextObject(String identifier, int x, int y, int owidth,
    int oheight, String gameObjectImageFile, String text, int textX, int textY, String backgroundImageFile, boolean displayText, int textSize, boolean stayOnScreen) {
    super(identifier, x, y, owidth, oheight, gameObjectImageFile);
    this.text = text;
    this.textX = textX;
    this.textY = textY;
    this.stayOnScreen = stayOnScreen;
    hasBackground = !backgroundImageFile.equals("");
    if (hasBackground) {
      backgroundImage = loadImage(backgroundImageFile);
    }
    this.displayText = displayText;
    this.textSize = textSize;
    calculateTextArea(); //Automatically calculates the area
    //necessary to display the entire text.
  }

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
    if (displayText && hasBackground) {
        image(backgroundImage, textX, textY, textWidth + 30, textHeight);
    }
    if (displayText && text != "") {
      if (hasBackground) {
        image(backgroundImage, textX, textY, textWidth + 30, textHeight);
        fill(0);
        textSize(textSize);
        text(text, textX + textHeight/1.5, textY + textHeight/1.5);
      } else {
        fill(255);
        rect(textX, textY, textWidth + 30, textHeight, 8);
        fill(0);
        textSize(textSize);
        text(text, textX + textHeight/1.5, textY + textHeight/1.5);
      }
    }
  }
  //@Override
  //  public void mouseClicked() {
  //  if (!stayOnScreen) {
  //    displayText = false;
  //    if (mouseIsHovering) {
  //      displayText = true;
  //    }
  //  }
  //}
  
  @Override
    public void mousePressed() {
    if (!stayOnScreen) {
      displayText = false;
      if (mouseIsHovering) {
        displayText = true;
      }
    }
  }

  public void calculateTextArea() {
    textWidth = textWidth(text) * (textSize / 10);
    float remaining = textWidth - 100;
    textWidth = (textWidth > 1000) ? 1000 : textWidth;
    textHeight = 50;
    if (textSize == 50) {
      while (remaining > 300)
      {
        textHeight += 30;
        remaining -= 300;
      }
    } else {
      while (remaining > 100)
      {
        textHeight += 30;
        remaining -= 100;
      }
    }
  }
}
