import netP5.*;
import oscP5.*;

OscP5 oscClient;
NetAddress pureDataAddress;

boolean qSound = false;
boolean wSound = false;
boolean eSound = false;
boolean rSound = false;
boolean tSound = false;
boolean ySound = false;
boolean uSound = false;
boolean iSound = false;

void createConnections() {
  oscClient = new OscP5(this, 11111);
  pureDataAddress = new NetAddress("localhost", 11112);
}

void oscEvent(OscMessage oscMessage) {
  if(oscMessage.checkAddrPattern("/q")) {
    receive[0] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/w")) {
    receive[1] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/e")) {
    receive[2] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/r")) {
    receive[3] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/t")) {
    receive[4] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/y")) {
    receive[5] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/u")) {
    receive[6] = int(oscMessage.get(0).floatValue());
  } else if(oscMessage.checkAddrPattern("/i")) {
    receive[7] = int(oscMessage.get(0).floatValue());
  }
    
  // println(receive);
}

void keyReleased() {
  if (key == '1') {
    OscMessage keyMessage = new OscMessage("/one");
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == '2') {
    OscMessage keyMessage = new OscMessage("/two");
    oscClient.send(keyMessage, pureDataAddress);
  }
  
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
    if(eSound == false) {
      eSound = true;
    } 
    else {
      eSound = false;
    }
    OscMessage keyMessage = new OscMessage("/e");
    keyMessage.add(str(eSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'r' || key == 'R') {
    if(rSound == false) {
      rSound = true;
    } 
    else {
      rSound = false;
    }
    OscMessage keyMessage = new OscMessage("/r");
    keyMessage.add(str(rSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 't' || key == 'T') {
    if(tSound == false) {
      tSound = true;
    } 
    else {
      tSound = false;
    }
    OscMessage keyMessage = new OscMessage("/t");
    keyMessage.add(str(tSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'y' || key == 'Y') {
    if(ySound == false) {
      ySound = true;
    } 
    else {
      ySound = false;
    }
    OscMessage keyMessage = new OscMessage("/y");
    keyMessage.add(str(ySound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'u' || key == 'U') {
    if(uSound == false) {
      uSound = true;
    } 
    else {
      uSound = false;
    }
    OscMessage keyMessage = new OscMessage("/u");
    keyMessage.add(str(uSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  if (key == 'i' || key == 'I') {
    if(iSound == false) {
      iSound = true;
    } 
    else {
      iSound = false;
    }
    OscMessage keyMessage = new OscMessage("/i");
    keyMessage.add(str(iSound));
    oscClient.send(keyMessage, pureDataAddress);
  }
  
  //oscClient.send(keyMessage, pureDataAddress);
}
