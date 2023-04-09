// Clase para los cubos

class Cube{
  // Posicion minima y maxima de spawn en eje Z
  float minZ = -10000;
  float maxZ = 1000;
  
  // Coordenadas espaciales
  float x, y, z;
  float rotX, rotY, rotZ;
  float sumRotX, sumRotY, sumRotZ;
  
  // Constructor
  Cube() {
    // Posicion inicial aleatoria
    x = random(0, width);
    y = random(0, height);
    z = random(minZ, maxZ);
    
    // Rotacion inicial aleatoria
    /*
    rotX = random(0, 1);
    rotY = random(0, 1);
    rotZ = random(0, 1);

    */
    rotX = 0.1;
    rotY = 0.1;
    rotZ = 0.1;
  }
  
  // Funcion para mostrar los cubos
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal){
    // Seleccion del color de los cubos
    color displayColor = color(scoreLow*0.67, scoreMid*0.67, scoreHi*0.67, intensity*6);
    fill(displayColor,255);
    
    // Seleccion del color del borde de los cubos
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    strokeWeight(1 + (scoreGlobal/250));
    
    // Creacion de una matriz de transformacion para hacer rotaciones y ampliaciones
    pushMatrix(); // pendiente por revisar
    
    // Desplazamiento
    translate(x, y, z);
    
    // Calcular la rotación en funcion de la intensidad del cubo
    sumRotX += intensity*2*(rotX/100);
    sumRotY += intensity*2*(rotY/100);
    sumRotZ += intensity*2*(rotZ/100);
    
    // Aplicacion de la rotacion
    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);
    
    // Creación de la caja, tamaño variable segun la intensidad del cubo
    box(100+(intensity/2));
    
    // Aplicación de la matriz
    popMatrix();
    
    // Desplazamiento en eje Z
    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    // Reiniciar la posicion si ya no es visible
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = minZ;
    }
  }
}
