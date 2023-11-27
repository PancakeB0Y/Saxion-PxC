import processing.sound.*;

int wwidth = 1920;
int wheight = 1080;
int inventoryWidth = wwidth/7;

SceneManager sceneManager = new SceneManager();
InventoryManager inventoryManager = new InventoryManager();
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
  
  loadScenes();
}

void loadScenes() {
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
  RequireObject lock = new RequireObject("requiresStone_scene01", width/6 - 100, height * 3/6 - 100, 50, 50, "lock.png", "This lock seems brittle....", stone, moveToScene02, false);
  scene01.addGameObject(colStone);
  scene01.addGameObject(lock);

  Scene scene02 = new Scene("scene02", "scene02.jpg");
  MoveToSceneObject moveToScene03 = new MoveToSceneObject("goToScene03_scene02", width/2 - 90, height/2 - 50, 50, 50, "arrowUp.png", "scene03");
  MoveToSceneObject goBackScene01 = new MoveToSceneObject("goBack_scene01", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene02.addGameObject(moveToScene03);
  scene02.addGameObject(goBackScene01);

  Scene scene03 = new Scene("scene03", "scene03.jpg");
  MoveToSceneObject goBackScene02_scene03 = new MoveToSceneObject("goBack_scene02_scene03", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  MoveToSceneObject moveToHideScene = new MoveToSceneObject("goToHideScene_scene04", 200, 450, 50, 50, "arrowDown.png", "hideScene");
  MoveToSceneObject moveToHideScene2 = new MoveToSceneObject("goToGameOverScene1_scene03", 1100, 450, 50, 50, "arrowDown.png", "gameOverScene");
  MoveToSceneObject moveToHideScene3 = new MoveToSceneObject("goToGameOverScene2_scene03", 1300, 450, 50, 50, "arrowDown.png", "gameOverScene");
  MoveToSceneObject moveToGameOverScene = new MoveToSceneObject("goToGameOverScene3_scene03", width/2 - 100, height * 2/6, 50, 50, "arrowUp.png", "gameOverScene");
  scene03.addGameObject(goBackScene02_scene03);
  scene03.addGameObject(moveToHideScene);
  scene03.addGameObject(moveToHideScene2);
  scene03.addGameObject(moveToHideScene3);
  scene03.addGameObject(moveToGameOverScene);

  Scene hideScene = new Scene("hideScene", "");
  MoveToSceneObject moveToScene03_2 = new MoveToSceneObject("goToScene03_2_scene03", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", "scene03_2");
  RequireObject stoneTarget = new RequireObject("requiresStone_hideScene", width/2 - 100, height * 3/6 - 100, 50, 50, "medal1.png", "", stone, moveToScene03_2);
  hideScene.addGameObject(stoneTarget);

  Scene scene03_2 = new Scene("scene03_2", "scene03.jpg");
  MoveToSceneObject moveToScene04 = new MoveToSceneObject("goToScene04_scene03", width/2 - 100, height * 2/6, 50, 50, "arrowUp.png", "scene04");
  scene03_2.addGameObject(moveToScene04);

  Scene scene04 = new Scene("scene04", "scene04.jpg");
  MoveToSceneObject goBackScene03 = new MoveToSceneObject("goBack_scene03", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene05 = new MoveToSceneObject("goToScene05_scene04", width/2 - 100, 350, 50, 50, "arrowUp.png", "scene05");
  scene04.addGameObject(goBackScene03);
  scene04.addGameObject(moveToScene05);

  Scene scene05 = new Scene("scene05", "scene05.jpg");
  MoveToSceneObject goBackScene04 = new MoveToSceneObject("goBack_scene04", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  RequireObject inspectDoor1 = new RequireObject("inspectDoor1", 205, 590, 50, 50, "apple.png", "This door is locked", null, null);
  inspectDoor2 = new RequireObject("inspectDoor2", width/3 + 65, 490, 50, 50, "apple.png", "This door is locked", null, null);
  MoveToSceneObject moveToScene06 = new MoveToSceneObject("goToScene06_scene05", width/3 + 65, 490, 50, 50, "apple.png", "scene06");
  mosaic = new MosaicPuzzle("mosaic", 600, 200, 600, 600, "mosaic_white.png");
  CloseUpObject mosaicObject = new CloseUpObject("testMinigameObject", 795, 325, 100, 100, "mosaic_white.png", mosaic, moveToScene06);
  Collectable crystal = new Collectable("crystal", "crystal.png");
  MoveToSceneObject moveToScene07 = new MoveToSceneObject("goToScene07_scene05", width * 4/6 - 90, 625, 50, 50, "apple.png", "scene07");
  RequireObject inspectDoor3 = new RequireObject("inspectDoor3", width * 4/6 - 90, 625, 50, 50, "apple.png", "This door is locked", crystal, moveToScene07);
  scene05.addGameObject(goBackScene04);
  scene05.addGameObject(inspectDoor1);
  scene05.addGameObject(inspectDoor2);
  scene05.addGameObject(mosaicObject);
  scene05.addGameObject(inspectDoor3);

  Scene scene06 = new Scene("scene06", "scene06.jpg");
  CollectableObject colCrystal = new CollectableObject("crystal_scene06", 600, 400 - 20, 50, 80, crystal);
  MoveToSceneObject goBackScene05 = new MoveToSceneObject("goBack_scene05", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene06.addGameObject(colCrystal);
  scene06.addGameObject(goBackScene05);

  Scene scene07 = new Scene("scene07", "scene07.jpg");
  MoveToSceneObject goBackScene06 = new MoveToSceneObject("goBack_scene06", width/2 - 100, height * 5/6, 50, 50, "arrowDown.png", true);
  scene07.addGameObject(goBackScene06);

  Scene gameOverScene = new Scene("gameOverScene", "jumpscare.png", false);
  RestartObject restartButton = new RestartObject("restartButton", width/2 - (505/2), 100, 505, 147, "restartButton.png");
  gameOverScene.addGameObject(restartButton);

  sceneManager.addScene(startMenu);
  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(hideScene);
  sceneManager.addScene(scene03_2);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
  sceneManager.addScene(scene06);
  sceneManager.addScene(scene07);
  sceneManager.addScene(gameOverScene);
}

void restart(){
  sceneManager = new SceneManager();
  inventoryManager = new InventoryManager();
  loadScenes();
}

void draw()
{
  if (mosaic != null && mosaic.isWon) {
    if (inspectDoor2 != null) {
      inspectDoor2.displayText = false;
    }
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
