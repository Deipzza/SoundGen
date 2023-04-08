import netP5.*;
import oscP5.*;

OscP5 oscClient;
NetAddress pureDataAddress;

boolean qSound = false;
boolean wSound = false;
boolean eSound = false;
float x;
float y;
float speed = 4;

void setup() {
  size(400, 400);
  background(0);
  
  x = 20;
  y = height/2;
  
  oscClient = new OscP5(this, 11111);
  pureDataAddress = new NetAddress("localhost", 11112);
}

void draw() {
  background(0);
  circle(x, y, 40);
  
  x += speed;
  
  if( x >= width || x < 0){
    speed *= -1;
    // sendBounceMessage();
    // sendHeightMessage();
  }
}

void sendBounceMessage(){
  OscMessage oscMessage = new OscMessage("/bounce");
  oscClient.send(oscMessage, pureDataAddress);
}

void sendHeightMessage() {
  OscMessage oscMessage = new OscMessage("/height");
  float randomY = random(250, 1200);
  y = map(randomY, 250, 1200, 20, height-20);
  oscMessage.add(randomY);
  oscClient.send(oscMessage, pureDataAddress);
}

void keyReleased() {
  if (key == 'q' || key == 'Q') {
    if(qSound == false) {
      qSound = true;
    } 
    else {
      qSound = false;
    }
    OscMessage keyMessage = new OscMessage("/q");
    keyMessage.add(str(qSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'w' || key == 'W') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/w");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'e' || key == 'E') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/e");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'r' || key == 'R') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/r");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 't' || key == 'T') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/t");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'y' || key == 'Y') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/y");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'u' || key == 'U') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/u");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'i' || key == 'I') {
    if(wSound == false) {
      wSound = true;
    } 
    else {
      wSound = false;
    }
    OscMessage keyMessage = new OscMessage("/i");
    keyMessage.add(str(wSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
}
