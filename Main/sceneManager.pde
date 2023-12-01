import java.util.Stack;
import java.util.HashMap;

class SceneManager {
  private HashMap<String, Scene> scenes;
  private Stack<Scene> scenesStack;

  public SceneManager() {
    scenes = new HashMap<String, Scene>();
    scenesStack = new Stack<Scene>();
  }

  public void addScene(Scene scene) {
    scenes.put(scene.getSceneName(), scene);
    if (scenesStack.size() == 0)
    {
      scenesStack.push(scene);
    }
  }

  public void goToScene(String sceneName) throws Exception {
    if (scenes.containsKey(sceneName)) {
      scenesStack.push(scenes.get(sceneName));
      if (sceneManager.getScene(sceneName).sceneName == "scene03") {
        footstepsVolume-=0.02;
      }
      if (sceneManager.getScene(sceneName).sceneName == "hideScene") {
        volumeIncrease = 0;
        volumeIncreaseMultiplier = 1;
        footstepsVolume = 0.1;
        footstepsRate = 1.5;
        footstepsRateIncrease = 0;
        chaseStarted = false;
        monsterCloseIndicatorSound.stop();
      }
      if (sceneManager.getScene(sceneName).sceneName == "scene03_2") {
        footstepsVolume = 0;
        whistlingStart = 0.35;
        volumeIncrease = 0.00024;
        footstepsRateIncrease = 0.0005;
      }
    } else {
      throw new Exception("Scene not found with name: "+ sceneName + "." +
        "Make sure it was added to the sceneManager.");
    }
  }

  public Scene getScene(String sceneName) throws Exception {
    if (scenes.containsKey(sceneName)) {
      return scenes.get(sceneName);
    } else {
      throw new Exception("Scene not found with name: "+ sceneName + "." +
        "Make sure it was added to the sceneManager.");
    }
  }

  public void goToPreviousScene() {
    scenesStack.pop();
  }

  public Scene getCurrentScene() {
    return scenesStack.peek();
  }
}
