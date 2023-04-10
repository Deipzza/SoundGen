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
    
    // Rotacion inicial
    rotX = 0.1;
    rotY = 0.1;
    rotZ = 0.1;
  }
  
  // Funcion para mostrar los cubos
  void display(float scoreLow, float scoreMid, float scoreHi, float intensity, float scoreGlobal){
    // Aumentar la intensidad hasta un maximo para disminuir la transparencia de los cubos
    intensity = intensity * 3;
    if (intensity > 9){
      intensity = 9;
    } 
    
    // Seleccion del color de los cubos
    // Red = scoreLow
    // Green = scoreMid
    // Blue = scoreHi
    // alpha = intensity
    
    // Aplicar el color a los cubos 
    color displayColor = color(scoreLow*8, scoreMid*0.67, scoreHi*0.8, intensity*6);
    fill(displayColor,255);
    
    // Seleccion de la transparencia del borde de los cubos
    color strokeColor = color(255, 150-(20*intensity));
    stroke(strokeColor);
    
    // Seleccion de el grosor del borde de los cubos
    strokeWeight(1 + (scoreGlobal/250));
    
    // Creacion de una matriz de transformacion para hacer rotaciones y ampliaciones
    pushMatrix();
    translate(x, y, z);  // Desplazamiento
    
    // Calcular la rotación en funcion de la intensidad del cubo
    sumRotX += intensity*2*(rotX/100);
    sumRotY += intensity*2*(rotY/100);
    sumRotZ += intensity*2*(rotZ/100);

    rotateX(sumRotX);
    rotateY(sumRotY);
    rotateZ(sumRotZ);
    
    // Creación del cubo, tamaño variable segun la intensidad
    box(100+(intensity/2));
    
    // Aplicación de las transformaciones
    popMatrix();
    
    // Desplazamiento en eje Z en funcion de intensidad y scoreGlobal
    z+= (1+(intensity/5)+(pow((scoreGlobal/150), 2)));
    
    // Reiniciar la posicion si ya no es visible
    if (z >= maxZ) {
      x = random(0, width);
      y = random(0, height);
      z = minZ;
    }
  }
}
