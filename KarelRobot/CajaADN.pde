public class CajaADN extends Drawable{
  private String ADN;
  private int lineIzq, lineDer;
  private int lineY;
  
  public CajaADN(int posX, int posY, int textSize){
    super(posX, posY, int(textWidth("0000000000000000")+textSize), textSize*2);
    this.ADN = "";
    this.lineIzq = posX;
    this.lineY = posY+textSize;
    this.lineDer = posX+ancho;
  }
  
  public CajaADN(int posX, int posY, int textSize, String ADN){
    super(posX, posY, int(textWidth(ADN)+textSize), textSize*2);
    this.ADN = ADN;
    this.lineIzq = posX;
    this.lineY = posY+textSize;
    this.lineDer = posX+ancho;
  }
  
  // ******* Inicio Getters y Setters *******
  public void setADN(String ADN){
    this.ADN = ADN;
  }
  public String getADN(){
    return ADN;
  }
  
  public void setLineIzq(int lineIzq){
    this.lineIzq = lineIzq;
  }
  public int getLineIzq(){
    return lineIzq;
  }
  
  public void setLineDer(int lineDer){
    this.lineDer = lineDer;
  }
  public int getLineDer(){
    return lineDer;
  }
  
  public void setLineY(int lineY){
    this.lineY = lineY;
  }
  public int getLineY(){
    return lineY;
  }
  // ******* Fin Getters y Setters *******
  
  @Override
  public void draw(){
    rectMode(CORNER);
    fill(255);
    rect(posX, posY, ancho, alto);
    fill(0);
    text(ADN, posX+8, posY+16+6);
  }
}
