public abstract class Drawable {
  protected int posX;
  protected int posY;
  protected int ancho;
  protected int alto;

  public Drawable(){
    this.posX = 0;
    this.posY = 0;
    this.ancho = 0;
    this.alto = 0;
  }

  public Drawable(int posX, int posY, int ancho, int alto) {
    this.posX = posX;
    this.posY = posY;
    this.ancho = ancho;
    this.alto = alto;
  }
  
  // ******* Inicio Getters y Setters *******
  public int getPosX() {
    return posX;
  }
  public void setPosX(int posX) {
    this.posX = posX;
  }
  public int getPosY() {
    return posY;
  }
  public void setPosY(int posY) {
    this.posY = posY;
  }
  public int getAncho() {
    return ancho;
  }
  public void setAncho(int ancho) {
    this.ancho = ancho;
  }
  public int getAlto() {
    return alto;
  }
  public void setAlto(int alto) {
    this.alto = alto;
  }
  // ******* Fin Getters y Setters *******
  
  public abstract void draw();
}
