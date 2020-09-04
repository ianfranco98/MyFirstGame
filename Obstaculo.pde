class Obstaculo {
  int posX, posY, velX, velY, tam, espacioInicio, aniFrame, aniFrameDestruido, temporizadorFrame, tamDestruido, tipoAsteroide;
  int [] posicionesPosiblesY;
  int [] posicionesPosiblesX;
  boolean hayColision, velAumentada, esDestruido;
  PImage [] ani_asteroide;
  PImage [] ani_asteroide1;
  PImage [] ani_asteroide2;
  PImage [] ani_asteroideDestruido;

  Obstaculo (int _velX, int _espacioInicio) {
    ani_asteroide = new PImage [21];
    ani_asteroide1 = new PImage [24];
    ani_asteroide2 = new PImage [23];
    ani_asteroideDestruido = new PImage [6];
    posicionesPosiblesX = new int [10];
    posicionesPosiblesY = new int [10];
    espacioInicio = _espacioInicio;
    for (int i=0; i < posicionesPosiblesX.length; i++) {
      posicionesPosiblesX[i] = i * ((width-200)/10);
    }
    for (int i=0; i < posicionesPosiblesY.length; i++) {
      posicionesPosiblesY[i] = i * (height/10);
    }
    for (int i=0; i<ani_asteroide.length; i++) {
      ani_asteroide[i] = loadImage ("asteroides/asteroide1"+nf(i, 2)+".png");
    }
    for (int i=0; i<ani_asteroide1.length; i++) {
      ani_asteroide1[i] = loadImage ("asteroides/asteroide3"+nf(i, 2)+".png");
    }
    for (int i=0; i<ani_asteroide2.length; i++) {
      ani_asteroide2[i] = loadImage ("asteroides/asteroide4"+nf(i, 2)+".png");
    }
    for (int i=0; i<ani_asteroideDestruido.length; i++) {
      ani_asteroideDestruido[i] = loadImage ("asteroides/asteroideDes"+i+".png");
    }
    posX = espacioInicio + width + posicionesPosiblesX[round(random(posicionesPosiblesX.length-1))];
    posY = posicionesPosiblesY[round(random(posicionesPosiblesY.length-1))];
    velX = _velX;
    velY = 0;
    tam = 45;
    tamDestruido = tam*2+15;
    aniFrame = round (random (ani_asteroide.length));
    aniFrameDestruido = 0;
    temporizadorFrame = 0;
    velAumentada = false;
    esDestruido = false;
    tipoAsteroide = round(random(0.5, 3.1));
  }

  void dibujar () {
    if (!esDestruido) {
      if ((millis() - temporizadorFrame) > 150) {
        aniFrame ++;
        aniFrame %= ani_asteroide.length;
        temporizadorFrame = millis();
      }
      switch (tipoAsteroide) {
      case 1 : image (ani_asteroide[aniFrame], posX, posY, tam, tam);
        break;
      case 2 : image (ani_asteroide1[aniFrame], posX, posY, tam+10, tam+10);
        break;
      case 3 : image (ani_asteroide2[aniFrame], posX, posY, tam+10, tam+10);
        break;
      }
    } else {
      if (aniFrameDestruido < ani_asteroideDestruido.length-1) {
        if ((millis() - temporizadorFrame) > 130) {
          aniFrameDestruido ++;
          temporizadorFrame = millis();
        }
        image (ani_asteroideDestruido[aniFrameDestruido], posX-15, posY-18, tamDestruido, tamDestruido);
      }
    }
  }

  void desplazar () {
    posX -= velX;
    posY -= velY;
  }

  void relanzar () {
    if (posX < -50) {
      tipoAsteroide = round(random(0.6, 3.4));
      aniFrameDestruido = 0;
      esDestruido = false;
      posX = width + posicionesPosiblesX[round(random(posicionesPosiblesX.length-1))];
      posY = posicionesPosiblesY[round(random(posicionesPosiblesY.length-1))];
      if (velAumentada) {
        velX = round(random(7, 9));
      } else {
        velX = round(random(4, 8));
      }
      if (posY < 2 * (height/10) && posX < width + 50) {
        velY = round(random(1));
      } else if (posY > 8 * (height/10) && posX < width + 50) {
        velY = round (random(-1));
      }
    }
  }

  void reiniciar () {
    velAumentada =  false;
    aniFrameDestruido = 0;
    tipoAsteroide = round(random(0.6, 3.4));
    esDestruido = false;
    posX = espacioInicio + width + posicionesPosiblesX[round(random(posicionesPosiblesX.length-1))];
    posY = posicionesPosiblesY[round(random(posicionesPosiblesY.length-1))];
    if (velAumentada) {
      velX = round(random(7, 12));
    } else {
      velX = round(random(4, 8));
    }
    velY= 0;
  }

  void aumentarVel () {
    velX = round(random(7, 10));
    velAumentada = true;
  }
}