PImage bg, soil, cabbage, life, soldier;//背景、土、菜菜、生命、士兵
PImage gameover, title;//遊戲結束、遊戲封面
PImage groundhogDown, groundhogIdle, groundhogLeft, groundhogRight;//土撥鼠前下左右
PImage restartHovered, restartNormal, startHovered, startNormal;//遊戲開始與重新開始按鈕
//三個case
final int GAME_START = 0;
final int GAME_RUN = 1;
final int GAME_LOSE = 2;
int gameState = GAME_START;
//每格大小
int gridSize = 80;
int ghX, ghY;
//初始生命值
int ghLife = 2;
//捲心菜的位置
int cabbageX = gridSize*floor(random(0, 8));
int cabbageY = gridSize*floor(random(2, 6));
//士兵xy定位
float soldierX;
int soldierY;
//移動相關設定
final int BUTTON_TOP = 210;
final int BUTTON_BOTTOM = 280;
final int BUTTON_LEFT = 115;
final int BUTTON_RIGHT = 450;


//土撥鼠移動速度
float ghSpeed = 80.0;
//記數
int myCount = 0;
//出現吧 土撥鼠
int ghgood =1;
final int down = 2;
final int right = 3;
final int left = 4; 
final int idle = 5;
//計時
int time;

void setup() {

  size(640, 480, P2D);
  //圖片資料加載
  bg = loadImage("img/bg.jpg");
  soil = loadImage("img/soil.png");
  cabbage = loadImage("img/cabbage.png");
  life = loadImage("img/life.png");
  soldier = loadImage("img/soldier.png");
  gameover = loadImage("img/gameover.jpg");
  title = loadImage("img/title.jpg");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png");
  restartHovered = loadImage("img/restartHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  startHovered = loadImage("img/startHovered.png");
  startNormal = loadImage("img/startNormal.png");
  //土撥鼠xy
  ghX = 4*gridSize;
  ghY = 1*gridSize;
  //士兵xy
  soldierX = 0;
  soldierY = gridSize*floor(random(3, 6));
  ghgood = idle;
}

void draw() {

  switch(gameState) {
  case GAME_START:

    image(title, 0, 0);
    image(startNormal, 248, 360, 144, 60);
    //按鈕判定
    if (mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420) {
      image(startHovered, 248, 360, 144, 60);
      if (mousePressed) {
        gameState = GAME_RUN;
      }
    }
    //土撥鼠xy
    ghX = 4*gridSize;
    ghY = 1*gridSize;
    break;

  case GAME_RUN:
    //天空與土地
    image(bg, 0, 0);
    image(soil, 0, gridSize*2);
    //太陽
    fill(253, 184, 19);
    stroke(255, 255, 0);
    strokeWeight(5);
    ellipse(width-50, 50, 120, 120);
    //草地
    noStroke();
    fill(124, 204, 25);
    rect(0, 145, width, 15);
    //生命值
    if (ghLife == 3) {
      image(life, 10, 10);
      image(life, 80, 10);
      image(life, 150, 10);
    } else if (ghLife ==2) {
      image(life, 10, 10);
      image(life, 80, 10);
    } else if (ghLife ==1) {      
      image(life, 10, 10);
    } else if (ghLife ==0) {      
      gameState = GAME_LOSE;
    }
    image(cabbage, cabbageX, cabbageY, 80, 80);

    //吃菜判定
    if (ghX+80 > cabbageX && ghX < cabbageX+80 && ghY+80 > cabbageY && ghY < cabbageY+80) {
      ghLife += 1;
      cabbageY = -80;
    }
    //士兵
    image(soldier, soldierX, soldierY);
    soldierX += 2;
    if (soldierX>width) {
      soldierX=-80;
    }
    //士兵碰撞判定
    if (ghX+80 > soldierX && ghX < soldierX+80 && ghY+80 > soldierY && ghY < soldierY+80) {
      ghLife -=1;
      ghX = 4*gridSize;
      ghY = 1*gridSize;
      time = 15;
    }
    //keyPressed控制ghstate

    if (time < 15) {
      switch (ghgood) {
      case down:
        time++;
        image(groundhogDown, ghX, ghY, 80, 80);
        ghY += ghSpeed/15.0+1;
        if (time ==15) {
          ghgood = idle;
        }
        break;
      case right:
        time++;
        image(groundhogRight, ghX, ghY, 80, 80);
        ghX += ghSpeed/15.0+1;
        if (time ==15) {
          ghgood = idle;
        }
        break;
      case left:
        time++;
        image(groundhogLeft, ghX, ghY, 80, 80);
        ghX -= ghSpeed/15.0+1;
        if (time ==15) {
          ghgood = idle;
        }
        break;
      case idle:
        image(groundhogIdle, ghX, ghY, 80, 80);
        break;
      }
    } else { 
      image(groundhogIdle, ghX, ghY, 80, 80);
    }
    if (time ==15) {
      ghX = round(ghX/80.0)*80;
      ghY = round(ghY/80.0)*80;
    }
    //讓土撥鼠不要超出邊界的設定
    if (ghX > width-80) {
      ghX = width-80;
    }
    if (ghX < 0) {
      ghX = 0;
    }
    if (ghY < 80) {
      ghY = 80;
    }
    if (ghY > height-80) {
      ghY = height-80;
    }
    break;

  case GAME_LOSE:
    image(gameover, 0, 0);
    image(restartNormal, 248, 360, 144, 60);
    //按鈕判定
    if (mouseX>248 && mouseX<392 && mouseY>360 && mouseY<420) {
      image(restartHovered, 248, 360, 144, 60);
      if (mousePressed) {
        gameState = GAME_RUN;
        ghLife = 2 ;
        ghX = 4*gridSize;
        ghY = 1*gridSize;
        soldierX = 0;
        soldierY = gridSize*floor(random(3, 6));
        cabbageX = gridSize*floor(random(0, 8));
        cabbageY = gridSize*floor(random(2, 6));
      }
    }
    break;
  }
}

void keyPressed () {
  if (key == CODED) {
    switch(keyCode) {
    case DOWN :
      time = 0;
      ghgood = down;
      break;

    case LEFT:
      time = 0;
      ghgood = left;
      break;

    case RIGHT:
      time = 0;
      ghgood = right;
      break;
    }
  }
}
