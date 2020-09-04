class Boton {
  int posX, posY;
  int ladoIzquierdo, ladoDerecho, ladoSuperior, ladoInferior;
  int destello;
  boolean sePresiono;
  String texto;
  String cambiarEscena;

  Boton (String _texto, String _cambiarEscena, int _posX, int _posY) {
    posX = _posX;
    posY = _posY;
    texto = _texto;
    cambiarEscena = _cambiarEscena;
    ladoIzquierdo = _posX - 100;
    ladoDerecho = _posX + 100;
    ladoSuperior = _posY - 20;
    ladoInferior = _posY + 10;
    destello = 0;
  }

  void dibujar () {
    destello();
    text (texto, posX, posY);
  }



  boolean presionado () {
    if (mousePressed && mouseX < ladoDerecho && mouseX > ladoIzquierdo && mouseY < ladoInferior && mouseY > ladoSuperior) {
      sePresiono = true;
    } else {
      sePresiono = false;
    }
    return sePresiono;
  }

  String cambiarEstado () {
    return cambiarEscena;
  }

  void destello () {
    int x = 1;
    if (mouseX < ladoDerecho && mouseX > ladoIzquierdo && mouseY < ladoInferior && mouseY > ladoSuperior) {
      if (destello % 255 == 0) x *= -1;
      destello += x;
      fill (destello);
    } else {
      fill (255);
    }
  }
}