void Images() {
  Images.add(loadImage("0.png"));
  Images.add(loadImage("0.png"));
  Images.add(loadImage("1.png"));
  Images.add(loadImage("1.png"));
  Images.add(loadImage("2.png"));
  Images.add(loadImage("2.png"));
  Images.add(loadImage("3.png"));
  Images.add(loadImage("3.png"));
  Images.add(loadImage("4.png"));
  Images.add(loadImage("4.png"));
  Images.add(loadImage("5.png"));
  Images.add(loadImage("5.png"));
  Images.add(loadImage("6.png"));
  Images.add(loadImage("6.png"));
  Images.add(loadImage("7.png"));
  Images.add(loadImage("7.png"));
  
  for (PImage Image : Images) {
    Image.resize(gridSize, gridSize);
    
  }
}
