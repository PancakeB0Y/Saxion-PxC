import java.util.Map;

class InventoryDisplay {
  private PImage inventoryImage;
  private Map<String, PImage> collectableImages;
  private int collectablePlacement;

  InventoryDisplay(String inventoryImageFile) {
    this.inventoryImage = loadImage(inventoryImageFile);
    collectableImages = new HashMap<>();
    collectablePlacement = wwidth - inventoryWidth + 35;
  }

  public void draw() {
    image(inventoryImage, wwidth - inventoryWidth, 0, inventoryWidth, wheight);
    int i = 0;
    for (Map.Entry<String, PImage> entry : collectableImages.entrySet()) {
      PImage curImage = entry.getValue();
      image(curImage, collectablePlacement + (77 * (i%2)), 187 + (73 * ceil(i/2)), 60, 60);
      i++;
    }
  }
}
