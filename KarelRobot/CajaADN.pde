public class CajaADN extends Drawable{
  private String ADN;
  
  public CajaADN(int posX, int posY, int textSize, String ADN){
    super(posX, posY, int(textWidth(ADN)+textSize), textSize*2);
    this.ADN = ADN;
  }
  
  public void setADN(String ADN){
    this.ADN = ADN;
  }
  public String getADN(){
    return ADN;
  }
  
  @Override
  public void draw(){
    rectMode(CORNER);
    fill(255);
    rect(posX, posY, ancho, alto);
    fill(0);
    text(ADN, posX+8, posY+16+6);
  }
}
