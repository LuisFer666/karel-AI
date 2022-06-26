import java.util.Map;
import java.util.TreeMap;
import java.util.Iterator;

public Karel karel[];

public Botones botones;
public Icono errores[][];

CajaADN cajaPobInicial[];
CajaADN cajaSeleccion[];
CajaADN cajaCruce[];
CajaADN cajaMutacion[];

int robots; // Cantidad de robots que terminaron su programa
Map<Integer, String> bestDNA;
int frame;

private void crearInstancias(){
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
}

private void dibujarCajas(){
  textSize(16);
  // ********** Dibujado de cajas **********
  int cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaPobInicial.length; i++) {
    cajaPobInicial[i] = new CajaADN(180, cajaPosY, 16);
    cajaPobInicial[i].draw();
    cajaPosY+=40;
  }
  text("Poblacion inicial", 180, cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaSeleccion.length; i++) {
    cajaSeleccion[i] = new CajaADN(cajaPobInicial[0].getPosX()+(2*cajaPobInicial[0].getAncho()), cajaPosY, 16);
    cajaSeleccion[i].draw();
    cajaPosY+=40;
  }
  text("Seleccion", cajaPobInicial[0].getPosX()+(2*cajaPobInicial[0].getAncho()), cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaCruce.length; i++) {
    cajaCruce[i] = new CajaADN(cajaSeleccion[0].getPosX()+(2*cajaSeleccion[0].getAncho()), cajaPosY, 16);
    cajaCruce[i].draw();
    cajaPosY+=40;
  }
  text("Cruce", cajaSeleccion[0].getPosX()+(2*cajaSeleccion[0].getAncho()), cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaMutacion.length; i++) {
    cajaMutacion[i] = new CajaADN(cajaCruce[0].getPosX()+(2*cajaCruce[0].getAncho()), cajaPosY, 16);
    cajaMutacion[i].draw();
    cajaPosY+=40;
  }
  text("Mutacion", cajaCruce[0].getPosX()+(2*cajaCruce[0].getAncho()), cajaPosY+10);
  // ********** Fin de dibujado de cajas **********
}

public void setup() {
  size(1700, 1030);
  robots = 0;
  frame = -1;

  // Creación de Karel, mapas, codigos aleatorios
  crearInstancias();
  
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

  bestDNA = new TreeMap<Integer, String>();
  
  dibujarCajas();
  
  // Creación de los botones
  botones = new Botones();
  frameRate(60);
}

public void draw() {
  // Set color de fondo blanco
  background(255);
  botones.draw();
  // Dibujar mapas y agentes
  robots = 0;
  for (Karel k : karel) {
    k.getMapa().draw();
    k.draw();
    if (k.getZumbadores()>=1) {
      k.getCodigo().setRunning(false);
      // CALCULAR LA EFICIENCIA DEL CODIGO
      k.getCodigo().calcularEficiencia();
      robots++;
    } else {
      // Ejecutar el codigo solo si tiene el estado running = true y si aun no se llega a 200 ciclos
      if (k.getCodigo().getRunning() && k.getCodigo().getCiclo() < 200) {
        k.getCodigo().execute();
      } else if (k.getCodigo().getCiclo() >= 200) {
        robots++; // Fin de los 200 ciclos. Buscar las mejores eficiencias, ordenar y evolucionar
      }
    }
  }
  if (robots == 8) {
    // Ordenar el ADN de acuerdo a la eficiencia
    int c = 8;
    for (Karel k : karel) {
      int efi = k.getCodigo().getEficiencia();
      String adn = k.getCodigo().getADN();
      if (efi > 8) {
        bestDNA.put(-efi, adn);
      } else {
        bestDNA.put(efi-c, adn);
      }
      c--;
    }
    // Mostrar los mejores ADN en las cajas
    Iterator it = bestDNA.keySet().iterator();
    for (int i=0; i<4; i++) {
      if (it.hasNext()) {
        Integer index = (Integer)it.next();
        cajaPobInicial[i].setADN(bestDNA.get(index));
        text(""+abs(index), cajaPobInicial[i].getPosX()+cajaPobInicial[i].getAncho()+10, cajaPobInicial[i].getPosY());
      }
    }
    // ***** Inicio Algoritmo de seleccion *****
    if (frame == -1) {
      frame = frameCount;
    }
    if ((frame != -1) && (frameCount >= frame+384)) {
      cajaSeleccion[0].setShowPuntoCruce(true);
      cajaSeleccion[0].setADN(cajaPobInicial[1].getADN());

      cajaSeleccion[1].setShowPuntoCruce(true);
      cajaSeleccion[1].setPuntoCruce(cajaSeleccion[0].getPuntoCruce());
      cajaSeleccion[1].setADN(cajaPobInicial[0].getADN());

      cajaSeleccion[2].setShowPuntoCruce(true);
      cajaSeleccion[2].setADN(cajaPobInicial[1].getADN());

      cajaSeleccion[3].setShowPuntoCruce(true);
      cajaSeleccion[3].setPuntoCruce(cajaSeleccion[2].getPuntoCruce());
      cajaSeleccion[3].setADN(cajaPobInicial[2].getADN());
    }
    // ***** Fin Algoritmo de seleccion *****
    // ************* Inicio Algoritmo de Cruce *************
    if ((frame != -1) && (frameCount >= frame+768)) {
      int puntoCruce = cajaSeleccion[0].getPuntoCruce();
      String adn1 = cajaSeleccion[0].getADN();
      String adn2 = cajaSeleccion[1].getADN();
      cajaCruce[0].setShowPuntoCruce(true);
      cajaCruce[0].setADN(adn1.substring(0, puntoCruce) + adn2.substring(puntoCruce, 16));
      cajaCruce[0].setPuntoCruce(cajaSeleccion[0].getPuntoCruce());

      cajaCruce[1].setShowPuntoCruce(true);
      cajaCruce[1].setADN(adn2.substring(0, puntoCruce) + adn1.substring(puntoCruce, 16));
      cajaCruce[1].setPuntoCruce(cajaSeleccion[0].getPuntoCruce());

      puntoCruce = cajaSeleccion[2].getPuntoCruce();
      adn1 = cajaSeleccion[2].getADN();
      adn2 = cajaSeleccion[3].getADN();
      cajaCruce[2].setShowPuntoCruce(true);
      cajaCruce[2].setADN(adn1.substring(0, puntoCruce) + adn2.substring(puntoCruce, 16));
      cajaCruce[2].setPuntoCruce(cajaSeleccion[2].getPuntoCruce());

      cajaCruce[3].setShowPuntoCruce(true);
      cajaCruce[3].setADN(adn2.substring(0, puntoCruce) + adn1.substring(puntoCruce, 16));
      cajaCruce[3].setPuntoCruce(cajaSeleccion[2].getPuntoCruce());
    }
    // ************* Fin Algoritmo de Cruce *************
    // ************* Inicio Algoritmo de Mutacion *************
    if ((frame != -1) && (frameCount >= frame+1152) && (cajaMutacion[3].getFlagMutacion())) {
      cajaMutacion[0].setADN(cajaCruce[0].getADN());
      cajaMutacion[0].setShowMutacion(true);
      cajaMutacion[0].mutar();

      cajaMutacion[1].setADN(cajaCruce[1].getADN());
      cajaMutacion[1].setShowMutacion(true);
      cajaMutacion[1].mutar();

      cajaMutacion[2].setADN(cajaCruce[2].getADN());
      cajaMutacion[2].setShowMutacion(true);
      cajaMutacion[2].mutar();

      cajaMutacion[3].setADN(cajaCruce[3].getADN());
      cajaMutacion[3].setShowMutacion(true);
      cajaMutacion[3].mutar();
    }
    // ************* Fin Algoritmo de Mutacion *************
    // ************* Inicio Reinicio del algoritmo evolutivo *************
    if ((frame != -1) && (frameCount >= frame+1536)) {
      for (Karel k : karel) {
        k.getCodigo().setRunning(false);
      }

      frameRate(128);
      println("Nueva generacion");
      // Coordenadas de los mapas
      int x=0;
      int y=70;
      int ancho = 400;
      int alto = 400;
      for (int i=0; i<karel.length; i++) {
        karel[i] = new Karel(i);
        // Creación del codigo de cada Karel
        if (i < 4) {
          karel[i].setCodigo(new Codigo(karel[i]));
          karel[i].getCodigo().setADN(cajaMutacion[i].getADN());
        } else {
          karel[i].setCodigo(new Codigo(karel[i]));
        }

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
      for (Karel k : karel) {
        k.getCodigo().setRunning(true);
      }
      frame = -1;
    }
    robots=0;
  }
  // ************* Fin Reinicio del algoritmo evolutivo *************
  // ********** Inicio de dibujado de cajas **********
  int cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaPobInicial.length; i++) {
    cajaPobInicial[i].draw();
    cajaPosY+=40;
  }
  text("Poblacion inicial", 180, cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaSeleccion.length; i++) {
    cajaSeleccion[i].draw();
    cajaPosY+=40;
  }
  text("Seleccion", cajaPobInicial[0].getPosX()+(2*cajaPobInicial[0].getAncho()), cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaCruce.length; i++) {
    cajaCruce[i].draw();
    cajaPosY+=40;
  }
  text("Cruce", cajaSeleccion[0].getPosX()+(2*cajaSeleccion[0].getAncho()), cajaPosY+10);

  cajaPosY = karel[4].getMapa().getAlto()+50;
  for (int i=0; i<cajaMutacion.length; i++) {
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
    text(" | %efi: " + karel[i].getCodigo().getEficiencia(), x, karel[i].getMapa().getPosY()-5);
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
}

public void mouseClicked() {
  // Sensar mapa
  for (Karel k : karel) {
    k.getMapa().sensar();
  }
  // Sensar botones
  botones.sensar();
}
