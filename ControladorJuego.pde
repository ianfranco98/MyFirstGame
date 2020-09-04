class Juego {

  Superheroe jugador;
  BarraPoder barra;
  BarraProgreso barraProgresoJugador;
  Planeta miPlaneta;

  Obstaculo[] asteroide;
  Estrellas[] estrellasF;
  Estrellas[] estrellasF2;

  Boton botonJugar;
  Boton botonInstrucciones;
  Boton botonReiniciarJuego;
  Boton botonVolverAlMenu;
  Boton botonSiguienteNivel;

  String estadoJuego;
  String estadoAnterior;
  float contador, velFondo;

  Juego () {
    jugador = new Superheroe ();
    barra = new BarraPoder();
    barraProgresoJugador = new BarraProgreso();
    miPlaneta = new Planeta();

    asteroide = new Obstaculo [22];
    estrellasF = new Estrellas [75];
    estrellasF2 = new Estrellas [75];

    velFondo = 7;
    contador = .017;

    botonJugar = new Boton ("¡Jugar!", "Nivel 1", width/2, height - height/5);
    botonInstrucciones = new Boton ("Como se juega", "instrucciones", width/2, height - height/5 +30);
    botonReiniciarJuego = new Boton ("Reiniciar", "Nivel 1", width/2, height - height/4 - 30);
    botonVolverAlMenu = new Boton ("Volver al menú", "Pantalla Principal", width/2+180, (height - height/5+50));
    botonSiguienteNivel = new Boton ("Siguiente nivel", "Nivel 2", width/2, height/2);

    for (int i=0; i<asteroide.length; i++) {
      asteroide[i] = new Obstaculo ( round(random(4, 8)), 600);
    }
    for (int i=0; i <estrellasF.length; i++) {
      estrellasF[i] = new Estrellas (4);
    }
    for (int i=0; i <estrellasF2.length; i++) {
      estrellasF2[i] = new Estrellas (2);
    }
    estadoJuego = "Pantalla Principal";
  }

  void fondo () {
    background (0);
    fill(255);
    if (estadoJuego == "gano") {
      for (int a=0; a<estrellasF.length; a++) {
        estrellasF[a].dibujar();
        estrellasF2[a].dibujar();
        estrellasF[a].cambiarVel(velFondo, velFondo, velFondo);
        estrellasF2[a].cambiarVel(velFondo, velFondo, velFondo);
      }
    } else {
      for (int a=0; a<estrellasF.length; a++) {
        estrellasF[a].dibujar();
        estrellasF2[a].dibujar();
        estrellasF[a].cambiarVel(velFondo-1, velFondo+1, velFondo);
        estrellasF2[a].cambiarVel(velFondo-2, velFondo, velFondo-1);
      }
    }
  }

  void pantallaPrincipal () {
    fill (0, 0, 0, 175);
    rectMode (CENTER);
    rect (width/2, height/2, width - width/4, height-50);
    rectMode (CORNER);
    fill (255);
    botonJugar.dibujar();
    botonInstrucciones.dibujar();
    if (botonJugar.presionado()) {
      velFondo = 7;
      for (int a=0; a<estrellasF.length; a++) {
        estrellasF[a].reiniciar();
      }
      estadoJuego = botonJugar.cambiarEstado();
    }
    if (botonInstrucciones.presionado()) estadoJuego = botonInstrucciones.cambiarEstado();
  }

  void comoJugar () {
    fill (0, 0, 0, 175);
    rectMode (CENTER);
    rect (width/2, height/2, width - width/4, height-50);
    rectMode (CORNER);
    fill (255);
    text ("W -->  arriba ", width/3-50, height /4);
    text ("S -->  abajo ", width/3-50, height /2+40);
    jugador.movimiento();
    text ("A <-- izquierda ", width/2+150, height /4);
    text ("derecha --> D ", width/2+150, height /2-30);
    text ("ESPACIO <-- inmunidad", width/2+150, height /2+40);
    botonJugar.dibujar();
    botonVolverAlMenu.dibujar();
    if (botonJugar.presionado()) estadoJuego = botonJugar.cambiarEstado();
    if (botonVolverAlMenu.presionado()) estadoJuego = botonVolverAlMenu.cambiarEstado ();
  }


  void nivel1 () {
    noCursor();
    jugador.controlarMovimiento();
    if (jugador.invencible) {
      barra.aura(jugador.posX, jugador.posY);
    }
    jugador.dibujar();

    for (int i=0; i<asteroide.length-5; i++) {
      if (jugador.chequearColision(asteroide[i].posX, asteroide[i].posY) && !asteroide[i].esDestruido) {
        golpe.trigger();
        if (jugador.invencible) {
          asteroide[i].esDestruido = true;
        } else {
          estadoJuego = "Perdió";
        }
      }
      asteroide[i].dibujar();
      asteroide[i].desplazar();
      asteroide[i].relanzar();
    }

    println (jugador.colision);
    barraProgresoJugador.dibujar();
    if (!barra.medidorLleno) jugador.actualizar();
    barra.dibujar();
    if (barraProgresoJugador.llego) {
      estadoJuego = "nivel";
    }
    fill(255);
    text(estadoJuego, width/2, height- height/10);
  }

  void nivelCompletado() {
    cursor();
    jugador.detenerMovimientoLlegada ();
    for (int i=0; i<asteroide.length; i++) {
      asteroide[i].dibujar();
      asteroide[i].desplazar();
      if (asteroide[i].posX < -50) asteroide[i].relanzar();
    }
    fill (0, 0, 0, 225);
    rectMode (CENTER);
    rect (width/2, height/2, width - width/4, height-50);
    rectMode (CORNER);
    fill (255);
    botonVolverAlMenu.dibujar();
    if (botonVolverAlMenu.presionado()) {
      for (int i=0; i<asteroide.length; i++) {
        asteroide[i].reiniciar();
      }
      jugador.reiniciar();
      barra.reiniciar();
      barraProgresoJugador.continuar();
      estadoJuego = botonVolverAlMenu.cambiarEstado ();
    }
    botonSiguienteNivel.dibujar();
    if (botonSiguienteNivel.presionado()) {
      velFondo = 13;
      estadoAnterior = "Nivel 1";
      jugador.reiniciar();
      barra.reiniciar();
      barraProgresoJugador.continuar();
      for (int i=0; i<asteroide.length; i++) {
        asteroide[i].reiniciar();
        asteroide[i].aumentarVel();
      }
      estadoJuego = botonSiguienteNivel.cambiarEstado ();
    }
  }

  void nivel2 () {
    noCursor();

    jugador.controlarMovimiento();
    if (jugador.invencible) {
      barra.aura(jugador.posX, jugador.posY);
    }
    jugador.dibujar();

    for (int i=0; i<asteroide.length; i++) {
      if (jugador.chequearColision(asteroide[i].posX, asteroide[i].posY) && !asteroide[i].esDestruido) {
        asteroide[i].esDestruido = true;
        if (!jugador.invencible) {
          estadoJuego = "Perdió";
        }
      }
      asteroide[i].dibujar();
      asteroide[i].desplazar();
      asteroide[i].relanzar();
    }

    barraProgresoJugador.dibujar();
    if (!barra.medidorLleno) jugador.actualizar();
    barra.dibujar();
    if (barraProgresoJugador.llego) {
      estadoJuego = "gano";
    }

    fill(255);
    text(estadoJuego, width/2, height- height/10);
  }

  void estadoGanar() {
    if (velFondo > 0) {
      velFondo-= contador;
    } else {
      contador = 0;
    }
    miPlaneta.dibujar();
    jugador.Gano();
    cursor();
    if (miPlaneta.posicionado) {
      fill (0, 0, 0, 175);
      rectMode (CENTER);
      rect (width/2, height/2, width - width/4, height-50);
      rectMode (CORNER);
      fill (255);
      text("¡Ganaste!", width/2, height/2);
      botonVolverAlMenu.dibujar();
      if (botonVolverAlMenu.presionado()) {
        for (int i=0; i<asteroide.length; i++) {
          asteroide[i].reiniciar();
          asteroide[i].velAumentada = false;
        }
        jugador.reiniciar();
        barra.reiniciar();
        barraProgresoJugador.reiniciar();

        estadoAnterior = "Ninguno";
        estadoJuego = botonVolverAlMenu.cambiarEstado ();
      }
    }
  }

  void estadoPerder () {
    cursor();
    jugador.detenerMovimiento ();
    for (int i=0; i<asteroide.length; i++) {
      asteroide[i].dibujar();
      asteroide[i].desplazar();
      if (asteroide[i].posX < -50) asteroide[i].relanzar();
    }

    botonVolverAlMenu.dibujar();
    if (botonVolverAlMenu.presionado()) {
      for (int i=0; i<asteroide.length; i++) {
        asteroide[i].reiniciar();
      }
      jugador.reiniciar();
      barra.reiniciar();
      barraProgresoJugador.reiniciar();
      estadoAnterior = "Ninguno";
      estadoJuego = botonVolverAlMenu.cambiarEstado ();
    }

    botonReiniciarJuego.dibujar();
    if (botonReiniciarJuego.presionado()) {
      jugador.reiniciar();
      barra.reiniciar();
      barraProgresoJugador.reiniciar();
      miPlaneta.reiniciar();
      for (int i=0; i<asteroide.length; i++) {
        asteroide[i].reiniciar();
      }
      if (estadoAnterior != "Nivel 1") {
        estadoJuego = botonReiniciarJuego.cambiarEstado ();
      } else {
        velFondo = 13;
        for (int i=0; i<asteroide.length; i++) {
          asteroide[i].aumentarVel();
        }
        estadoJuego = "Nivel 2";
      }
    }
  }

  void keyPressed () {
    jugador.keyPressed();
    if (key == ' ') {
      if (barra.medidorLleno) {
        jugador.activarInvencibilidad();
        poder.trigger();
      }
      barra.activarVaciado();
    }
  }

  void keyReleased () {
    jugador.keyReleased();
  }
}