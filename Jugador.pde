class Superheroe {
  int   velX, velY, tamColision, aniFrame, aniFrame1, aniFrame2, aniFrame3, temporizadorFrame, inicio, fin;
  float posX, posY, antPosY, tamX, tamY;
  boolean colision, invencible, eNormal, eMov, perdio, estado;
  boolean [] teclaPresionada;
  PImage[] ani_quieto, ani_mov, ani_movB, ani_aura;
  PImage personajePerdio;

  Superheroe () {
    ani_quieto = new PImage [15];
    for (int i=0; i<ani_quieto.length; i++) {
      ani_quieto[i] = loadImage ("heroe/heroe"+i+".png");
    }

    ani_mov = new PImage [40];
    for (int b=0; b<ani_mov.length; b++) {
      ani_mov[b] = loadImage ("heroe/heroeMov"+b+".png");
    }

    ani_movB = new PImage [21];
    for (int c=0; c<ani_movB.length; c++) {
      ani_movB[c] = loadImage ("heroe/heroemovh"+c+".png");
    }

    ani_aura = new PImage [28];
    for (int d=0; d<ani_aura.length; d++) {
      ani_aura[d] = loadImage ("heroeauracompleto"+d+".png");
    }

    teclaPresionada = new boolean[4];
    personajePerdio = new PImage();
    personajePerdio = loadImage("heroe/heroePerdio.png");
    posX = width/10;
    posY = height/2;
    antPosY = posY;
    velX = 3;
    velY = 3;
    tamX = 80;
    tamY = 41;
    tamColision = 34;
    aniFrame = 0;
    aniFrame1 = 0;
    aniFrame2 = 0;
    aniFrame3 = 0;
    temporizadorFrame = 0;
    inicio = 0;              //delimitan la animacion de movimiento debido a que
    fin = 4;                 //todas las imagenes estan enumeradas juntas.
    invencible = false;
    colision = false;
    eNormal = true;
    eMov = false;
    perdio = false;
  }

  void dibujar () {
    image(ani_quieto[aniFrame], posX, posY, tamX, tamY);
    if ((millis() - temporizadorFrame) > 50) {
      aniFrame ++;
      if (aniFrame > fin) aniFrame = inicio;
      temporizadorFrame = millis();
    } 
    if ( antPosY > posY && !eMov) vueloArriba();
    if ( antPosY < posY && !eMov) vueloAbajo();
    if ( antPosY == posY && !eNormal) vueloNormal();
    antPosY = posY;       //guarda el valor del frame anterior a posY
  }

  void vueloArriba() {
    aniFrame = 5;
    inicio = aniFrame;
    fin = 9;
    eMov = !eMov;
    eNormal = false;
  }

  void vueloAbajo() {
    aniFrame = 10;
    inicio = aniFrame;
    fin = 14;
    eMov = !eMov;
    eNormal = false;
  }

  void vueloNormal() {
    aniFrame = 0;
    inicio = aniFrame;
    fin = 4;
    eMov = false;
    eNormal = true;
  }

  void actualizar () {
    invencible = false;
    tamColision = 34;
  }

  void controlarMovimiento () {
    if (posX < width-tamX && posX > 0 && posY < height && posY > 0) {
      if (teclaPresionada[0]) posY -= velY;
      if (teclaPresionada[1]) posY += velY;
      if (teclaPresionada[2]) posX -= velX + 2;
      if (teclaPresionada[3]) posX += velX;
    }
    if (posX >= width -tamX) {
      posX = width-2;
    }
    if (posX <= 0) {
      posX = 0+2;
    }
    if (posY >= height -tamY) {
      posY = height-tamY;
    }
    if (posY <= 0) {
      posY = 0 +2;
    }
  }

  void keyPressed () {
    if (key == 'w' || key == 'W') teclaPresionada[0] = true;
    if (key == 's' || key == 'S') teclaPresionada[1] = true;
    if (key == 'a' || key == 'A') teclaPresionada[2] = true;
    if (key == 'd' || key == 'D') teclaPresionada[3] = true;
  }

  void keyReleased () {
    if (key == 'w' || key == 'W') teclaPresionada[0] = false;
    if (key == 's' || key == 'S') teclaPresionada[1] = false;
    if (key == 'a' || key == 'A') teclaPresionada[2] = false;
    if (key == 'd' || key == 'D') teclaPresionada[3] = false;
  }

  void detenerMovimiento () {
    if (!perdio) {
      image(personajePerdio, posX, posY, tamX, tamY);
    }
    posX -= 3;
    velX = 0;
    velY = 0;
  }

  void detenerMovimientoLlegada () {
    posX -= 3;
    velX = 0;
    velY = 0;
  }

  boolean chequearColision(int x, int y) {
    if (dist (posX, posY, x, y) < tamColision) {
      colision = true;
    } else {
      colision = false;
    }
    return(colision);
  }

  void reiniciar() {
    posX = width/10;
    posY = height/2;
    velX = 3;
    velY = 3;
    colision = false;
    perdio = false;
    tamX = 80;
    tamY = 41;
  }

  void activarInvencibilidad () {
    invencible = true;
    tamColision = 60;
  }

  void movimiento() {
    if ((millis() - temporizadorFrame) > 100) {
      aniFrame ++;
      aniFrame1 ++;
      aniFrame2 ++;
      aniFrame3 ++;
      if (aniFrame > 4) aniFrame = 0;
      if (aniFrame1 > 39) aniFrame1 = 0;
      if (aniFrame2 > 20) aniFrame2 = 0;
      if (aniFrame3 > 27) aniFrame3 = 0;
      temporizadorFrame = millis();
    }
    image(ani_mov[aniFrame1], width/3-100, height/4-80, tamX-20, tamY*7);
    image(ani_movB[aniFrame2], width/2+50, height/4+15, tamX*3-50, tamY-10);
    image(ani_aura[aniFrame3], width/2+100, height/2+50, 100, 60);
    image(ani_quieto[aniFrame], width/2+125, height/2+65, tamX-20, tamY-10);
  }

  void Gano() {
    image(ani_quieto[aniFrame], posX, posY, tamX, tamY);
    if ((millis() - temporizadorFrame) > 50) {
      aniFrame ++;
      if (aniFrame > fin) aniFrame = inicio;
      temporizadorFrame = millis();
    }
    if (posX < width/2+250) {
      posX++;
    }
    if (posY < height/2) {
      posY++;
    } else if (posY > height/2) {
      posY--;
    }
    if (tamY > 0 && posX > width/2) {
      tamX-=.4;
      tamY-=.2;
    }
  }
}