
public Karel karel[];
public Botones botones;
public Icono errores[][];

CajaADN cajaPobInicial[];
CajaADN cajaSeleccion[];
CajaADN cajaCruce[];
CajaADN cajaMutacion[];

public void setup() {
  size(1700, 1030);
  // Creación de los Karel
  karel = new Karel[8];
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
  // Iconos de error
  errores = new Icono[8][3];
  for (int i=0; i<errores.length; i++) {
    errores[i][0] = new Icono("err_colision.png", karel[i].getMapa().getPosX()+80, karel[i].getMapa().getAlto()+7, 24, 24);
    errores[i][1] = new Icono("err_beeper.png", karel[i].getMapa().getPosX()+160, karel[i].getMapa().getAlto()+7, 24, 24);
    errores[i][2] = new Icono("err_outScreen.png", karel[i].getMapa().getPosX()+240, karel[i].getMapa().getAlto()+7, 24, 24);
  }
  
  cajaPobInicial = new CajaADN[4];
  cajaSeleccion = new CajaADN[4];
  cajaCruce = new CajaADN[4];
  cajaMutacion = new CajaADN[4];
  
  // Creación de los botones
  botones = new Botones();
  frameRate(60);
}

public void draw() {
  // Set color de fondo blanco
  background(255);
  botones.draw();
  // Dibujar mapas y agentes
  for (Karel k : karel) {
    k.getMapa().draw();
    k.draw();
    if (k.getZumbadores()>=1) {
      k.getCodigo().setRunning(false);
      // CALCULAR LA EFICIENCIA DEL CODIGO
      k.getCodigo().calcularEficiencia();
    } else {
      // Ejecutar el codigo solo si tiene el estado running = true y si aun no se llega a 200 ciclos
      if (k.getCodigo().getRunning() && k.getCodigo().getCiclo() < 200) {
        k.getCodigo().execute();
      }
    }
  }
  // ********** Inicio dibujar textos **********
  for (int i=0; i<karel.length; i++) {
    String ADN = karel[i].getCodigo().getADN();
    int ciclo = karel[i].getCodigo().getCiclo();
    int err_pared = karel[i].getErrPared();
    int err_zumbador = karel[i].getErrZumbador();
    int err_fuera = karel[i].getErrFuera();
    textSize(16);
    float x = karel[i].getMapa().getPosX();
    text("ADN: "+ADN, x, karel[i].getMapa().getPosY()-5);
    x = x+textWidth("ADN:"+ADN);
    text(" | Ciclo: "+ciclo, x, karel[i].getMapa().getPosY()-5);
    x = x+textWidth(" | Ciclo: "+ciclo);
    text(" | %efi: " + String.format(""+karel[i].getCodigo().getEficiencia(), "%.2f"), x, karel[i].getMapa().getPosY()-5);
    text("Errores", karel[i].getMapa().getPosX(), karel[i].getMapa().getAlto()+24);
    text(err_pared, karel[i].getMapa().getPosX()+110, karel[i].getMapa().getAlto()+24);
    text(err_zumbador, karel[i].getMapa().getPosX()+190, karel[i].getMapa().getAlto()+24);
    text(err_fuera, karel[i].getMapa().getPosX()+280, karel[i].getMapa().getAlto()+24);
  }
  // ********** Fin dibujar textos **********
  // ********** Inicio dibujar iconos **********
  for (int i=0; i<errores.length; i++) {
    errores[i][0].draw();
    errores[i][1].draw();
    errores[i][2].draw();
  }
  // ********** Fin dibujar iconos **********
  rectMode(CORNER);
  fill(255);
  
  // ********** Dibujado de cajas **********
  int cajaPosY = karel[4].getMapa().getAlto()+50;
  for(int i=0; i<cajaPobInicial.length; i++){
    cajaPobInicial[i] = new CajaADN(20, cajaPosY, 16);
    cajaPobInicial[i].draw();
    cajaPosY+=40;
  }
  text("Poblacion inicial", 20, cajaPosY+10);
  
  cajaPosY = karel[4].getMapa().getAlto()+50;
  for(int i=0; i<cajaSeleccion.length; i++){
    cajaSeleccion[i] = new CajaADN(cajaPobInicial[0].getPosX()+(2*cajaPobInicial[0].getAncho()), cajaPosY, 16);
    cajaSeleccion[i].draw();
    cajaPosY+=40;
  }
  text("Seleccion", cajaPobInicial[0].getPosX()+(2*cajaPobInicial[0].getAncho()), cajaPosY+10);
  
  cajaPosY = karel[4].getMapa().getAlto()+50;
  for(int i=0; i<cajaCruce.length; i++){
    cajaCruce[i] = new CajaADN(cajaSeleccion[0].getPosX()+(2*cajaSeleccion[0].getAncho()), cajaPosY, 16);
    cajaCruce[i].draw();
    cajaPosY+=40;
  }
  text("Cruce", cajaSeleccion[0].getPosX()+(2*cajaSeleccion[0].getAncho()), cajaPosY+10);
  
  cajaPosY = karel[4].getMapa().getAlto()+50;
  for(int i=0; i<cajaMutacion.length; i++){
    cajaMutacion[i] = new CajaADN(cajaCruce[0].getPosX()+(2*cajaCruce[0].getAncho()), cajaPosY, 16);
    cajaMutacion[i].draw();
    cajaPosY+=40;
  }
  text("Mutacion", cajaCruce[0].getPosX()+(2*cajaCruce[0].getAncho()), cajaPosY+10);
  // ********** Fin de dibujado de cajas **********
  
  // ********** Inicio de dibujado de lineas **********
  line(cajaPobInicial[0].getLineDer(), cajaPobInicial[0].getLineY(), cajaSeleccion[1].getLineIzq(), cajaSeleccion[1].getLineY());
  line(cajaPobInicial[1].getLineDer(), cajaPobInicial[1].getLineY(), cajaSeleccion[0].getLineIzq(), cajaSeleccion[0].getLineY());
  line(cajaPobInicial[1].getLineDer(), cajaPobInicial[1].getLineY(), cajaSeleccion[2].getLineIzq(), cajaSeleccion[2].getLineY());
  line(cajaPobInicial[2].getLineDer(), cajaPobInicial[2].getLineY(), cajaSeleccion[3].getLineIzq(), cajaSeleccion[3].getLineY());
  
  line(cajaSeleccion[0].getLineDer(), cajaSeleccion[0].getLineY(), cajaCruce[0].getPosX()-((2*cajaSeleccion[0].getAncho())/3), cajaCruce[0].getPosY()+35);
  line(cajaSeleccion[1].getLineDer(), cajaSeleccion[1].getLineY(), cajaCruce[0].getPosX()-((2*cajaSeleccion[0].getAncho())/3), cajaCruce[0].getPosY()+35);
  line(cajaCruce[0].getPosX()-((2*cajaSeleccion[0].getAncho())/3), cajaCruce[0].getPosY()+35, cajaCruce[0].getPosX()-((cajaSeleccion[0].getAncho())/3), cajaSeleccion[0].getPosY()+35);
  line(cajaCruce[0].getPosX()-((cajaSeleccion[0].getAncho())/3), cajaSeleccion[0].getPosY()+35, cajaCruce[1].getLineIzq(), cajaCruce[1].getLineY());
  line(cajaCruce[0].getPosX()-((cajaSeleccion[0].getAncho())/3), cajaSeleccion[0].getPosY()+35, cajaCruce[0].getLineIzq(), cajaCruce[0].getLineY());
  
  line(cajaSeleccion[2].getLineDer(), cajaSeleccion[2].getLineY(), cajaCruce[2].getPosX()-((2*cajaSeleccion[2].getAncho())/3), cajaCruce[2].getPosY()+35);
  line(cajaSeleccion[3].getLineDer(), cajaSeleccion[3].getLineY(), cajaCruce[2].getPosX()-((2*cajaSeleccion[2].getAncho())/3), cajaCruce[2].getPosY()+35);
  line(cajaCruce[2].getPosX()-((2*cajaSeleccion[2].getAncho())/3), cajaCruce[2].getPosY()+35, cajaCruce[2].getPosX()-((cajaSeleccion[2].getAncho())/3), cajaSeleccion[2].getPosY()+35);
  line(cajaCruce[2].getPosX()-((cajaSeleccion[2].getAncho())/3), cajaSeleccion[2].getPosY()+35, cajaCruce[3].getLineIzq(), cajaCruce[3].getLineY());
  line(cajaCruce[2].getPosX()-((cajaSeleccion[2].getAncho())/3), cajaSeleccion[2].getPosY()+35, cajaCruce[2].getLineIzq(), cajaCruce[2].getLineY());
  
  line(cajaCruce[0].getLineDer(), cajaCruce[0].getLineY(), cajaMutacion[0].getLineIzq(), cajaMutacion[0].getLineY());
  line(cajaCruce[1].getLineDer(), cajaCruce[1].getLineY(), cajaMutacion[1].getLineIzq(), cajaMutacion[1].getLineY());
  line(cajaCruce[2].getLineDer(), cajaCruce[2].getLineY(), cajaMutacion[2].getLineIzq(), cajaMutacion[2].getLineY());
  line(cajaCruce[3].getLineDer(), cajaCruce[3].getLineY(), cajaMutacion[3].getLineIzq(), cajaMutacion[3].getLineY());
  
  // ********** Fin de dibujado de lineas **********
}

public void mouseClicked() {
  // Sensar mapa
  for (Karel k : karel) {
    k.getMapa().sensar();
  }
  // Sensar botones
  botones.sensar();
}
