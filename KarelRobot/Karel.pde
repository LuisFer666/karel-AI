public class Karel extends Drawable {
  private Mapa mapa;
  private Codigo codigo;
  private int id;
  private int heading;
  private final int UP=0;
  private final int LEFT=1;
  private final int DOWN=2;
  private final int RIGHT=3;
  private PShape karel;
  private int zumbadores;
  private int err_fuera;
  private int err_zumbador;
  private int err_pared;

  public Karel(int id) {
    super();
    this.id = id;
    heading = UP;
    err_fuera = 0;
    err_zumbador = 0;
    err_pared = 0;
    zumbadores = 0;
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
  }

  // *** Movimientos ***
  public void arriba() {
    if (posY-40 >= (35+this.mapa.posY)) {
      posY-=40;
    } else {
      err_fuera++;
      println(id+": Karel intentó salir de la pantalla (arriba): " + err_fuera);
    }
  }

  public void abajo() {
    if (posY+40 <= (35+this.mapa.alto)) {
      posY+=40;
    } else {
      err_fuera++;
      println(id+": Karel intentó salir de la pantalla (abajo): " + err_fuera);
    }
  }

  public void izquierda() {
    if (posX-40 >= (35+this.mapa.posX)) {
      posX-=40;
    } else {
      err_fuera++;
      println(id+": Karel intentó salir de la pantalla (izquierda): " + err_fuera);
    }
  }

  public void derecha() {
    if (posX+40 <= (35+this.mapa.ancho)) {
      posX+=40;
    } else {
      err_fuera++;
      println(id+": Karel intentó salir de la pantalla (derecha): " + err_fuera);
    }
  }

  public void gira_izquierda() {
    karel.rotate(radians(-90)); // gira-izquierda
    heading = (heading+1)%4;
    println(id+": Heading: "+heading);
  }

  public boolean frente_libre() {
    if (heading == UP) {
      if (this.mapa.lineasH[(posX-this.mapa.posX)/40][(posY-this.mapa.posY)/40] == 0) {
        println(id+": Frente-libre");
        return true;
      } else {
        println(id+": Frente-bloqueado");
        return false;
      }
    } else if (heading == LEFT) {
      if (this.mapa.lineasV[(posX-this.mapa.posX)/40][(posY-this.mapa.posY)/40] == 0) {
        println(id+": Frente-libre");
        return true;
      } else {
        println(id+": Frente-bloqueado");
        return false;
      }
    } else if (heading == DOWN) {
      if (this.mapa.lineasH[(posX-this.mapa.posX)/40][((posY+40)-this.mapa.posY)/40] == 0) {
        println(id+": Frente-libre");
        return true;
      } else {
        println(id+": Frente-bloqueado");
        return false;
      }
    } else if (heading == RIGHT) {
      if (this.mapa.lineasV[((posX+40)-this.mapa.posX)/40][(posY-this.mapa.posY)/40] == 0) {
        println(id+": Frente-libre");
        return true;
      } else {
        println(id+": Frente-bloqueado");
        return false;
      }
    }
    return false;
  }

  public void adelante() {
    boolean res = frente_libre();
    if (heading == UP) {
      if (res) {
        arriba();
      } else {
        err_pared++;
        println(id+": Karel intentó atravesar una pared: " + err_pared);
      }
    } else if (heading == LEFT) {
      if (res) {
        izquierda();
      } else {
        err_pared++;
        println(id+": Karel intentó atravesar una pared: " + err_pared);
      }
    } else if (heading == DOWN) {
      if (res) {
        abajo();
      } else {
        err_pared++;
        println(id+": Karel intentó atravesar una pared: " + err_pared);
      }
    } else if (heading == RIGHT) {
      if (res) {
        derecha();
      } else {
        err_pared++;
        println(id+": Karel intentó atravesar una pared: " + err_pared);
      }
    }
  }

  public boolean sobre_zumbador() {
    if (this.mapa.zumbadores[((posX-35)-this.mapa.posX)/40][((posY-35)-this.mapa.posY)/40]==1) {
      println(id+": Sobre zumbador");
      return true;
    }
    println(id+": No hay zumbador");
    return false;
  }

  public void coge_zumbador() {
    if (this.mapa.zumbadores[((posX-35)-this.mapa.posX)/40][((posY-35)-this.mapa.posY)/40]==1) {
      println(id+": Coger zumbador");
      this.mapa.zumbadores[((posX-35)-this.mapa.posX)/40][((posY-35)-this.mapa.posY)/40]=0;
      zumbadores++;
    } else {
      err_zumbador++;
      println(id+": Karel intentó coger un zumbador donde no había: " + err_zumbador);
    }
  }
  // ******* Inicio Getters y Setters *******
  public int getErrZumbador() {
    return err_zumbador;
  }
  public int getErrFuera() {
    return err_fuera;
  }
  public int getErrPared() {
    return err_pared;
  }
  public void setCodigo(Codigo codigo) {
    this.codigo = codigo;
  }
  public Codigo getCodigo() {
    return codigo;
  }
  public void setZumbadores(int zumbadores) {
    this.zumbadores = zumbadores;
  }
  public int getZumbadores() {
    return zumbadores;
  }
  public void setMapa(Mapa mapa) {
    this.mapa = mapa;
    setPosX(35+mapa.getPosX());
    setPosY(35+mapa.getPosY());
    setAncho(30);
    setAlto(30);
  }
  public Mapa getMapa() {
    return mapa;
  }
  // ******* Fin Getters y Setters *******
  @Override
    public void draw() {
    shapeMode(CENTER);
    shape(karel, posX, posY);
  }
}
