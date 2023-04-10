// Clase para las lineas

class Line{
  // Posicion minima y maxima en el eje Z
  float minZ = -10000;
  float maxZ = 50;
  
  // Coordenadas espaciales
  float x, y, z;
  float sizeX, sizeY;
  
  // Constructor
  Line(float x, float y, float sizeX, float sizeY){
    // Posicion
    this.x = x;
    this.y = y;
    
    // Pofundidad aleatoria
    this.z = random(minZ, maxZ);
    
    // Tamaño
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  // Funcion de visualizacion de lineas
  void display(float scoreLow, float scoreMid, float scoreHi, float volume, float scoreGlobal){
    // Seleccion del color de los cubos
    // Red = scoreLow
    // Green = scoreMid
    // Blue = scoreHi
    // tamaño = volume 
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, scoreGlobal);
    
    // Primera linea, que varia en funcion de la intensidad
    // Hacer desaparecer las lineas a la distancia
    fill(displayColor, ((scoreGlobal-5)/1000)*(255+(z/25)));
    noStroke();
    
    // Creacion de una matriz de transformacion para ampliaciones y traslaciones
    pushMatrix();
    
    translate(x,y,z); // Desplazamiento
    
    // Aumento de escala en funcion del volumen
    if (volume > 100) volume = 100;
    scale(sizeX*(volume/100), sizeY*(volume/100), 20);
    
    // Creacion de "linea" 
    box(1);
    popMatrix();
    
    // Segunda linea, siempre tiene el mismo tamaño, color menos intenso que la primera
    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));
    
    // Creacion de una matriz de transformacion para ampliaciones
    pushMatrix();

    translate(x, y, z);       // Desplazamiento
    scale(sizeX, sizeY, 10);  // Tamaño fijo
    
    // Creacion de la "Linea"
    box(1);
    popMatrix();
    
    // Reiniciar la posicion si ya no es visible
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = minZ;  
    }
  }
}
