import de.voidplus.dollar.*;
import processing.serial.*;

OneDollar one;
String name;
PVector start, centroid, end;

Serial myPort;
String myString = null;
int lf = 10;    // Linefeed in ASCII
float ax = 0;
float ay = 0;
float dx = 0;
float dy = 0;
float force = 0;
float xPos = 0;
float yPos = 0;

FloatList xPosList;
FloatList yPosList;
FloatList forceList;
int XMAX = 850;
int YMAX = 500;

int counter = 0;
int backgroundColor = 255;
Boolean hiddenText = false;

void setup(){
  size(850, 500);
  
  println(Serial.list());  // prints serial port list
  String portName = Serial.list()[1];  // find the right one from the print port list (see the console output). Your port might not be the first one on the list. 
  myPort = new Serial(this, portName, 115200);  // open the serial port  

  // Lists storing x/y positions and force 
  xPosList = new FloatList();  
  yPosList = new FloatList();
  forceList = new FloatList();

  // Initiate x/y cursor positions
  xPos = width/2;
  yPos = height/2;
  
  background(255);
  
  name = "-";
  start = new PVector();
  centroid = new PVector();
  end = new PVector();
  
  // 1. Create instance of class OneDollar:
  one = new OneDollar(this);
  println(one);                  // Print all settings
  one.setVerbose(true);          // Activate console verbose
  // Settings for OneDollar Recognizer
  one.setMaxTime(1000000).enableMaxTime();
  
  // 2. Add gestures (templates):
  one.learn("Aparecium", new int[] {137,139,135,141,133,144,132,146,130,149,128,151,126,155,123,160,120,166,116,171,112,177,107,183,102,188,100,191,95,195,90,199,86,203,82,206,80,209,75,213,73,213,70,216,67,219,64,221,61,223,60,225,62,226,65,225,67,226,74,226,77,227,85,229,91,230,99,231,108,232,116,233,125,233,134,234,145,233,153,232,160,233,170,234,177,235,179,236,186,237,193,238,198,239,200,237,202,239,204,238,206,234,205,230,202,222,197,216,192,207,186,198,179,189,174,183,170,178,164,171,161,168,154,160,148,155,143,150,138,148,136,148} );
  // TODO: Change Nox from Circle to line down
  one.learn("Nox", new int[] {127,141,124,140,120,139,118,139,116,139,111,140,109,141,104,144,100,147,96,152,93,157,90,163,87,169,85,175,83,181,82,190,82,195,83,200,84,205,88,213,91,216,96,219,103,222,108,224,111,224,120,224,133,223,142,222,152,218,160,214,167,210,173,204,178,198,179,196,182,188,182,177,178,167,170,150,163,138,152,130,143,129,140,131,129,136,126,139} );
  // TODO: Add Lumos for line up
  //one.learn("Lumos", new int[] {});
  //one.learn("rect", new int[] {78,149,78,153,78,157,78,160,79,162,79,164,79,167,79,169,79,173,79,178,79,183,80,189,80,193,80,198,80,202,81,208,81,210,81,216,82,222,82,224,82,227,83,229,83,231,85,230,88,232,90,233,92,232,94,233,99,232,102,233,106,233,109,234,117,235,123,236,126,236,135,237,142,238,145,238,152,238,154,239,165,238,174,237,179,236,186,235,191,235,195,233,197,233,200,233,201,235,201,233,199,231,198,226,198,220,196,207,195,195,195,181,195,173,195,163,194,155,192,145,192,143,192,138,191,135,191,133,191,130,190,128,188,129,186,129,181,132,173,131,162,131,151,132,149,132,138,132,136,132,122,131,120,131,109,130,107,130,90,132,81,133,76,133} );
  //one.learn("x", new int[] {87,142,89,145,91,148,93,151,96,155,98,157,100,160,102,162,106,167,108,169,110,171,115,177,119,183,123,189,127,193,129,196,133,200,137,206,140,209,143,212,146,215,151,220,153,222,155,223,157,225,158,223,157,218,155,211,154,208,152,200,150,189,148,179,147,170,147,158,147,148,147,141,147,136,144,135,142,137,140,139,135,145,131,152,124,163,116,177,108,191,100,206,94,217,91,222,89,225,87,226,87,224} );
  one.learn("Lumos", new int[] {91,185,93,185,95,185,97,185,100,188,102,189,104,190,106,193,108,195,110,198,112,201,114,204,115,207,117,210,118,212,120,214,121,217,122,219,123,222,124,224,126,226,127,229,129,231,130,233,129,231,129,228,129,226,129,224,129,221,129,218,129,212,129,208,130,198,132,189,134,182,137,173,143,164,147,157,151,151,155,144,161,137,165,131,171,122,174,118,176,114,177,112,177,114,175,116,173,118} );
  // 3. Bind templates to methods (callbacks):
  one.on("Aparecium Nox Lumos", "detected");
}

// 4. Implement callbacks:
void detected(String gesture, float percent, int startX, int startY, int centroidX, int centroidY, int endX, int endY){
  name = gesture;
  start.x = startX; start.y = startY;
  centroid.x = centroidX; centroid.y = centroidY;
  end.x = endX; end.y = endY;
  switch(gesture) {
   // Sketch: Draw circle for Nox
   // Nox (darken screen)
   case  "Nox":
     backgroundColor = 0;
     break;
   // Sketch: Draw line up
   // Lumos (brighten screen)
   case "Lumos":
     backgroundColor = 255;
     break;
   // Sketch: Draw triangle
   // Aparecium (display hidden text)
   case "Aparecium":
     hiddenText = true;
     break;
     

  }
  println("Gesture: "+gesture+", "+startX+"/"+startY+", "+centroidX+"/"+centroidY+", "+endX+"/"+endY);
}

void draw(){
  background(backgroundColor);
  // Reading IMU data
  float gain = 5;
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      float[] nums = float(split(myString, ','));
      if (nums.length == 3)
      {
        dx = -nums[0] / 40.0;
        dy = -nums[1] / 40.0;
        force = nums[2];
      }
    }
  }   
  
  xPos = xPos + dx * gain;
  yPos = yPos + dy * gain;  
  
  xPos = checkXBounds(xPos);
  yPos = checkYBounds(yPos);

  if(force > 5){
    one.track(xPos, yPos);
  }
  
  if(hiddenText) {
    fill(#a3beec);
    text("ooooh you found hidden text", width/2, height/2);
  }
  
  fill(255, 255, 0, 100);
  ellipse(xPos, yPos, 30, 30);    // Draw a cursor
  
  one.draw();
}

// 5. Track data:
void mouseDragged(){
  one.track(mouseX, mouseY);
}

float checkXBounds(float x){
  if(x > XMAX){
    return (float)XMAX;
  }
  if(x < 0) {
    return 0;
  }
  return x;
}

float checkYBounds(float y){
  if(y > YMAX){
    return (float)YMAX;
  }
  if(y < 0) {
    return 0;
  }
  return y;
}


void keyPressed() {
  xPosList.clear();
  yPosList.clear();
  forceList.clear();
  xPos = width/2;
  yPos = height/2;
}
