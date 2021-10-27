public class CajaADN extends Drawable {
  private String ADN;
  private int lineIzq, lineDer;
  private int lineY;
  private boolean showPuntoCruce;
  private int puntoCruce;
  private boolean showMutacion;
  private int posMutacion;

  private boolean flagMutacion;

  public CajaADN(int posX, int posY, int textSize) {
    super(posX, posY, int(textWidth("0000000000000000")+16+16), textSize*2);
    this.ADN = "";
    this.lineIzq = posX;
    this.lineY = posY+textSize;
    this.lineDer = posX+ancho;
    this.showPuntoCruce = false;
    this.puntoCruce = int(random(15))+1;
    this.posMutacion = int(random(16));
    this.showMutacion = false;
    this.flagMutacion = true;
  }

  public CajaADN(int posX, int posY, int textSize, String ADN) {
    super(posX, posY, int(textWidth(ADN)+16+16), textSize*2);
    this.ADN = ADN;
    this.lineIzq = posX;
    this.lineY = posY+textSize;
    this.lineDer = posX+ancho;
    this.showPuntoCruce = false;
    this.puntoCruce = int(random(15))+1;
    this.posMutacion = int(random(16));
    this.showMutacion = false;
    this.flagMutacion = true;
  }

  // ******* Inicio Getters y Setters *******
  public void setADN(String ADN) {
    this.ADN = ADN;
  }
  public String getADN() {
    return ADN;
  }
  public void setLineIzq(int lineIzq) {
    this.lineIzq = lineIzq;
  }
  public int getLineIzq() {
    return lineIzq;
  }
  public void setLineDer(int lineDer) {
    this.lineDer = lineDer;
  }
  public int getLineDer() {
    return lineDer;
  }
  public void setLineY(int lineY) {
    this.lineY = lineY;
  }
  public int getLineY() {
    return lineY;
  }
  public void setShowPuntoCruce(boolean showPuntoCruce) {
    this.showPuntoCruce = showPuntoCruce;
  }
  public boolean getShowPuntoCruce() {
    return showPuntoCruce;
  }
  public void setPuntoCruce(int puntoCruce) {
    this.puntoCruce = puntoCruce;
  }
  public int getPuntoCruce() {
    return puntoCruce;
  }
  public void setShowMutacion(boolean showMutacion) {
    this.showMutacion = showMutacion;
  }
  public boolean getShowMutacion() {
    return showMutacion;
  }
  public void setPosMutacion(int posMutacion) {
    this.posMutacion = posMutacion;
  }
  public int getPosMutacion() {
    return posMutacion;
  }
  public void setFlagMutacion(boolean flagMutacion) {
    this.flagMutacion = flagMutacion;
  }
  public boolean getFlagMutacion() {
    return flagMutacion;
  }
  // ******* Fin Getters y Setters *******

  public void mutar() {
    if (flagMutacion) {
      String a = getADN().substring(0, posMutacion);
      String b = getADN().substring(posMutacion+1, 16);
      String digito = getADN().substring(posMutacion, posMutacion+1);
      println("************");
      println(a+"|"+digito+"|"+b);
      String val = ""+(int(random(5)));
      println(a+"|"+val+"|"+b);
      while (val==digito) {
        val = ""+(int(random(5)));
      }
      println(a+"|"+val+"|"+b);
      setADN(a+val+b);
      println(getADN());
      flagMutacion = false;
    }
  }

  @Override
    public void draw() {
    rectMode(CORNER);
    // Dibujar caja
    fill(255);
    rect(posX, posY, ancho, alto);
    // Dibujar punto de cruce
    if (showPuntoCruce) {
      line(posX+8+(int((textWidth("0000000000000000")/16)*puntoCruce)), posY-5, posX+8+(int((textWidth("0000000000000000")/16)*puntoCruce)), posY+alto+5);
    }
    // Dibujar cuadro de mutacion
    if (showMutacion) {
      fill(255);
      strokeWeight(1);
      rect(posX+6.7+(textWidth("0000000000000000")/16)*posMutacion, posY+5, textWidth("0")+1, 16+4);
    }
    // Dibujar ADN
    fill(0);
    text(ADN, posX+8, posY+16+6);
  }
}
