class Estrellas {
  float posX, posY, tam, vel;

  Estrellas (int _tam) {
    posX = int(random(0, width));
    posY = int(random(0, height));
    vel = 5;
    tam = _tam;
  }

  void dibujar () {
    if (posX < 0) posX = int(random(0, width))+width;
    posX -= vel;
    stroke(255);
    strokeWeight (tam);
    rect(posX, posY, 1, 1);
    strokeWeight (1);
    noStroke ();
  }

  void cambiarVel (float vel1, float vel2, float vel3) {
    if (keyPressed) { 
      if (key == 'a' || key == 'A') vel = vel1;
      if (key == 'd' || key == 'D') vel = vel2;
    } else {
      vel = vel3;
    }
  }

  void reiniciar () {
    posX = int(random(0, width));
    posY = int(random(0, height));
    vel = 5;
  }
}