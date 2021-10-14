
public Karel karel[];
public Botones botones;
public Icono errores[][];

public void setup() {
  size(1900, 850);
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
}

public void mouseClicked() {
  // Sensar mapa
  for (Karel k : karel) {
    k.getMapa().sensar();
  }
  // Sensar botones
  botones.sensar();
}
