import java.util.Queue;
import java.util.LinkedList;

public class Codigo {
  private Queue<Integer> cola;
  private Karel karel;
  private String ADN;
  private boolean running;
  private int ciclo;
  private double eficiencia;

  public Codigo(Karel karel) {
    this.running = false;
    this.karel = karel;
    cola = new LinkedList();
    ciclo = 0;
    eficiencia = 0;
    generarADN();
    cargarCodigo();
  }

  public void generarADN() {
    ADN = "";
    for (int i=0; i<16; i++) {
      ADN += int(random(5));
    }
    println("ADN: " + ADN);
  }

  /*
  Se maneja una población con un conjunto de individuos. Por ejemplo 100 agentes en la pantalla, cada uno con su ADN propio
   
   Se van a evaluar después de 20 ciclos o 100 ciclos y hay que ver que rendimiento tuvo.
   
   Calcular una función de idoneidad
   
   * Salir de los bordes del mapa
   * Chocar con paredes
   * Recoger zumbadores
   
   */
  public void cargarCodigo() {
    for (int i=0; i<ADN.length(); i++) {
      switch(ADN.charAt(i)) {
      case '0':
        adelante();
        break;

      case '1':
        gira_izquierda();
        break;

      case '2':
        frente_libre();
        break;

      case '3':
        sobre_zumbador();
        break;

      case '4':
        coge_zumbador();
        break;
      }
    }
  }
  /*
  0 = karel.adelante();
   1 = karel.gira_izquierda();
   2 = karel.frente_libre();
   3 = karel.sobre_zumbador();
   4 = karel.coge_zumbador();
   */

  public void adelante() {
    cola.add(0);
  }

  public void gira_izquierda() {
    cola.add(1);
  }

  public void frente_libre() {
    cola.add(2);
  }

  public void sobre_zumbador() {
    cola.add(3);
  }

  public void coge_zumbador() {
    cola.add(4);
  }
  
  // ******* Inicio Getters y Setters *******
  public boolean getRunning() {
    return running;
  }
  public void setRunning(boolean running) {
    this.running = running;
  }
  public String getADN() {
    return ADN;
  }
  public void setCiclo(int ciclo) {
    this.ciclo = ciclo;
  }
  public int getCiclo() {
    return ciclo;
  }
  public void setEficiencia(double eficiencia) {
    this.eficiencia = eficiencia;
  }
  public double getEficiencia() {
    return eficiencia;
  }
  // ******* Fin Getters y Setters *******

  public void execute() {
    if (!cola.isEmpty()) {
      int a = cola.poll();
      if (a == 0) {
        this.karel.adelante();
      } else if (a == 1) {
        this.karel.gira_izquierda();
      } else if (a == 2) {
        this.karel.frente_libre();
      } else if (a == 3) {
        this.karel.sobre_zumbador();
      } else if (a == 4) {
        this.karel.coge_zumbador();
      }
    } else {
      println("*****************");
      println("Errores");
      println("Err-coger-zumbador: "+this.karel.getErrZumbador());
      println("Err-fuera: "+this.karel.getErrFuera());
      println("Err-pared: "+this.karel.getErrPared());
      ciclo++;
      cargarCodigo();
    }
  }
}
