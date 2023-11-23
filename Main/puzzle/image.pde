void Images() {
  
  Images.add(loadImage("0.png"));
  Images.add(loadImage("1.png"));
  Images.add(loadImage("2.png"));
  Images.add(loadImage("3.png"));
  Images.add(loadImage("4.png"));
  Images.add(loadImage("5.png"));
  Images.add(loadImage("6.png"));
  Images.add(loadImage("7.png"));
  Images.add(loadImage("8.png"));
  Images.add(loadImage("9.png"));
  Images.add(loadImage("10.png"));
  Images.add(loadImage("11.png"));
  Images.add(loadImage("12.png"));
  Images.add(loadImage("13.png"));
  Images.add(loadImage("14.png"));
  Images.add(loadImage("15.png"));
  
  for (PImage Image : Images) {
    Image.resize(gridSize, gridSize);    
  }
}
