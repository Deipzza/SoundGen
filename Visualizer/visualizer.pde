int [] notes = {0, 0, 0, 0, 0, 0, 0, 0};
int[] receive = {42, 38, 36, 36, 47, 69, 80, 84};
//int[] receive = {0, 38, 36, 36, 0, 0, 0, 0};
//int[] receive = {42, 47, 69, 0, 0, 0, 0, 0};
//int[] receive = {0, 0, 0, 0, 0, 0, 80, 84};

float scoreLow = 0;
float scoreMid = 0;
float scoreHi = 0;
float intensity = 5;
float scoreGlobal = 1*scoreLow + 1*scoreMid + 1*scoreHi;

float oldScoreLow = scoreLow;
float oldScoreMid = scoreMid;
float oldScoreHi = scoreHi;
float oldScoreGlobal = scoreGlobal;

float scoreDecreaseRate = 10;

// Cubos
int nbCubes = 100;
Cube[] cubes;

// Lineas
int nbLines = 512;
Line[] lines;

// Bordes
int nbBorders = 512;

void setup()
{
  
  // Trabajaremos en el espacio 3D
  fullScreen(P3D);
 
  // Creamos las posiciones del arreglo de cubos
  cubes = new Cube[nbCubes];
  
  // Creamos las posiciones del arreglo de lineas
  lines = new Line[nbLines];

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
}

// E este proyecto el color se representa como
// - Rojo: graves
// - Verde: medios
// - Azul: agudos
// La opacidad esta determinada por la intensidad (volumen)

void draw(){
  println(scoreLow);
  println(scoreMid);
  println(scoreHi);
  println(scoreGlobal);
  println("");
  
  if (frameCount%120 == 0){
    for (int j = 0; j < receive.length; j++){
      notes[j] = receive[j];
    }
  }
  
  else{
    for (int j = 0; j < receive.length; j++){
      notes[j] = 0;
    }
  }
  
  // Guardar los scores anteriores
  oldScoreLow = scoreLow;
  oldScoreMid = scoreMid;
  oldScoreHi = scoreHi;
  oldScoreGlobal = scoreGlobal;
  
  // Reiniciar los valores
  scoreLow = 0;
  scoreMid = 0;
  scoreHi = 0;
  scoreGlobal = 0;
  
  // Calcular los scores nuevos
  for(int i = 0; i < notes.length; i++)
  {
    if(notes[i]>30 && notes[i]<=40){
       scoreLow += notes[i]*3;
    }
    else if(notes[i]>40 && notes[i]<=70){
       scoreMid += notes[i]*2;
    }
    else if(notes[i]>70 && notes[i]<=120){
       scoreHi += notes[i]*2; 
    }
  }
  scoreGlobal = 1*scoreLow + 1*scoreMid + 1*scoreHi;
  
  // Velocidad de descenso de los scores
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
  
  // --------------------------------------------------------------------
  
  // Cubos
  
  for(int i = 0; i < nbCubes; i++)
  {
    // Cubos para Lows
    if(i%3 == 0){
      int intensity = intensityMap(scoreLow);
      cubes[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
    }
    // Cubos para Mids
    else if(i%3 == 1){
      int intensity = intensityMap(scoreMid);
      cubes[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
    }
    // Cubos para Highs
    else{
      int intensity = intensityMap(scoreHi);
      cubes[i].display(scoreLow, scoreMid, scoreHi, intensity, scoreGlobal);
    }
  }


  // Bordes
  float dist = -25;   // Distancia entre bordes (negativo porque es eje Z)
  float heightConst = 2; // Constante para variar la altura
  float previousBandValue = 0; // Valor de frecuencia anterior
  
  for(int i = 1; i < nbBorders; i++){
    // Valor de la banda de frecuencia
    //float bandValue = random(0, 45);
    //float bandValue = random((512-i)/10);
    
    float bandValue = 0;
    
    if (i < nbBorders/20){
      bandValue = random(scoreHi/10) * ((512-i)/100);
    }
    else if(i < 2*nbBorders/20){
      bandValue = random(scoreMid/10) * ((512-i)/100);
    }
    else{
      bandValue = random(scoreLow/10) * ((512-i)/100);
    }
    
    // Seleccion de color para el borde
    stroke(50+scoreLow, 50+scoreMid, 50+scoreHi, 255-i);
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
    
    previousBandValue = bandValue;
  }
  
  // Lineas
  //Lineas izquierdas (Mid)
  for (int i = 0; i < nbLines; i+=4) {
    int volume = volumeMap(scoreMid);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas derechas (Mid)
  for (int i = 1; i < nbLines; i+=4) {
    int volume = volumeMap(scoreMid);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas inferiores (Low)
  for (int i = 2; i < nbLines; i+=4) {
    int volume = volumeMap(scoreLow);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
  
  //Lineas superiores (High)
  for (int i = 3; i < nbLines; i+=4) {
    int volume = volumeMap(scoreHi);
    lines[i].display(scoreLow, scoreMid, scoreHi, volume, scoreGlobal);
  }
}

int volumeMap(float volume){
  int output = int(map(volume, 0, 255, 0, 60));
  return output;
}

int intensityMap(float intensity){
  int output = int(map(intensity, 0, 255, 1, 8));
  return output;
}
