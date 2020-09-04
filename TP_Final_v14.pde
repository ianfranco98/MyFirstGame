import ddf.minim.*;

Minim sonido;
AudioSample sonidoPantallaPrincipal;
AudioPlayer cancionPrimerNivel;
AudioSample golpe;
AudioSample poder;

boolean audioReproducido;
int tiempo;

Juego vueloDelSuperheroe;
PFont fuente;

void setup () {
  size (800, 400);
  smooth();
  textAlign (CENTER);
  ellipseMode (CORNER);
  stroke(255);
  fuente = loadFont("UpheavalTT-BRK--48.vlw");
  textFont (fuente, 24);
  sonido = new Minim (this);
  sonidoPantallaPrincipal = sonido.loadSample("Sonido_pantallaInicio.mp3", 512);
  golpe = sonido.loadSample("Golpe.mp3", 512);
  poder = sonido.loadSample("Poder.mp3", 512);
  cancionPrimerNivel = sonido.loadFile("cancion1.mp3");
  vueloDelSuperheroe = new Juego();
}

void draw () {
  vueloDelSuperheroe.fondo(); 
  if (vueloDelSuperheroe.estadoJuego.equals ("Pantalla Principal")) {
    cancionPrimerNivel.loop();
    if (!audioReproducido) {
      sonidoPantallaPrincipal.trigger();
      if ((millis() - tiempo) > 2100) {
        audioReproducido = true;
        tiempo = millis();
      }
    }
    vueloDelSuperheroe.pantallaPrincipal ();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("instrucciones")) {
    cancionPrimerNivel.loop();
    vueloDelSuperheroe.comoJugar();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("Nivel 1")) {
    vueloDelSuperheroe.nivel1();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("Nivel 2")) {
    vueloDelSuperheroe.nivel2();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("Perdió")) {
    vueloDelSuperheroe.estadoPerder();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("nivel")) {
    vueloDelSuperheroe.nivelCompletado();
  } else if (vueloDelSuperheroe.estadoJuego.equals ("gano")) {
    audioReproducido = false;
    vueloDelSuperheroe.estadoGanar();
  }
}

void keyPressed () {
  vueloDelSuperheroe.keyPressed();
}

void keyReleased () {
  vueloDelSuperheroe.keyReleased();
}