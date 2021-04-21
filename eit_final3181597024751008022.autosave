import de.voidplus.dollar.*;
import processing.serial.*;
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
OneDollar one;
String name;

void setup(){
  size(500, 500);
  background(255);
  println(Serial.list());  // prints serial port list
  String portName = Serial.list()[4];  // find the right one from the print port list (see the console output). Your port might not be the first one on the list. 
  myPort = new Serial(this, portName, 115200);  // open the serial port  

  // Lists storing x/y positions and force 
  xPosList = new FloatList();  
  yPosList = new FloatList();
  forceList = new FloatList();

  // Initiate x/y cursor positions
  xPos = width/2;
  yPos = height/2;
  
  name = "-";
  
  // 1. Create instance of class OneDollar:
  one = new OneDollar(this);
  println(one);                  // Print all the settings
  one.setVerbose(true);          // Activate console verbose
  
  // 2. Add gestures (templates):
  one.learn("triangle", new int[] {137,139,135,141,133,144,132,146,130,149,128,151,126,155,123,160,120,166,116,171,112,177,107,183,102,188,100,191,95,195,90,199,86,203,82,206,80,209,75,213,73,213,70,216,67,219,64,221,61,223,60,225,62,226,65,225,67,226,74,226,77,227,85,229,91,230,99,231,108,232,116,233,125,233,134,234,145,233,153,232,160,233,170,234,177,235,179,236,186,237,193,238,198,239,200,237,202,239,204,238,206,234,205,230,202,222,197,216,192,207,186,198,179,189,174,183,170,178,164,171,161,168,154,160,148,155,143,150,138,148,136,148} );
  one.learn("circle", new int[] {127,141,124,140,120,139,118,139,116,139,111,140,109,141,104,144,100,147,96,152,93,157,90,163,87,169,85,175,83,181,82,190,82,195,83,200,84,205,88,213,91,216,96,219,103,222,108,224,111,224,120,224,133,223,142,222,152,218,160,214,167,210,173,204,178,198,179,196,182,188,182,177,178,167,170,150,163,138,152,130,143,129,140,131,129,136,126,139} );
  // one.forget("circle");
  
  // 3. Bind templates to methods (callbacks):
  one.bind("triangle circle", "detected");
  // one.off("circle");
}

// 4. Implement callbacks:
void detected(String gesture, float percent, int startX, int startY, int centroidX, int centroidY, int endX, int endY){
  println("Gesture: "+gesture+", "+startX+"/"+startY+", "+centroidX+"/"+centroidY+", "+endX+"/"+endY);    
  name = gesture;
}

void draw(){
  background(255);
  
  fill(0); noStroke();
  text("Detected gesture: "+name, 30, 40);
  text("Draw anticlockwise a circle or triangle.", 30, height-30);

  // Optional draw:
  one.draw();
  float gain = 5;  // TODO: Set Movement Gain that looks good to you. 
  while (myPort.available() > 0) {
    myString = myPort.readStringUntil(lf);
    if (myString != null) {
      float[] nums = float(split(myString, ','));
      if (nums.length == 3)
      {
        dx = nums[0] / 1023.0;
        dy = -nums[1] / 1023.0;
        // TODO: You may want to set force from nums[] here.
        // nums[2] has the force values
      }
    }
  }   

  xPos = xPos + dx * gain;
  yPos = yPos + dy * gain;  
  
  xPosList.append(xPos);
  yPosList.append(yPos);
  for (int i = 0; i < xPosList.size(); i++)
  {
    one.track(xPosList.get(i), yPosList.get(i));   // Draw points in the list
  }  
}

// 5. Track data:
void mouseDragged(){
  one.track(mouseX, mouseY);
}
