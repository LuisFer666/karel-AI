public class Botones extends Drawable implements Focusable {
  private PShape play;
  private PShape pause;
  private PShape reload;

  public Botones() {
    super((width/2)-55, 5, 110, 30);
    // Crear Shape del botón play
    play = createShape();
    play.beginShape();
    play.fill(0);
    play.strokeWeight(1);
    play.vertex(-15/3, -12);
    play.vertex(15/3, 0);
    play.vertex(-15/3, 12);
    play.endShape(CLOSE);
    // Crear Shape del botón pause
    pause = createShape(GROUP);
    PShape linea1 = createShape(RECT, -4, -15, 2, 20);
    linea1.setFill(0);
    PShape linea2 = createShape(RECT, 4, -15, 2, 20);
    linea2.setFill(0);
    pause.addChild(linea1);
    pause.addChild(linea2);
    // Crear Shape del botón reload
    PImage rel = loadImage("reload24.png");
    reload = createShape(RECT, 0, 0, 24, 24);
    reload.setTexture(rel);
  }

  // Metodo para sensar los botones de play, pause y reload
  /*
  PLAY: Activa el estado running, cambia el framerate a una velocidad elegida por el programador e imprime en consola "Now playing"
   PAUSE: Desactiva el estado running, cambia el framerate a una velocidad elegida por el programador e imprime en consola "Now in pause"
   RELOAD: Desactiva el estado running, cambia el framerate a una velocidad elegida por el programador, imprime en consola "Reloaded"
   y crea nuevas instancias de karel y del Codigo
   */

  @Override
    public void sensar() {
    if (mouseX >= (width/2)-55 && mouseX <= (width/2)-25) {
      if (mouseY >= 2 && mouseY <= 38) {
        for (Karel k : karel) {
          k.getCodigo().setRunning(true);
        }

        frameRate(10);
        println("Now playing");
      }
    } else if (mouseX >= (width/2)-15 && mouseX <= (width/2)+15) {
      if (mouseY >= 2 && mouseY <= 38) {
        for (Karel k : karel) {
          k.getCodigo().setRunning(false);
        }

        frameRate(60);
        println("Now in pause");
      }
    } else if (mouseX >= (width/2)+25 && mouseX <= (width/2)+55) {
      if (mouseY >= 2 && mouseY <= 38) {
        for (Karel k : karel) {
          k.getCodigo().setRunning(false);
        }

        frameRate(60);
        println("Reloaded");
        // Coordenadas de los mapas
        int x=0;
        int y=70;
        int ancho = 400;
        int alto = 400;
        for (int i=0; i<karel.length; i++) {
          karel[i] = new Karel(i);
          // Creación del codigo de cada Karel
          karel[i].setCodigo(new Codigo(karel[i]));
          // Creación del mapa de cada Karel
          karel[i].setMapa(new Mapa(x, y, ancho, alto));
          ancho+=400;
          x+=400;
          if (x>=1600) {
            x = 0;
            ancho = 400;
            alto +=400;
            y +=400;
          }
        }
      }
    }
  }
  
  @Override
    public void draw() {
    // Dibujar barra superior
    strokeWeight(0);
    fill(155, 155, 155);
    rectMode(CORNER);
    rect(0, 0, width, 40);
    /*
    Dibujar botones
     */
    // PLAY
    ellipseMode(CENTER);
    fill(57, 207, 234);
    ellipse((width/2)-40, 20, 30, 30);
    shapeMode(CENTER);
    shape(play, (width/2)-36, 26);
    // PAUSE
    ellipse(width/2, 20, 30, 30);
    shapeMode(CENTER);
    shape(pause, (width/2)-1, 25);
    // RELOAD
    ellipse((width/2)+40, 20, 30, 30);
    shapeMode(CENTER);
    shape(reload, (width/2)+29, 9);
  }
}
