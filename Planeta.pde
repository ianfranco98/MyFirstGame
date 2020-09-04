class Planeta {
  int posX, posY, aniFrame, temporizadorFrame;
  float tamX, tamY;
  boolean posicionado;
  PImage[] planeta;

  Planeta() {
    planeta = new PImage [216];
    for (int e=0; e<planeta.length; e++) {
      planeta[e] = loadImage ("planeta/planeta"+e+".png");
    }
    posX = width;
    posY = 50;
    tamX = 200;
    tamY = 120;
    aniFrame = 0;
    temporizadorFrame = 0;
    posicionado = false;
  }

  void dibujar() {
    if ((millis() - temporizadorFrame) > 90) {
      aniFrame ++;
      if (aniFrame > 215) aniFrame = 0;
      temporizadorFrame = millis();
    }
    image(planeta[aniFrame], posX, posY, tamX, tamY);
    if (posX > width/2) {
      posX--;
      tamX+=.5;
      tamY+=.5;
    } else {
      posicionado = true;
    }
  }

  void reiniciar() {
    posicionado = false;
    posX = width;
    posY = 50;
    tamX = 200;
    tamY = 120;
    aniFrame = 0;
    temporizadorFrame = 0;
  }
}