import processing.sound.*;

int wwidth = 1920;
int wheight = 1080;
int inventoryWidth = wwidth/7;

final SceneManager sceneManager = new SceneManager();
final InventoryManager inventoryManager = new InventoryManager();
InventoryDisplay inventoryDisplay;

SoundFile interactSound;
SoundFile breakSound;
SoundFile whooshSound;
SoundFile beatenPuzzleSound;

MosaicPuzzle mosaic;
RequireObject inspectDoor2;

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  interactSound = new SoundFile(this, "interact.wav");
  interactSound.amp(0.5);
  breakSound = new SoundFile(this, "whoosh.wav");
  breakSound.amp(0.5);
  whooshSound = new SoundFile(this, "whooshBig.wav");
  whooshSound.amp(0.1);
  beatenPuzzleSound = new SoundFile(this, "sparkling.wav");
  beatenPuzzleSound.amp(0.1);

  inventoryDisplay = new InventoryDisplay("inventory.png");

  Scene startMenu = new Scene("scene01", "", false);
  MoveToSceneObject startButton = new MoveToSceneObject("goToScene01", width/2 - (505/2), height/2 - 300, 505, 147, "startButton.png", "scene01");
  GameObject optionsButton = new GameObject("optionsButton", width/2 - (505/2), height/2 - 100, 505, 147, "optionsButton.png");
  QuitObject quitButton = new QuitObject("quitButton", width/2 - (505/2), height/2 + 100, 505, 147, "quitButton.png");
  startMenu.addGameObject(startButton);
  startMenu.addGameObject(optionsButton);
  startMenu.addGameObject(quitButton);

  Scene scene01 = new Scene("scene01", "scene01.jpg");
  Collectable stone = new Collectable("stone", "stone.png");
  CollectableObject colStone = new CollectableObject("stone_scene01", width - width/5 - 20, height/2 - 20, 50, 50, stone);
  MoveToSceneObject moveToScene02 = new MoveToSceneObject("goToScene02_scene01", width/6 - 100, height * 3/6 - 100, 50, 50, "arrowUp.png", "scene02");
  RequireObject lock = new RequireObject("requiresStone_scene01", width/6 - 100, height * 3/6 - 100, 50, 50, "lock.png", "This lock seems brittle....", stone, moveToScene02);
  scene01.addGameObject(colStone);
  scene01.addGameObject(lock);

  Scene scene02 = new Scene("scene02", "scene02.jpg");
  MoveToSceneObject moveToScene03 = new MoveToSceneObject("goToScene03_scene02", width/2 - 90, height/2 - 50, 50, 50, "arrowUp.png", "scene03");
  MoveToSceneObject goBackScene01 = new MoveToSceneObject("goBack_scene01", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene02.addGameObject(moveToScene03);
  scene02.addGameObject(goBackScene01);

  Scene scene03 = new Scene("scene03", "scene03.jpg");
  MoveToSceneObject goBackScene02 = new MoveToSceneObject("goBack_scene02", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  RequireObject inspectDoor1 = new RequireObject("inspectDoor1", 205, 590, 50, 50, "apple.png", "This door is locked", null, null);
  inspectDoor2 = new RequireObject("inspectDoor2", width/3 + 65, 490, 50, 50, "apple.png", "This door is locked", null, null);
  MoveToSceneObject moveToScene04 = new MoveToSceneObject("goToScene04_scene03", width/3 + 65, 490, 50, 50, "apple.png", "scene04");
  mosaic = new MosaicPuzzle("mosaic", 600, 200, 600, 600, "mosaic_white.png");
  CloseUpObject mosaicObject = new CloseUpObject("testMinigameObject", 795, 325, 100, 100, "mosaic_white.png", mosaic, moveToScene04);
  Collectable crystal = new Collectable("crystal", "crystal.png");
  MoveToSceneObject moveToScene05 = new MoveToSceneObject("goToScene05_scene03", width * 4/6 - 90, 625, 50, 50, "apple.png", "scene05");
  RequireObject inspectDoor3 = new RequireObject("inspectDoor3", width * 4/6 - 90, 625, 50, 50, "apple.png", "This door is locked", crystal, moveToScene05);
  scene03.addGameObject(goBackScene02);
  scene03.addGameObject(inspectDoor1);
  scene03.addGameObject(inspectDoor2);
  scene03.addGameObject(mosaicObject);
  scene03.addGameObject(inspectDoor3);

  Scene scene04 = new Scene("scene04", "scene04.jpg");
  CollectableObject colCrystal = new CollectableObject("crystal_scene04", 600, 400 - 20, 50, 80, crystal);
  MoveToSceneObject goBackScene03 = new MoveToSceneObject("goBack_scene03", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene04.addGameObject(colCrystal);
  scene04.addGameObject(goBackScene03);

  Scene scene05 = new Scene("scene05", "scene05.jpg");
  MoveToSceneObject goBackScene03_scene05 = new MoveToSceneObject("goBack_scene03_scene05", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene06 = new MoveToSceneObject("goToScene06_scene05", width/2 - 100, 350, 50, 50, "arrowUp.png", "scene06");
  scene05.addGameObject(goBackScene03_scene05);
  scene05.addGameObject(moveToScene06);

  Scene scene06 = new Scene("scene06", "scene06.jpg");
  MoveToSceneObject goBackScene05 = new MoveToSceneObject("goBack_scene05", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene06.addGameObject(goBackScene05);

  sceneManager.addScene(startMenu);
  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
  sceneManager.addScene(scene06);

  //Collectable apple = new Collectable("apple", "back04_apple.png");
  //MoveToSceneObject object7 = new MoveToSceneObject("goToScene04_scene01", 206, 461, 50, 50, "arrowUp.png", "scene04");

  //Scene scene01 = new Scene("scene01", "back01.png");
  //RequireObject loupe01 = new RequireObject("requiresApple_scene01", 206, 461, 50, 50, "zoom.png", "You need an Apple before getting here!", apple, object7);
  //loupe01.setHoverImage("zoomIn.png");
  //scene01.addGameObject(loupe01);
  //TextObject loupe02 = new TextObject("smallText_scene01", 541, 445, 50, 50, "zoom.png", "This object has a text!");
  //loupe02.setHoverImage("zoomIn.png");
  //scene01.addGameObject(loupe02);
  //TextObject loupe03 = new TextObject("largeText_scene01", 46, 687, 50, 50, "zoom.png", "This object has a way longer text. It shows that the windows can be of varied size according to the text.");
  //loupe03.setHoverImage("zoomIn.png");
  //scene01.addGameObject(loupe03);
  //MoveToSceneObject object2 = new MoveToSceneObject("goToScene02_scene01", 708, 445, 50, 50, "arrowRight.png", "scene02");
  //scene01.addGameObject(object2);
  //MoveToSceneObject restaurantSceneMoveTo = new MoveToSceneObject("goToScene06_scene01", 388, 440, 50, 50, "arrowUp.png", "scene05");
  //scene01.addGameObject(restaurantSceneMoveTo);

  //Scene scene02 = new Scene("scene02", "back02.png");
  //MoveToSceneObject object3 = new MoveToSceneObject("goBack_scene02", 350, 700, 50, 50, "arrowDown.png", true);
  //scene02.addGameObject(object3);
  //MoveToSceneObject object4 = new MoveToSceneObject("goToScene03_scene02", 441, 494, 50, 50, "arrowUp.png", "scene03");
  //scene02.addGameObject(object4);

  //Scene scene03 = new Scene("scene03", "back04.png");
  //MoveToSceneObject object5 = new MoveToSceneObject("goBack_scene03", 203, 673, 50, 50, "arrowDown.png", true);
  //scene03.addGameObject(object5);
  //CollectableObject object6 = new CollectableObject("apple_scene03", 325, 366, 123, 101, apple);
  //scene03.addGameObject(object6);

  //Collectable pear = new Collectable("pear", "pear.png");
  //CollectableObject object13 = new CollectableObject("pear", 500, 500, 123, 101, pear);
  //scene03.addGameObject(object13);

  //Collectable apple2 = new Collectable("apple2", "back04_apple.png");
  //CollectableObject object14 = new CollectableObject("apple_scene03_2", 200, 200, 123, 101, apple2);
  //scene03.addGameObject(object14);

  //Scene scene04 = new Scene("scene04", "back03.png");
  //TextObject endGame = new TextObject("smallText_scene04", 430, 590, 50, 50, "medal1.png", "Congratulations. You finished the game!");
  //scene04.addGameObject(endGame);

  //Scene scene05 = new Scene("scene05", "back05.png");
  //MoveToSceneObject object8 = new MoveToSceneObject("goBack_scene01", 203, 753, 50, 50, "arrowDown.png", true);
  //scene05.addGameObject(object8);
  //TextObject loupe04 = new TextObject("smallText_scene05", 120, 275, 50, 50, "zoom.png", "Have you checked the apples in that odd house to the right?");
  //loupe04.setHoverImage("zoomIn.png");
  //scene05.addGameObject(loupe04);
  //TextObject loupe05 = new TextObject("smallText_2_scene05", 480, 285, 50, 50, "zoom.png", "Hello! How are you doing?");
  //loupe05.setHoverImage("zoomIn.png");
  //scene05.addGameObject(loupe05);

  //sceneManager.addScene(scene01);
  //sceneManager.addScene(scene02);
  //sceneManager.addScene(scene03);
  //sceneManager.addScene(scene04);
  //sceneManager.addScene(scene05);
}

void draw()
{
  if (mosaic.isWon) {
    inspectDoor2.displayText = false;
  }
  sceneManager.getCurrentScene().draw();
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();
}

void mouseMoved() {
  sceneManager.getCurrentScene().mouseMoved();
}

void mouseClicked() {
  sceneManager.getCurrentScene().mouseClicked();
}

public void mouseReleased() {
  sceneManager.getCurrentScene().mouseReleased();
}

public void mouseDragged() {
  sceneManager.getCurrentScene().mouseDragged();
}

public void mousePressed() {
  sceneManager.getCurrentScene().mousePressed();
}
