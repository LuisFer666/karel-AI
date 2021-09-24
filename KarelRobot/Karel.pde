public class Karel {
  private PShape karel;
  private int px, py;
  private int err_fuera;
  private int err_zumbador;
  private int heading;
  private Mapa mapa;
  /*
  0 = up
   1 = left
   2 = down
   3 = right
   */

  public Karel(Mapa mapa) {
    // Creación del shape de karel
    karel = createShape();
    karel.beginShape();
    karel.fill(0, 0, 255);
    karel.strokeWeight(1);
    karel.vertex(0, -15);
    karel.vertex(15, 0);
    karel.vertex(7.5, 0);
    karel.vertex(7.5, 15);
    karel.vertex(-7.5, 15);
    karel.vertex(-7.5, 0);
    karel.vertex(-15, 0);
    karel.endShape(CLOSE);

    this.mapa = mapa;

    // Orientación de karel
    heading = 0;
    // Posicion inicial de karel
    px = 35+this.mapa.posX;
    py = 35+this.mapa.posY;
    err_fuera = 0;
    err_zumbador = 0;
  }

  // *** Movimientos ***
  public void arriba() {
    if (py >= 40+(35+this.mapa.posY)) {
      py-=40;
    } else {
      err_fuera++;
      println("Karel intentó salir de la pantalla" + err_fuera);
    }
  }

  public void abajo() {
    py+=40;
    println("px:"+px+"lim:" +(35+this.mapa.posX)+" py:"+py+"lim:" +(35+this.mapa.posY));
  }

  public void derecha() {
    px+=40;
    println("px:"+px+"lim:" +(35+this.mapa.posX)+" py:"+py+"lim:" +(35+this.mapa.posY));
  }

  public void izquierda() {
    px-=40;
    println("px:"+px+"lim:" +(35+this.mapa.posX)+" py:"+py+"lim:" +(35+this.mapa.posY));
  }

  public void gira_izquierda() {
    karel.rotate(radians(-90)); // gira-izquierda
    heading = (heading+1)%4;
    println("Heading: "+heading);
  }

  public boolean frente_libre() {
    if (heading == 0) {
      if (this.mapa.lineasH[(px-this.mapa.posX)/40][(py-this.mapa.posY)/40] == 0) {
        println("Frente-libre");
        return true;
      } else {
        println("Frente-bloqueado");
        return false;
      }
    } else if (heading == 1) {
      if (this.mapa.lineasV[(px-this.mapa.posX)/40][(py-this.mapa.posY)/40] == 0) {
        println("Frente-libre");
        return true;
      } else {
        println("Frente-bloqueado");
        return false;
      }
    } else if (heading == 2) {
      if (this.mapa.lineasH[(px-this.mapa.posX)/40][((py+40)-this.mapa.posY)/40] == 0) {
        println("Frente-libre");
        return true;
      } else {
        println("Frente-bloqueado");
        return false;
      }
    } else if (heading == 3) {
      if (this.mapa.lineasV[((px+40)-this.mapa.posX)/40][(py-this.mapa.posY)/40] == 0) {
        println("Frente-libre");
        return true;
      } else {
        println("Frente-bloqueado");
        return false;
      }
    }
    return false;
  }

  public void adelante() {
    if (heading == 0) {
      arriba();
    } else if (heading == 1) {
      izquierda();
    } else if (heading == 2) {
      abajo();
    } else if (heading == 3) {
      derecha();
    }
  }

  public boolean sobre_zumbador() {
    if (this.mapa.zumbadores[(px-this.mapa.posX)/40][(py-this.mapa.posY)/40]==1) {
      println("Sobre zumbador");
      return true;
    }
    println("No hay zumbador");
    return false;
  }

  public void coge_zumbador() {
    if (this.mapa.zumbadores[(px-this.mapa.posX)/40][(py-this.mapa.posY)/40]==1) {
      println("Coger zumbador");
      this.mapa.zumbadores[(px-this.mapa.posX)/40][(py-this.mapa.posY)/40]=0;
    } else {
      err_zumbador++;
      println("Karel intentó coger un zumbador donde no había" + err_zumbador);
    }
  }

  public int getErrZumbador() {
    return err_zumbador;
  }

  public int getErrFuera() {
    return err_fuera;
  }

  public void draw() {
    shapeMode(CENTER);
    shape(karel, px, py);
  }
}
