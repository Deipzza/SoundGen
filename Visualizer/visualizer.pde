/* Introducción

En este proyecto se utilizan las notas que producen los sonidos en PureData para crear 
una representación visual 

El color se mapea de la siguiente manera para los distintos tonos:
- Rojo: graves
- Verde: medios
- Azul: agudos

Puede resultar cualquier combinacion de colores en el especio RGB si se produce la correcta combinacion
de tonos desde PureData.
*/


// Variables globales
int[] receive = {0, 0, 0, 0, 0, 0, 0, 0}; // Valores numericos de las notas recibidas desde puredata
int[] notes = {0, 0, 0, 0, 0, 0, 0, 0}; // Notas utilizadas para trabajar los elementos del visualizador


// Puntajes de cada uno de los tonos
float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;

float scoreGlobal = 1 * scoreLow + 1 * scoreMid + 1 * scoreHi; // Puntaje global
float intensity = 5; // No se utiliza pero me da miedo borrarla por si se rompe algo

// Puntajes del frame anterior, se utilizan para suavizar el efecto
float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;
float oldScoreGlobal = scoreGlobal;

float scoreDecreaseRate = 10;  // Tasa a la que decrecera el efecto producido por las notas

// Arreglo vacío de cubos y numero de cubos a dibujar
int nbCubes = 100;
Cube[] cubes;

// Arreglo vacío de lineas y numero de lineas a dibujar
int nbLines = 512;
Line[] lines;

// Arreglo vacío de bordes y numero de bordes a dibujar
int nbBorders = 512;

// Setup inicial del proyecto
void setup() {
  fullScreen(P3D); // Trabajaremos en el espacio 3D
  
  cubes = new Cube[nbCubes]; // Creamos las posiciones del arreglo de cubos
  lines = new Line[nbLines]; // Creamos las posiciones del arreglo de lineas

  //Creacion de los objetos
  //Crear los cubos
  for (int i = 0; i < nbCubes; i++) {
    cubes[i] = new Cube(); 
  }
  
  //Crear los lineas
  //Lineas izquierdas
  for (int i = 0; i < nbLines; i+=4) {
    lines[i] = new Line(0, height/2, 10, height); 
  }
  //Lineas derechas
  for (int i = 1; i < nbLines; i+=4) {
    lines[i] = new Line(width, height/2, 10, height); 
  }
  //Lineas inferiores
  for (int i = 2; i < nbLines; i+=4) {
    lines[i] = new Line(width/2, height, width, 10); 
  }
  //Lineas superiores
  for (int i = 3; i < nbLines; i+=4) {
    lines[i] = new Line(width/2, 0, width, 10); 
  }
  
  //Fondo
  background(0);
  
  // OSC
  createConnections();
}

// Función draw
void draw() {
  
  // Cada 12 frames (200ms) se toman los valores numéricos recibidos de PureData
  // y se asignan al arreglo notes.
  // Se deja un rango de 3 frames ya que hay cierto retraso en el envío de los datos.
  // Sospechamos que es debido a que no se pueden ejecutar multiples intrucciones al tiempo
  // y aveces se mandan notas en tiempos iguales.
  int frame = frameCount;
  if (frame % 12 >= 0 && frame % 12 <= 3) {
    for (int j = 0; j < receive.length; j++) {
      notes[j] = receive[j];
      receive[j] = 0;
    }
  }
  
  // Se reinicia el arreglo notes a sus valores iniciales en los siguientes frames
  // luego que las notas hayan sido recibidas y hayan cumplido su funcion
  else{
    for (int j = 0; j < receive.length; j++) {
      notes[j] = 0;
    }
  }
  
  // Guardar los scores actuales para la siguiente iteracion
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  oldScoreGlobal = scoreGlobal;
  
  // Reiniciar el valor de los scores actuales luego de haber guardado su valor
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
  scoreGlobal = 0;
  
  // Calcular los scores nuevos, que dependen de los valores recibidos
  // que se encuentran en el arreglo notes
  for(int i = 0; i < notes.length; i++)
  {
    // notas entre 30 y 40 las consideramos como bajos
    if(notes[i]>30 && notes[i]<=40){
      // El scoreLow será la suma de las notas en el rango multiplicadas por 3
      // Se hace esto para que su efecto sea comparable al de los demás tonos
      // aunque sus valores sean más bajos
      scoreLow += notes[i]*3; 
    }
    // notas entre 41 y 70 las consideramos como medios
    else if(notes[i]>40 && notes[i]<=70){
      // El scoreMid será la suma de las notas en el rango multiplicadas por 2
      scoreMid += notes[i]*2;
    }
    // notas entre 71 t 120 las consideramos como altos
    else if(notes[i]>70 && notes[i]<=120){
      // El scoreHi será la suma de las notas en el rango multiplicadas por 2
      scoreHi += notes[i]*2; 
    }
  }
  // Se calcula scoreGlobal como la suma de los otros scores
  scoreGlobal = 1*scoreLow + 1*scoreMid + 1*scoreHi;
  
  // Para evitar que el efecto visual desaparezca en el siguiente frame (cuando no se reciben notas)
  // se utiliza una tasa de decrecimiento del efecto. En este caso el nuevo score sera 10 puntos menor que 
  // el score del frame inmediatamente anterior
  if (oldScoreLow > scoreLow) {
    scoreLow = oldScoreLow - scoreDecreaseRate;
  }
  
  if (oldScoreMid > scoreMid) {
    scoreMid = oldScoreMid - scoreDecreaseRate;
  }
  
  if (oldScoreHi > scoreHi) {
    scoreHi = oldScoreHi - scoreDecreaseRate;
  }
  
  if (oldScoreGlobal > scoreGlobal) {
    scoreGlobal = oldScoreGlobal - scoreDecreaseRate;
  }
  
  // Sutil cambio de color del fondo dependiendo del puntaje de las notas
  background(scoreLow/80, scoreMid/80, scoreHi/80);
  
  
  // Dibujado de los cubos
  for(int i = 0; i < nbCubes; i++)
  {
    // Cubos que representan los tonos bajos
    if(i%3 == 0){
      // Los scores representarán cada uno de los parámetros de un color en el espacio RGB
      // La intensidad se determina basada en el score del tono respectivo
      int intensity = intensityMap(scoreLow);
      
      cubes[i].display(scoreLow, 0, 0, intensity, scoreGlobal);
    }
    // Cubos que representan los tonos medios
    else if(i%3 == 1){
      int intensity = intensityMap(scoreMid);
      cubes[i].display(0, scoreMid, 0, intensity, scoreGlobal);
    }
    // Cubos que representan los tonos altos
    else{
      int intensity = intensityMap(scoreHi);
      cubes[i].display(0, 0, scoreHi, intensity, scoreGlobal);
    }
  }


  // Bordes
  float dist = -25;   // Distancia entre bordes (negativo porque es eje Z)
  float heightConst = 2; // Constante para variar la altura
  float previousBandValue = 0; // Valor de "amplitud" anterior
  
  for(int i = 1; i < nbBorders; i++){
    // Valor que simula la amplitud de la nota
    float bandValue = 0; 
    
    // Bordes más cercanos a la camara
    if (i < nbBorders/20){
      // Representan la "amplitud" de las notas altas
      bandValue = random(scoreHi/10) * ((512-i)/100);
    }
    // Bordes en la mitad de la camara
    else if(i < 2*nbBorders/20){
      // Representan la "amplitud" de las notas medias
      bandValue = random(scoreMid/10) * ((512-i)/100);
    }
    // Bordes más alejados de la camara
    else{
      // Representan la "amplitud" de las notas bajas
      bandValue = random(scoreLow/10) * ((512-i)/100);
    }
    
    // Seleccion de color para el borde, desaparece con la distancia a la camara
    stroke(50+scoreLow, 50+scoreMid, 50+scoreHi, 255-i);
    // Seleccion de grosor del borde, se hace más grueso a mayor scoreGlobal, aumenta con la distancia a la camara
    strokeWeight(1 + (scoreGlobal/100)*(1 + (i/50)));
    
    // Borde inferior izquierdo
    line(0, height-(previousBandValue*heightConst), dist*(i-1), 0, height-(bandValue*heightConst), dist*i);
    line((previousBandValue*heightConst), height, dist*(i-1), (bandValue*heightConst), height, dist*i);
    line(0, height-(previousBandValue*heightConst), dist*(i-1), (bandValue*heightConst), height, dist*i);
    
    // Borde superior izquierdo
    line(0, (previousBandValue*heightConst), dist*(i-1), 0, (bandValue*heightConst), dist*i);
    line((previousBandValue*heightConst), 0, dist*(i-1), (bandValue*heightConst), 0, dist*i);
    line(0, (previousBandValue*heightConst), dist*(i-1), (bandValue*heightConst), 0, dist*i);
    
    // Borde inferior derecho
    line(width, height-(previousBandValue*heightConst), dist*(i-1), width, height-(bandValue*heightConst), dist*i);
    line(width-(previousBandValue*heightConst), height, dist*(i-1), width-(bandValue*heightConst), height, dist*i);
    line(width, height-(previousBandValue*heightConst), dist*(i-1), width-(bandValue*heightConst), height, dist*i);
    
    // Borde superior derecho
    line(width, (previousBandValue*heightConst), dist*(i-1), width, (bandValue*heightConst), dist*i);
    line(width-(previousBandValue*heightConst), 0, dist*(i-1), width-(bandValue*heightConst), 0, dist*i);
    line(width, (previousBandValue*heightConst), dist*(i-1), width-(bandValue*heightConst), 0, dist*i);
    
    // Asignar valor de la amplitud para la siguiente iteracion
    previousBandValue = bandValue;
  }
  
  // Lineas
  //Lineas izquierdas, que representan los tonos medios
  for (int i = 0; i < nbLines; i+=4) {
    // Los scores representarán cada uno de los parámetros de un color en el espacio RGB
    // El volumen se determina basado en el score del tono respectivo
    int volume = volumeMap(scoreMid);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas derechas, que tambien representan los tonos medios
  for (int i = 1; i < nbLines; i+=4) {
    int volume = volumeMap(scoreMid);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas inferiores, que representan los tonos bajos
  for (int i = 2; i < nbLines; i+=4) {
    int volume = volumeMap(scoreLow);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas superiores, que representan los tonos altos
  for (int i = 3; i < nbLines; i+=4) {
    int volume = volumeMap(scoreHi);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
}


// Funcion utilizada para mapear el volumen a partir de los scores
int volumeMap(float volume){
  int output = int(map(volume, 0, 255, 0, 60));
  return output;
}

// Funcion utilizada para mapear la intensidad a partir de los scores
int intensityMap(float intensity){
  int output = int(map(intensity, 0, 255, 1, 8));
  return output;
}
