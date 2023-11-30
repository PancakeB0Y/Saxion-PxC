import processing.sound.*;

int wwidth = 1920;
int wheight = 1080;
int inventoryWidth = wwidth/7;

SceneManager sceneManager = new SceneManager();
InventoryManager inventoryManager = new InventoryManager();
InventoryDisplay inventoryDisplay;

SoundFile interactSound;
SoundFile whooshSound;
SoundFile beatenPuzzleSound;
SoundFile lockBreakSound;
SoundFile monsterStartSound;
SoundFile monsterCloseIndicatorSound;
SoundFile deadSound;
SoundFile backgroundSound;
SoundFile monsterApproachingSound;

float footstepsVolume = 0;
float volumeIncrease = 0;
float volumeIncreaseMultiplier = 1.0;
float footstepsRate = 2;
float footstepsRateIncrease = 0;

boolean chaseStarted = false;
boolean isMonsterClose = false;
boolean isGameOver = false;

int timer = 3000;
int lastTime = 0;
int timeFromStart = 0;
boolean startTimer = false;

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  interactSound = new SoundFile(this, "interact.wav");
  interactSound.amp(0.1);
  whooshSound = new SoundFile(this, "whooshBig.wav");
  whooshSound.amp(0.005);
  beatenPuzzleSound = new SoundFile(this, "sparkling.wav");
  beatenPuzzleSound.amp(0.05);
  lockBreakSound = new SoundFile(this, "lock_break.wav");
  lockBreakSound.amp(0.01);
  monsterStartSound = new SoundFile(this, "monsterStart.wav");
  monsterStartSound.amp(0.05);
  monsterCloseIndicatorSound = new SoundFile(this, "monsterCloseIndicator.wav");
  monsterCloseIndicatorSound.amp(0.5);
  deadSound = new SoundFile(this, "dead.wav");
  deadSound.amp(0.7);
  backgroundSound = new SoundFile(this, "background.wav");
  backgroundSound.amp(0.07);
  monsterApproachingSound = new SoundFile(this, "footsteps.wav");
  monsterApproachingSound.amp(footstepsVolume);
  monsterApproachingSound.rate(footstepsRate);

  loadScenes();
}

void loadScenes() {
  backgroundSound.stop();
  monsterApproachingSound.stop();
  monsterApproachingSound.loop();
  footstepsVolume = 0.001;
  footstepsRate = 2;
  footstepsRateIncrease = 0;
  isGameOver = false;

  inventoryDisplay = new InventoryDisplay("inventory.png");

  Scene startMenu = new Scene("scene01", "startImage.png", false);
  MoveToSceneObject startButton = new MoveToSceneObject("goToScene01", wwidth/2 - 505/2, 400, 505, 147, "startButton.png", "scene01");
  QuitObject quitButton = new QuitObject("quitButton", wwidth/2 - 505/2, 600, 505, 147, "quitButton.png");
  startMenu.addGameObject(startButton);
  startMenu.addGameObject(quitButton);

  Scene scene01 = new Scene("scene01", "scene01.jpg", backgroundSound);
  Collectable stone = new Collectable("stone", "stone.png");
  CollectableObject colStone = new CollectableObject("stone_scene01", width - width/5 - 580, height/2 + 50, 60, 60, "stone.png", stone);
  MoveToSceneObject moveToScene02 = new MoveToSceneObject("goToScene02_scene01", width/6 - 100, height * 3/6 - 100, 70, 50, "arrowUp.png", "scene02", whooshSound);
  RequireObject lock = new RequireObject("requiresStone_scene01", width/6 - 100, height * 3/6 - 100, 50, 50, "lock.png", "This lock seems brittle....", stone, moveToScene02, false, lockBreakSound);
  scene01.addGameObject(colStone);
  scene01.addGameObject(lock);

  Scene scene02 = new Scene("scene02", "scene02.jpg", monsterStartSound);
  MoveToSceneObject moveToScene03 = new MoveToSceneObject("goToScene03_scene02", width/2 - inventoryWidth/2 - 10, height/2 + 30, 45, 30, "arrowUp.png", "scene03", whooshSound);
  MoveToSceneObject goBackScene01 = new MoveToSceneObject("goBack_scene01", width/2 - inventoryWidth/2 - 20, height * 5/6, 70, 50, "arrowDown.png", true);
  scene02.addGameObject(moveToScene03);
  scene02.addGameObject(goBackScene01);

  Scene scene03 = new Scene("scene03", "scene03.jpg");
  MoveToSceneObject goBackScene02_scene03 = new MoveToSceneObject("goBack_scene02_scene03", width/2 - inventoryWidth/2 - 20, height * 5/6, 70, 50, "arrowDown.png", true);
  TextObject hideBehindBarrels = new TextObject("hideBehindBarrels", 0, 0, 0, 0, "", "Hide behind barrels", 65, 350, "", true, 30, true);
  MoveToSceneObject moveToHideScene = new MoveToSceneObject("goToHideScene_scene04", 200, 450, 70, 50, "arrowDown.png", "hideScene");
  TextObject hideInsideCabinet = new TextObject("hideInsideCabinet", 0, 0, 0, 0, "", "Hide inside cabinet", 960, 350, "", true, 30, true);
  MoveToSceneObject moveToHideScene2 = new MoveToSceneObject("goTohideSceneCabinet1_scene03", 1100, 450, 70, 50, "arrowDown.png", "hideSceneCabinet1");
  TextObject hideBehindPillar = new TextObject("hideBehindPillar", 0, 0, 0, 0, "", "Hide behind pillar", 1260, 350, "", true, 30, true);
  MoveToSceneObject moveToHideScene3 = new MoveToSceneObject("goTohideScenePillar1_scene03", 1400, 450, 70, 50, "arrowDown.png", "hideScenePillar1");
  MoveToSceneObject moveToGameOverScene = new MoveToSceneObject("goToGameOverScene3_scene03", width/2 - 130, height * 1/6 + 120, 50, 33, "arrowUp.png", "gameOverScene", deadSound);
  scene03.addGameObject(goBackScene02_scene03);
  scene03.addGameObject(hideBehindBarrels);
  scene03.addGameObject(moveToHideScene);
  scene03.addGameObject(hideInsideCabinet);
  scene03.addGameObject(moveToHideScene2);
  scene03.addGameObject(hideBehindPillar);
  scene03.addGameObject(moveToHideScene3);
  scene03.addGameObject(moveToGameOverScene);

  Scene hideScene = new Scene("hideScene", "");
  MoveToSceneObject moveToScene03_2 = new MoveToSceneObject("goToScene03_2_scene03", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", "scene03_2", whooshSound);
  RequireObject stoneTarget = new RequireObject("requiresStone_hideScene", width/2 - 100, height * 3/6 - 100, 50, 50, "medal1.png", "", stone, moveToScene03_2);
  hideScene.addGameObject(stoneTarget);

  Scene hideSceneCabinet1 = new Scene("hideSceneCabinet1", "hideSceneCabinet1.png", false);
  Scene hideSceneCabinet2 = new Scene("hideSceneCabinet2", "hideSceneCabinet1.png", false);
  GameObject cabinetMonster = new GameObject("cabinetMonster", -127, 0, width + 125, height, "cabinetMonster.png");
  hideSceneCabinet2.addGameObject(cabinetMonster);

  Scene hideScenePillar1 = new Scene("hideScenePillar1", "hideScenePillar1.png", false);
  Scene hideScenePillar2 = new Scene("hideScenePillar2", "jumpscare.png", false);

  Scene scene03_2 = new Scene("scene03_2", "scene03.jpg");
  MoveToSceneObject moveToScene04 = new MoveToSceneObject("goToScene04_scene03", width/2 - 100, height * 2/6, 70, 50, "arrowUp.png", "scene04", whooshSound);
  scene03_2.addGameObject(moveToScene04);

  Scene scene04 = new Scene("scene04", "scene04.jpg");
  MoveToSceneObject goBackScene03 = new MoveToSceneObject("goBack_scene03", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene05 = new MoveToSceneObject("goToScene05_scene04", width/2 - 100, 350, 70, 50, "arrowUp.png", "scene05", whooshSound);
  scene04.addGameObject(goBackScene03);
  scene04.addGameObject(moveToScene05);

  Scene scene05 = new Scene("scene05", "scene05.jpg");
  MoveToSceneObject goBackScene04 = new MoveToSceneObject("goBack_scene04", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  RequireObject inspectDoor1 = new RequireObject("inspectDoor1", 620, 590, 50, 50, "apple.png", "This door is locked", (Collectable)null, null);
  MoveToSceneObject moveToScene06 = new MoveToSceneObject("goToScene06_scene05", width/3 + 285, 605, 50, 50, "apple.png", "scene06", whooshSound);
  MosaicPuzzle mosaic = new MosaicPuzzle("mosaic", 600, 200, 600, 600, "mosaic_white.png");
  RequireObject inspectDoor2 = new RequireObject("inspectDoor2", width/3 + 285, 605, 50, 50, "apple.png", "This door is locked", mosaic, moveToScene06, null);
  CloseUpObject mosaicObject = new CloseUpObject("mosaicObject", 835, 410, 100, 100, "mosaic_white.png", mosaic);
  Collectable crystal = new Collectable("crystal", "crystal.png");
  MoveToSceneObject moveToScene07 = new MoveToSceneObject("goToScene07_scene05", width * 4/6 + 55, 630, 50, 50, "apple.png", "scene07", whooshSound);
  RequireObject inspectDoor3 = new RequireObject("inspectDoor3", width * 4/6 - 100, 430, 300, 300, "apple.png", "This door is locked", crystal, moveToScene07);
  scene05.addGameObject(goBackScene04);
  scene05.addGameObject(inspectDoor1);
  scene05.addGameObject(inspectDoor2);
  scene05.addGameObject(mosaicObject);
  scene05.addGameObject(inspectDoor3);

  Scene scene06 = new Scene("scene06", "scene06.jpg");
  CloseUpCollectable scroll = new CloseUpCollectable("scroll", "map_icon.png", "map.png");
  CollectableObject colScroll = new CollectableObject("scroll_scene06", 700, 500, 50, 50, "map_icon.png", scroll);
  CollectableObject colCrystal = new CollectableObject("crystal_scene06", 845, 450, 70, 90, "", crystal);
  MoveToSceneObject goBackScene05 = new MoveToSceneObject("goBack_scene05", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  scene06.addGameObject(colScroll);
  scene06.addGameObject(colCrystal);
  scene06.addGameObject(goBackScene05);

  Scene scene07 = new Scene("scene07", "scene07.jpg");
  MoveToSceneObject goBackScene06 = new MoveToSceneObject("goBack_scene06", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene08 = new MoveToSceneObject("goToScene08_scene07", 500, 400, 50, 50, "arrowUp.png", "scene08", whooshSound);
  BookPuzzle bookPuzzle = new BookPuzzle("mosaic", 600, 200, 600, 400, "");
  CloseUpObject bookPuzzleObject = new CloseUpObject("bookPuzzleObject", 500, 400, 100, 100, "mosaic_white.png", bookPuzzle, moveToScene08);
  scene07.addGameObject(goBackScene06);
  scene07.addGameObject(bookPuzzleObject);

  Scene scene08 = new Scene("scene08", "scene08.jpg");
  MoveToSceneObject moveToVictoryScene = new MoveToSceneObject("goToVictoryScene_scene08", width/2 - 160, 400, 70, 50, "arrowUp.png", "victoryScene", whooshSound);
  MoveToSceneObject goBackScene07 = new MoveToSceneObject("goBack_scene07", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  SequencePuzzle sequencePuzzle = new SequencePuzzle("mosaic", 500, 300, 600, 600, "mosaic_white.png");
  CloseUpObject sequencePuzzleObject = new CloseUpObject("bookPuzzleObject", 1350, 570, 200, 100, "mosaic_white.png", sequencePuzzle, moveToVictoryScene);
  RequireObject inspectPortal = new RequireObject("inspectPortal", width/2 - 300, 200, 300, 400, "", "The portal isn't working", sequencePuzzle, moveToVictoryScene, null);
  scene08.addGameObject(goBackScene07);
  scene08.addGameObject(inspectPortal);
  scene08.addGameObject(sequencePuzzleObject);

  Scene victoryScene = new Scene("victoryScene", "", false);
  RestartObject restartButton1 = new RestartObject("restartButton", width/2 - (505/2), 100, 505, 147, "restartButton.png");
  victoryScene.addGameObject(restartButton1);

  Scene gameOverScene = new Scene("gameOverScene", "jumpscare.png", false);
  RestartObject restartButton2 = new RestartObject("restartButton", width/2 - 300, 100, 505, 147, "restartButton.png");
  gameOverScene.addGameObject(restartButton2);

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
  sceneManager.addScene(scene08);
  sceneManager.addScene(victoryScene);
  sceneManager.addScene(gameOverScene);
  sceneManager.addScene(hideSceneCabinet1);
  sceneManager.addScene(hideSceneCabinet2);
  sceneManager.addScene(hideScenePillar1);
  sceneManager.addScene(hideScenePillar2);
}

void restart() {
  sceneManager = new SceneManager();
  inventoryManager = new InventoryManager();
  loadScenes();
}

void draw()
{
  println(footstepsVolume);
  sceneManager.getCurrentScene().draw();
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();

  monsterApproachingSound.amp(footstepsVolume);
  monsterApproachingSound.rate(footstepsRate);

  footstepsVolume+=(volumeIncrease * volumeIncreaseMultiplier);
  footstepsRate+=footstepsRateIncrease;

  //Check if game is won
  if (sceneManager.getCurrentScene().sceneName == "victoryScene") {
    stopGame();
  }

  //Start chase and start increasing the volume gradually
  if (sceneManager.getCurrentScene().sceneName == "scene02") {
    chaseStarted = true;
  }

  if (chaseStarted) {
    volumeIncrease = 0.0004;
    footstepsRateIncrease = 0.003;
    volumeIncreaseMultiplier+=0.008;
  }

  if (footstepsVolume >= 0.15 && !isMonsterClose) {
    monsterCloseIndicatorSound.play();
    isMonsterClose = true;
  }
  //If the volue is loud enough the monster catches the player
  if (footstepsVolume >= 0.2) {
    try {
      if (!isGameOver) {
        sceneManager.goToScene("gameOverScene");
        deadSound.play();
        stopGame();
      }
    }
    catch(Exception e) {
      println(e);
    }
  }

  //Timer for death sequences
  if (startTimer) {
    lastTime = millis() - timeFromStart;
  }

  //Changing of scenes for death sequences
  if (sceneManager.getCurrentScene().sceneName == "hideSceneCabinet1") {
    if (!startTimer) {
      startTimer();
      isGameOver = true;
    } else {
      if (lastTime>= timer) {
        try {
          sceneManager.goToScene("hideSceneCabinet2");
        }
        catch(Exception e) {
          println(e);
        }
        deadSound.play();
        stopTimer();
        stopGame();
      }
    }
  }

  if (sceneManager.getCurrentScene().sceneName == "hideScenePillar1") {
    if (!startTimer) {
      startTimer();
      isGameOver = true;
    } else {
      if (lastTime>= timer) {
        try {
          sceneManager.goToScene("hideScenePillar2");
        }
        catch(Exception e) {
          println(e);
        }
        deadSound.play();
        stopTimer();
        stopGame();
      }
    }
  }
}

void stopGame() {
  footstepsVolume = 0;
  volumeIncrease = 0;
  volumeIncreaseMultiplier = 1;
  footstepsRateIncrease = 1;
  footstepsRate = 1.5;
  isGameOver = true;
  chaseStarted = false;
  monsterCloseIndicatorSound.stop();
}

void startTimer() {
  timeFromStart = millis();
  startTimer = true;
}

void stopTimer() {
  lastTime = 0;
  startTimer = false;
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
