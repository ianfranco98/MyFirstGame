class BarraProgreso {
  int posX, posY, tamX, tamY, tamMedidor; 
  float distanciaRecorrida;
  boolean llego;

  BarraProgreso() {
    posX = width/3;
    posY = height/12;
    tamX = width - 300;
    tamY = 20;
    distanciaRecorrida = 0;
    llego = false;
  }

  void dibujar() {
    if (!llego) {
      fill(100, 100);
      rect(posX, posY, tamX, tamY);
      fill(0, 0, 255, 80);
      ellipse(posX+distanciaRecorrida, posY+2, tamY-5, tamY-5);
      stroke(255, 0, 0);
      strokeWeight(4);
      line(posX+tamX-50, posY, posX+tamX-50, posY+tamY);
      noStroke();
      distanciaRecorrida += .2;
      if (distanciaRecorrida >= tamX-tamY) {
        distanciaRecorrida=0;
        llego = true;
      }
    }
  }

  void continuar() {
    distanciaRecorrida=0;
    llego = false;
  }

  void reiniciar() {
    distanciaRecorrida=0;
    llego = false;
  }
}