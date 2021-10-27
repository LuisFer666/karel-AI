public class Icono extends Drawable {
  private PShape sprite;

  public Icono(String icono, int posX, int posY, int ancho, int alto) {
    super(posX, posY, ancho, alto);
    PImage img = loadImage(icono);
    sprite = createShape(RECT, 0, 0, ancho, alto);
    sprite.setTexture(img);
  }

  @Override
    public void draw() {
    shapeMode(CORNER);
    shape(sprite, posX, posY);
  }
}
