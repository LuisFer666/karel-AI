
Karel[] karel;
Mapa[] mapa;
Codigo[] codigo;

Botones botones;

void setup() {
  size(1600, 850);  

  mapa = new Mapa[8];
  int x=0;
  int y=70;
  int ancho = 400;
  int alto = 400;
  for (int i=0; i<mapa.length; i++) {
    mapa[i] = new Mapa(x, y, ancho, alto);
    ancho+=400;
    x+=400;
    if (x>=1600) {
      x = 0;
      ancho = 400;
      alto +=400;
      y +=400;
    }
  }

  karel = new Karel[8];
  for (int i=0; i<karel.length; i++) {
    karel[i] = new Karel(mapa[i]);
  }

  codigo = new Codigo[8];
  for (int i=0; i<codigo.length; i++) {
    codigo[i] = new Codigo(karel[i]);
  }

  botones = new Botones();

  frameRate(60);
}

public void dibujar_ADN() {
  for (int i=0; i<codigo.length; i++) {
    String ADN = codigo[i].getADN();
    text("ADN: "+ADN, mapa[i].posX, mapa[i].posY-5);
  }
}

void draw() {
  background(255);

  botones.draw();
  
  dibujar_ADN();

  for (Mapa a : mapa) {
    a.draw();
  }

  for (Karel k : karel) {
    k.draw();
  }

  for (Codigo c : codigo) {
    if (c.getRunning()) {
      c.execute();
    }
  }
}

void mouseClicked() {
  for (Mapa m : mapa) {
    m.sensar();
  }

  botones.sensar();
}
