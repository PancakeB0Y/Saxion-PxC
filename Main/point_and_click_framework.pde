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
SoundFile metalHitSound;
SoundFile monsterStartSound;
SoundFile monsterCloseIndicatorSound;
SoundFile deadSound;
SoundFile backgroundSound;
SoundFile monsterApproachingSound;
SoundFile glyphOnSound;
SoundFile glyphOffSound;
SoundFile victorySound;

float footstepsVolume = 0;
float volumeIncrease = 0;
float volumeIncreaseMultiplier = 1.0;
float footstepsRate = 2;
float footstepsRateIncrease = 0;
float whistlingStart = 0.24;

boolean chaseStarted = false;
boolean isMonsterClose = false;
boolean isGameOver = false;

int timer = 3000;
int lastTime = 0;
int timeFromStart = 0;
boolean startTimer = false;

int flickerLastTime = 0;
boolean flickerOn = true;

SequencePuzzle sequencePuzzle;

void settings()
{
  size(wwidth, wheight);
}

void setup()
{
  frameRate(60);
  interactSound = new SoundFile(this, "interact.wav");
  interactSound.amp(0.3);
  whooshSound = new SoundFile(this, "whooshBig.wav");
  whooshSound.amp(0.008);
  beatenPuzzleSound = new SoundFile(this, "sparkling.wav");
  beatenPuzzleSound.amp(0.07);
  lockBreakSound = new SoundFile(this, "lock_break.wav");
  lockBreakSound.amp(0.05);
  metalHitSound = new SoundFile(this, "metalHit.wav");
  metalHitSound.amp(0.9);
  monsterStartSound = new SoundFile(this, "monsterStart.wav");
  monsterStartSound.amp(0.05);
  monsterCloseIndicatorSound = new SoundFile(this, "monsterCloseIndicator.wav");
  monsterCloseIndicatorSound.amp(0.45);
  deadSound = new SoundFile(this, "dead.wav");
  deadSound.amp(0.7);
  backgroundSound = new SoundFile(this, "background.wav");
  backgroundSound.amp(0.07);
  monsterApproachingSound = new SoundFile(this, "footsteps.wav");
  monsterApproachingSound.amp(footstepsVolume);
  monsterApproachingSound.rate(footstepsRate);
  glyphOnSound = new SoundFile(this, "glyphOn.wav");
  glyphOnSound.amp(0.3);
  glyphOffSound = new SoundFile(this, "glyphOff.wav");
  glyphOffSound.amp(0.3);
  victorySound = new SoundFile(this, "victory.wav");
  victorySound.amp(0.7);
  loadScenes();
}

void loadScenes() {
  backgroundSound.stop();
  monsterApproachingSound.stop();
  victorySound.stop();
  monsterApproachingSound.loop();
  footstepsVolume = 0;
  volumeIncrease = 0;
  volumeIncreaseMultiplier = 1.0;
  footstepsRate = 2;
  footstepsRateIncrease = 0;
  whistlingStart = 0.24;
  isGameOver = false;

  inventoryDisplay = new InventoryDisplay("inventory.png");

  Scene startMenu = new Scene("scene01", "startImage.png", false);
  MoveToSceneObject startButton = new MoveToSceneObject("goOpeningTextScene", 330, 470, 505, 147, "startButton.png", "openingTextScene");
  QuitObject quitButton = new QuitObject("quitButton", 330, 650, 505, 147, "quitButton.png");
  startMenu.addGameObject(startButton);
  startMenu.addGameObject(quitButton);

  Scene scene01 = new Scene("scene01", "scene01_Closed.png", backgroundSound);
  Scene openingTextScene = new Scene("openingTextScene", "startImage2.png", false);
  MoveToSceneObject moveToScene01 = new MoveToSceneObject("goToScene01", 1750, 850, 70, 100, "arrowRight.png", "scene01");
  openingTextScene.addGameObject(moveToScene01);
  Collectable stone = new Collectable("stone", "stone.png");
  CollectableObject colStone = new CollectableObject("stone_scene01", width - width/5 - 580, height/2 + 50, 60, 60, "stone.png", stone);
  MoveToSceneObject moveToScene02 = new MoveToSceneObject("goToScene02_scene01", 200, 100, 175, 600, "", "scene02", whooshSound);
  RequireObject lock = new RequireObject("requiresStone_scene01", 300, 400, 80, 75, "", "", "lockBrittle.png", stone, moveToScene02, false, lockBreakSound, "scene01_Open.png");
  scene01.addGameObject(colStone);
  scene01.addGameObject(lock);

  Scene scene02 = new Scene("scene02", "scene02.png", monsterStartSound);
  MoveToSceneObject moveToScene03 = new MoveToSceneObject("goToScene03_scene02", width/2 - inventoryWidth/2 - 10, height/2 + 30, 45, 30, "arrowUp.png", "scene03", whooshSound);
  MoveToSceneObject goBackScene01 = new MoveToSceneObject("goBack_scene01", width/2 - inventoryWidth/2 - 20, height * 5/6, 70, 50, "arrowDown.png", true);
  scene02.addGameObject(moveToScene03);
  scene02.addGameObject(goBackScene01);

  Scene scene03 = new Scene("scene03", "scene03_1.png", false);
  GameObject needToHide = new GameObject("needToHide", width/2 - 200, 100, 400, 120, "needToHide.png");
  GameObject hideBehindBarrels = new GameObject("hideBehindBarrels", 1495, height - 250, 330, 100, "hideBarrels.png");
  MoveToSceneObject moveToHideScene = new MoveToSceneObject("scene03_Hide_Barrels.png", 1640, height - 140, 45, 30, "arrowDown.png", "hideScene");
  GameObject hideInsideCabinet = new GameObject("hideInsideCabinet", 75, 310, 330, 100, "hideCabinet.png");
  MoveToSceneObject moveToHideScene2 = new MoveToSceneObject("scene03_Hide_Closet.png", 30, height/2 - 195, 30, 45, "arrowLeft.png", "hideSceneCabinet1");
  GameObject hideBehindPillar = new GameObject("hideBehindPillar", 1440, 200, 330, 100, "hidePillar.png");
  MoveToSceneObject moveToHideScene3 = new MoveToSceneObject("scene03_Hide_Pillar.png", 1775, 230, 30, 45, "arrowRight.png", "hideScenePillar1");
  scene03.addGameObject(needToHide);
  scene03.addGameObject(hideBehindBarrels);
  scene03.addGameObject(moveToHideScene);
  scene03.addGameObject(hideInsideCabinet);
  scene03.addGameObject(moveToHideScene2);
  scene03.addGameObject(hideBehindPillar);
  scene03.addGameObject(moveToHideScene3);

  Scene hideScene = new Scene("hideScene", "scene03_Hide_Barrels.png");
  GameObject distractMonster = new GameObject("distractMonster", width/2 - 600, 100, 550, 120, "distractMonster.png");
  MoveToSceneObject moveToScene03_2 = new MoveToSceneObject("goToScene03_2_scene03", width/2 - 100, height * 5/6, 70, 50, "arrowUp.png", "scene03_2", whooshSound);
  RequireObject stoneTarget = new RequireObject("requiresStone_hideScene", 1090, 50, 250, 250, "", "", stone, moveToScene03_2, true, metalHitSound, "");
  hideScene.addGameObject(distractMonster);
  hideScene.addGameObject(stoneTarget);

  Scene hideSceneCabinet1 = new Scene("hideSceneCabinet1", "hideSceneCabinet1.png", false);
  Scene hideSceneCabinet2 = new Scene("hideSceneCabinet2", "hideSceneCabinet1.png", false);
  GameObject cabinetMonster = new GameObject("cabinetMonster", -127, 0, width + 125, height, "cabinetMonster.png");
  hideSceneCabinet2.addGameObject(cabinetMonster);

  Scene hideScenePillar1 = new Scene("hideScenePillar1", "hideScenePillar1.png", false);

  Scene hideScenePillar2 = new Scene("hideScenePillar2", "hideScenePillar1.png", false);
  GameObject pillarMonster1 = new GameObject("cabinetMonster", 0, 0, width, height, "pillarMonster1.png");
  hideScenePillar2.addGameObject(pillarMonster1);

  Scene hideScenePillar3 = new Scene("hideScenePillar3", "hideScenePillar1.png", false);
  GameObject pillarMonster2= new GameObject("cabinetMonster", 0, 0, width, height, "pillarMonster2.png");
  hideScenePillar3.addGameObject(pillarMonster2);


  Scene scene03_2 = new Scene("scene03_2", "scene03_2.png");
  MoveToSceneObject moveToScene04 = new MoveToSceneObject("goToScene04_scene03", width/2 - 100, height * 2/6, 70, 50, "arrowUp.png", "scene04", whooshSound);
  scene03_2.addGameObject(moveToScene04);

  Scene scene04 = new Scene("scene04", "scene04.png");
  MoveToSceneObject goBackScene03 = new MoveToSceneObject("goBack_scene03", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene05 = new MoveToSceneObject("goToScene05_scene04", width/2 - 100, 550, 45, 30, "arrowUp.png", "scene05", whooshSound);
  scene04.addGameObject(goBackScene03);
  scene04.addGameObject(moveToScene05);

  Scene scene05 = new Scene("scene05", "scene05_Doors_Closed.png");
  MoveToSceneObject goBackScene04 = new MoveToSceneObject("goBack_scene04", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  RequireObject inspectDoor1 = new RequireObject("inspectDoor1", 620, 590, 50, 50, "", "", "lockedDoor.png", (Collectable)null, null);
  MoveToSceneObject moveToScene06 = new MoveToSceneObject("goToScene06_scene05", 800, 350, 200, 500, "", "scene06", whooshSound);
  MosaicPuzzle mosaic = new MosaicPuzzle("mosaic", 600, 200, 600, 600, "mosaic_white.png");
  RequireObject inspectDoor2 = new RequireObject("inspectDoor2", width/3 + 285, 605, 50, 50, "", "", "lockedDoor.png", mosaic, moveToScene06, null, "scene05_Doors_Middel_Open.png");
  CloseUpObject mosaicObject = new CloseUpObject("mosaicObject", 835, 450, 90, 110, "", mosaic);
  Collectable crystal = new Collectable("crystal", "crystal.png");
  MoveToSceneObject moveToLibrary01 = new MoveToSceneObject("goToLibrary01_scene05", width * 4/6 - 60, 280, 200, 700, "", "library01", whooshSound);
  RequireObject inspectDoor3 = new RequireObject("inspectDoor3", width * 4/6 - 80, 495, 300, 300, "", "", "lockedDoor.png", crystal, moveToLibrary01, true, beatenPuzzleSound, "scene05_Doors_Both_Open.png");
  scene05.addGameObject(goBackScene04);
  scene05.addGameObject(inspectDoor1);
  scene05.addGameObject(inspectDoor2);
  scene05.addGameObject(mosaicObject);
  scene05.addGameObject(inspectDoor3);

  Scene scene06 = new Scene("scene06", "scene06.png");
  CloseUpCollectable scroll = new CloseUpCollectable("scroll", "map_icon.png", "map.png");
  CollectableObject colScroll = new CollectableObject("scroll_scene06", 673, 516, 81, 39, "scroll.png", scroll);
  CollectableObject colCrystal = new CollectableObject("crystal_scene06", 845, 450, 70, 90, "", crystal, "scene06_1.png");
  MoveToSceneObject goBackScene05 = new MoveToSceneObject("goBack_scene05", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  scene06.addGameObject(colScroll);
  scene06.addGameObject(colCrystal);
  scene06.addGameObject(goBackScene05);

  Scene library01 = new Scene("library01", "library01.png");
  MoveToSceneObject goBackLibrary01= new MoveToSceneObject("goBack_library01", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene07 = new MoveToSceneObject("goToScene07_library01", 700, 600, 45, 30, "arrowUp.png", "scene07", whooshSound);
  library01.addGameObject(goBackLibrary01);
  library01.addGameObject(moveToScene07);

  Scene scene07 = new Scene("scene07", "scene07.png");
  MoveToSceneObject goBackScene06 = new MoveToSceneObject("goBack_scene06", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  MoveToSceneObject moveToScene08 = new MoveToSceneObject("goToScene08_scene07", 900, 400, 45, 30, "arrowUp.png", "scene08", whooshSound);
  BookPuzzle bookPuzzle = new BookPuzzle("mosaic", 600, 250, 500, 500, "");
  CloseUpObject bookPuzzleObject = new CloseUpObject("bookPuzzleObject", 775, 440, 200, 120, "", bookPuzzle);
  RequireObject changeLibraryImage = new RequireObject("changeLibraryImage", width/3 + 285, 605, 50, 50, "", "", bookPuzzle, moveToScene08, null, "library02.png");
  scene07.addGameObject(goBackScene06);
  scene07.addGameObject(bookPuzzleObject);
  scene07.addGameObject(changeLibraryImage);

  Scene scene08 = new Scene("scene08", "scene08.png");
  MoveToSceneObject moveToVictoryScene = new MoveToSceneObject("goToVictoryScene_scene08", 607, 167, 439 - 40, 488, "openPortal.png", "victoryScene", victorySound);
  MoveToSceneObject goBackScene07 = new MoveToSceneObject("goBack_scene07", width/2 - 100, height * 5/6, 70, 50, "arrowDown.png", true);
  sequencePuzzle = new SequencePuzzle("sequencePuzzle", 0, 100, width-inventoryWidth, height - 100, "sequencePuzzle.png");
  CloseUpObject sequencePuzzleObject = new CloseUpObject("bookPuzzleObject", 1350, 570, 200, 100, "", sequencePuzzle, moveToVictoryScene);
  RequireObject inspectPortal = new RequireObject("inspectPortal", width/2 - 300, 200, 300, 400, "", "The portal isn't working", sequencePuzzle, moveToVictoryScene, null);
  scene08.addGameObject(goBackScene07);
  scene08.addGameObject(inspectPortal);
  scene08.addGameObject(sequencePuzzleObject);

  Scene victoryScene = new Scene("victoryScene", "victoryScene.png", false);
  RestartObject restartButton1 = new RestartObject("restartButton", width/2 - (505/2), 800, 505, 147, "restartButton.png");
  victoryScene.addGameObject(restartButton1);

  Scene gameOverScene = new Scene("gameOverScene", "jumpscare.png", false);
  RestartObject restartButton2 = new RestartObject("restartButton", width/2 - 505/2 - 20, 800, 505, 147, "restartButton.png");
  gameOverScene.addGameObject(restartButton2);

  sceneManager.addScene(startMenu);
  sceneManager.addScene(openingTextScene);
  sceneManager.addScene(scene01);
  sceneManager.addScene(scene02);
  sceneManager.addScene(scene03);
  sceneManager.addScene(hideScene);
  sceneManager.addScene(scene03_2);
  sceneManager.addScene(scene04);
  sceneManager.addScene(scene05);
  sceneManager.addScene(scene06);
  sceneManager.addScene(library01);
  sceneManager.addScene(scene07);
  sceneManager.addScene(scene08);
  sceneManager.addScene(victoryScene);
  sceneManager.addScene(gameOverScene);
  sceneManager.addScene(hideSceneCabinet1);
  sceneManager.addScene(hideSceneCabinet2);
  sceneManager.addScene(hideScenePillar1);
  sceneManager.addScene(hideScenePillar2);
  sceneManager.addScene(hideScenePillar3);
}

void restart() {
  sceneManager = new SceneManager();
  inventoryManager = new InventoryManager();
  loadScenes();
}

void draw()
{
  //println(footstepsVolume);
  sceneManager.getCurrentScene().draw();
  sceneManager.getCurrentScene().updateScene();
  inventoryManager.clearMarkedForDeathCollectables();

  monsterApproachingSound.amp(footstepsVolume);
  monsterApproachingSound.rate(footstepsRate);

  //Gradually increase the volume of footsteps
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
    volumeIncrease = 0.001;
    footstepsRateIncrease = 0.005;
    volumeIncreaseMultiplier+=0.008;
  }

  //When the monster gets close enough play a whistling sound
  if (footstepsVolume >= whistlingStart && !isMonsterClose) {
    monsterCloseIndicatorSound.play();
    isMonsterClose = true;
  }
  
  //If the volue is loud enough the monster catches the player
  //Distance between monster and player is "measured" by the volume of footstepsSound
  if (footstepsVolume >= 0.40) {
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

  //Changing of scenes for death in cabinet
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
      }
    }
  }

  if (sceneManager.getCurrentScene().sceneName == "hideSceneCabinet2") {
    if (!startTimer) {
      startTimer();
      isGameOver = true;
    } else {
      if (lastTime>= timer + 1400) {
        try {
          sceneManager.goToScene("gameOverScene");
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
  
  //Changing of scenes for death behind pillar
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
      }
    }
  }

  if (sceneManager.getCurrentScene().sceneName == "hideScenePillar2") {
    if (!startTimer) {
      startTimer();
      isGameOver = true;
    } else {
      if (lastTime>= timer + 1200) {
        try {
          sceneManager.goToScene("hideScenePillar3");
        }
        catch(Exception e) {
          println(e);
        }
        footstepsVolume = 0;
      }
    }
  }

  if (sceneManager.getCurrentScene().sceneName == "hideScenePillar3") {
    if (!startTimer) {
      startTimer();
      isGameOver = true;
    } else {
      if (lastTime>= timer + 2400) {
        try {
          sceneManager.goToScene("gameOverScene");
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
