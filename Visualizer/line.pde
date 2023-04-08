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
    // Determinar posicion
    this.x = x;
    this.y = y;
    
    // Pofundidad aleatoria
    this.z = random(minZ, maxZ);
    
    // Determinar tamaño
    this.sizeX = sizeX;
    this.sizeY = sizeY;
  }
  
  // Funcion de visualizacion de lineas
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal){
    // Color determinado por las notas (bajas, medias y altas) y opacidad determinada por el volumen global
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, scoreGlobal);
    
    // Primera linea, que varia en funcion de la intensidad
    // Hacer desaparecer las lineas a la distancia
    fill(displayColor, ((scoreGlobal-5)/1000)*(255+(z/25)));
    noStroke();
    
    pushMatrix();
    
    // Desplazamiento
    translate(x,y,z);
    
    // Aumento
    if (intensity > 100) intensity = 100;
    scale(sizeX*(intensity/100), sizeY*(intensity/100), 20);
    
    // Creacion de la caja
    box(1);
    popMatrix();
    
    // Segunda linea, siempre tiene el mismo tamaño
    displayColor = color(scoreLow*0.5, scoreMid*0.5, scoreHi*0.5, scoreGlobal);
    fill(displayColor, (scoreGlobal/5000)*(255+(z/25)));
    //Matrice de transformation
    pushMatrix();
    
    // Desplazamiento
    translate(x, y, z);
    
    // Aumento
    scale(sizeX, sizeY, 10);
    
    // Creacion de la caja
    box(1);
    popMatrix();
    
    // Reiniciar la posicion si ya no es visible
    z+= (pow((scoreGlobal/150), 2));
    if (z >= maxZ) {
      z = minZ;  
    }
  }
}
