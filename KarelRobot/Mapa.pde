public class Mapa extends Drawable  implements Focusable {
  private int lineasV[][];
  private int lineasH[][];
  private int zumbadores[][];

  public Mapa(int posX, int posY, int ancho, int alto) {
    super(posX, posY, ancho, alto);
    println("Ancho: " + (ancho-posX));
    println("Alto: " + (alto-posY));
    println("Espacios horizontales: " + (ancho-posX)/40);
    println("Espacios verticales: " + (alto-posY)/40);
    lineasV = new int[((ancho-posX)/40)+1][((alto-posY)/40)+1];
    lineasH = new int[((ancho-posX)/40)+1][((alto-posY)/40)+1];
    zumbadores = new int[((ancho-posX)/40)][((alto-posY)/40)];
    // ******** Inicio preparar mapa ********
    for (int i=0; i<lineasV[0].length-1; i++) {
      lineasV[0][i] = 1;
      lineasV[lineasV.length-1][i] = 1;
    }
    for (int i=0; i<lineasH.length-1; i++) {
      lineasH[i][0] = 1;
      lineasH[i][lineasH[0].length-1] = 1;
    }
    zumbadores[int(random(zumbadores.length))][int(random(zumbadores[0].length))] = 1;
    // ******** Fin preparar mapa ********
  }

  @Override
    public void sensar() {
    // Sensado de regiones y actuadores
    if (mouseX >= posX && mouseX <=ancho && mouseY >= posY && mouseY <= alto) {
      // Region 1
      if ((mouseX-posX)%40 >= 0 && (mouseX-posX)%40 <= 10) {
        if ((mouseY-posY)%40 >= 10 && (mouseY-posY)%40 <= 40) {
          println("Mouse (X<V>" + int((mouseX-posX)/40)+", Y<V> " + int((mouseY-posY)/40)+")");
          if (lineasV[(mouseX-posX)/40][(mouseY-posY)/40] == 0) {
            lineasV[(mouseX-posX)/40][(mouseY-posY)/40] = 1;
          } else {
            lineasV[(mouseX-posX)/40][(mouseY-posY)/40] = 0;
          }
        }
      }  
      // Region 2
      if ((mouseX-posX)%40 >= 10 && (mouseX-posX)%40 <= 40) {
        if ((mouseY-posY)%40 >= 0 && (mouseY-posY)%40 <= 10) {
          println("Mouse (X<H>" + int((mouseX-posX)/40)+", Y<H> " + int((mouseY-posY)/40)+")");
          if (lineasH[(mouseX-posX)/40][(mouseY-posY)/40] == 0) {
            lineasH[(mouseX-posX)/40][(mouseY-posY)/40] = 1;
          } else {
            lineasH[(mouseX-posX)/40][(mouseY-posY)/40] = 0;
          }
        }
      }
      // Region 3
      if ((mouseX-posX)%40 >= 10+2 && (mouseX-posX)%40 <= 40-2) {
        if ((mouseY-posY)%40 >= 10+2 && (mouseY-posY)%40 <= 40-2) {
          if (((mouseX-posX)/40) >= 0 && ((mouseX-posX)/40) < (((ancho-posX)/40)-1)) {
            if (((mouseY-posY)/40) >= 0 && ((mouseY-posY)/40) < (((alto-posY)/40)-1)) {
              println("Mouse (X<Z>" + int((mouseX-posX)/40)+", Y<Z> " + int((mouseY-posY)/40)+")");
              if (zumbadores[((mouseX-posX)/40)][((mouseY-posY)/40)] == 0) {
                zumbadores[((mouseX-posX)/40)][((mouseY-posY)/40)] = 1;
              } else {
                zumbadores[((mouseX-posX)/40)][((mouseY-posY)/40)] = 0;
              }
            } else {
              println("Limite vertical");
            }
          } else {
            println("Limite horizontal");
          }
        }
      }
    }
  }

  @Override
    public void draw() {
    // ******** Inicio dibujar cuadricula ********
    fill(100, 100, 100);
    strokeWeight(1);
    rectMode(CORNER);
    for (int j=posY; j<alto; j+=40) {
      for (int i=posX; i<ancho; i+=40) {
        rect(i, j, 10, 10);
      }
    }
    // ******** Fin dibujar cuadricula ********
    // ******** Inicio dibujar lineas ********
    fill(0);
    strokeWeight(5);
    // Region 1
    for (int i=0; i<lineasV.length; i++) {
      for (int j=0; j<lineasV[i].length; j++) {
        if (lineasV[i][j] == 1) {
          line((5+40*i)+posX, (5+40*j)+posY, (5+40*i)+posX, (45+40*j)+posY);
        }
      }
    }
    // Region 2
    for (int i=0; i<lineasH.length; i++) {
      for (int j=0; j<lineasH[i].length; j++) {
        if (lineasH[i][j] == 1) {
          line((5+40*i)+posX, (5+40*j)+posY, (45+40*i)+posX, (5+40*j)+posY);
        }
      }
    }
    // ******** Fin dibujar lineas ********
    // ******** Inicio dibujar zumbadores ********
    strokeWeight(0);
    rectMode(CORNERS);
    textSize(18);
    // Region 3
    for (int i=0; i< zumbadores.length; i++) {
      for (int j=0; j< zumbadores[i].length; j++) {
        if (zumbadores[i][j] == 1) {
          fill(255, 255, 0);
          rect((18+(40*i))+posX, (14+(40*j))+posY, (32+(40*i))+posX, (36+(40*j))+posY);
          fill(0);
          text("1", (21+(40*i))+posX, (31+(40*j))+posY);
        }
      }
    }
    // ******** Fin dibujar zumbadores ********
    // ******** Inicio dibujar borde ********
    noFill();
    strokeWeight(1);
    rect(posX, posY, ancho, alto);
    // ******** Fin dibujar borde ********
  }
}
