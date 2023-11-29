import java.util.Map;

class InventoryDisplay {
  private PImage inventoryImage;
  private Collectable beingDragged;
  private float startX;
  private float startY;
  private float rowSpacing;
  private float colSpacing;

  InventoryDisplay(String inventoryImageFile) {
    this.inventoryImage = loadImage(inventoryImageFile);
    beingDragged = null;
    startX = wwidth - (inventoryWidth/1.25);
    startY = 50;
    rowSpacing = wwidth/18.0;
    colSpacing = wheight/12.0;
  }

  public void draw() {
    image(inventoryImage, wwidth - inventoryWidth, 0, inventoryWidth, wheight);
    for (int i = 0; i < inventoryManager.collectables.size(); i++) {
      Collectable curCollectable = inventoryManager.collectables.get(i);
      image(curCollectable.gameObjectImage, startX + (rowSpacing * (i%2)), startY + (colSpacing * ceil(i/2)), 60, 60);
      if (curCollectable.getClass().getSimpleName().equals("CloseUpCollectable")) {
        curCollectable.draw();
      }
    }
    if (beingDragged != null) {
      image(beingDragged.gameObjectImage, mouseX - 30, mouseY - 30, 60, 60);
    }
  }

  public void mousePressed() {
    for (int i = 0; i < inventoryManager.collectables.size(); i++) {
      Collectable curCollectable = inventoryManager.collectables.get(i);
      if (curCollectable.getClass().getSimpleName().equals("CloseUpCollectable")) {
        curCollectable.mousePressed();
      }
    }
    
    Collectable collectable = returnCollectableOnMouse();
    if (collectable != null) {
      if (collectable.getClass().getSimpleName().equals("CloseUpCollectable")) {
        collectable.isOpen = true;
      } else {
        beingDragged = collectable;
        collectable = null;
      }
    }
  }

  public void mouseReleased() {
    beingDragged = null;
  }

  public Collectable returnCollectableOnMouse() {
    if (inventoryManager.collectables.size() != 0) {
      Collectable collectable = new Collectable("", "");

      for (int i = 0; i < inventoryManager.collectables.size(); i++) {
        Collectable curCollectable = inventoryManager.collectables.get(i);
        float curColX = startX + (rowSpacing * (i%2));
        float curColY = startY + (colSpacing * ceil(i/2));
        if (mouseX >= curColX && mouseX <= curColX + 60 &&
          mouseY >= curColY && mouseY <= curColY + 60) {
          collectable = curCollectable;
          return collectable;
        }
      }
    }

    return null;
  }
}
