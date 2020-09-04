class BarraPoder {
  int posX, posY, tamX, tamY, tamAuraX, tamAuraY, tamMedidor, restablecerMedidor, velVaciado, temporizadorFrame, aniFrame;
  float auraPX, auraPY, temporizadorLlenado;
  boolean medidorLleno, vaciar;
  PImage[] ani_inicio, ani_completo, ani_fin;

  BarraPoder () {
    ani_inicio = new PImage [4];
    for (int i=0; i<ani_inicio.length; i++) {
      ani_inicio[i] = loadImage ("heroeAuraInicio"+i+".png");
    }
    ani_completo = new PImage [4];
    for (int i=0; i<ani_completo.length; i++) {
      ani_completo[i] = loadImage ("heroeAuraPleno"+i+".png");
    }
    ani_fin = new PImage [4];
    for (int i=0; i<ani_fin.length; i++) {
      ani_fin[i] = loadImage ("heroeAuraFinal"+i+".png");
    }
    temporizadorFrame = 0;
    aniFrame = 0;
    posX = width/12;
    posY = height/12;
    auraPX = width/2;
    auraPY = height/2;
    tamX = 150;
    tamY = 20;
    tamAuraX = 150;
    tamAuraY = 100;
    tamMedidor = 0;
    medidorLleno = false;
    restablecerMedidor = 1;
    vaciar = false;
    velVaciado = 1;
  }

  void dibujar () {
    fill (75, 255, 75, 100);
    if (tamMedidor >= tamX) medidorLleno = true;
    if (vaciar) vaciar();
    if (!medidorLleno && !vaciar) {
      fill (255, 50, 50, 100);
      if ((millis() - temporizadorLlenado) > 1) {
        tamMedidor += restablecerMedidor;
        temporizadorLlenado = millis();
      }
    }
    rect (posX, posY, tamMedidor, tamY);
    noFill();
    stroke (255);
    strokeWeight (4);
    rect (posX, posY, tamX, tamY);
  }

  void vaciar () {
    fill (255, 50, 50, 100);
    if (tamMedidor > 0) {
      tamMedidor -= velVaciado;
    } else {
      medidorLleno = false;
      vaciar = false;
    }
  }

  void activarVaciado () {
    if (tamMedidor == tamX) vaciar = true;
  }

  void reiniciar () {
    tamMedidor = 0;
    medidorLleno = false;
    vaciar = false;
  }

  void aura(float _posX, float _posY) {
    auraPX = _posX-40;
    auraPY = _posY-30;
    if ((millis() - temporizadorFrame) > 150) {
      aniFrame ++;
      if (aniFrame > 3) aniFrame = 0;
      noStroke();
      if (tamMedidor < 10) { 
        image(ani_inicio[aniFrame], auraPX, auraPY, tamAuraX, tamAuraY);
      } else if (tamMedidor < 140 && tamMedidor > 10) {
        image(ani_completo[aniFrame], auraPX, auraPY, tamAuraX, tamAuraY);
      } else if (tamMedidor > 140) {
        image(ani_fin[aniFrame], auraPX, auraPY, tamAuraX, tamAuraY);
      }
    }
  }
}