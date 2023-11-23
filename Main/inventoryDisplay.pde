import java.util.Map;

class InventoryDisplay {
  private PImage inventoryImage;
  private int collectablePlacement;
  private Collectable beingDragged;

  InventoryDisplay(String inventoryImageFile) {
    this.inventoryImage = loadImage(inventoryImageFile);
    collectablePlacement = wwidth - inventoryWidth + 35;
    beingDragged = null;
  }

  public void draw() {
    image(inventoryImage, wwidth - inventoryWidth, 0, inventoryWidth, wheight);
    for (int i = 0; i < inventoryManager.collectables.size(); i++) {
      Collectable curCollectable = inventoryManager.collectables.get(i);
      image(curCollectable.gameObjectImage, collectablePlacement + (77 * (i%2)), 187 + (73 * ceil(i/2)), 60, 60);
    }
    if (beingDragged != null) {
      image(beingDragged.gameObjectImage, mouseX - 30, mouseY - 30, 60, 60);
    }
  }

  public void mousePressed() {
    Collectable collectable = returnCollectableOnMouse();
    if (collectable != null) {
      println(collectable.name);
      beingDragged = collectable;
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
        float curColX = collectablePlacement + (77 * (i%2));
        float curColY = 187 + (73 * ceil(i/2));
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
