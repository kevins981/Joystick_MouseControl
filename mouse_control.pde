import java.awt.AWTException;
import java.awt.Robot;
import java.awt.Dimension;
import processing.serial.*;
import java.awt.event.InputEvent;

Serial myPort;
arduMouse myMouse;

public static final short LF = 10;

int posX,posY,btn,click;

void setup(){
   size(200, 200);
   myPort = new Serial(this, Serial.list()[0], 9600);
   myMouse = new arduMouse();
   btn = 0;
  
}

void draw(){
  if (btn != 0){
    myMouse.move(posX,posY);
  }
  
  if (click != 0){
    myMouse.Click();
  }
  
  
}

void serialEvent(Serial p){
  String message = myPort.readStringUntil(LF);
  
  if (message!= null){
    
    String [] data = message.split(",");
    
    
    if (data[0].equals("Data")){
      //println(data[0]+" "+data[1]+" "+data[2]+" "+data[3]+" "+datat[4]);
      if (data.length > 4){
        
        try{
         posX = Integer.parseInt(data[1]);
         posY = Integer.parseInt(data[2]);
         btn = Integer.parseInt(data[3]);
         click = Integer.parseInt(data[4]);
        }
        catch (Throwable t){
          println(".");
          print(message);
        }
         
      }
      
    }
    
  }
  //println(posX+" "+posY+" "+btn);
  
}

class arduMouse{
  Robot myRobot;
  static final short rate = 1;
  int current_X, current_Y;
  
  arduMouse(){ //constructor 
    try{
      myRobot = new Robot();
    }
    catch (AWTException e) {
      e.printStackTrace();
    }
    
    Dimension screen = java.awt.Toolkit.getDefaultToolkit().getScreenSize();
    current_Y = (int)screen.getHeight()/2;
    current_X = (int)screen.getWidth()/2;
    
  }
  
  
  void move(int offsetX, int offsetY){
    myRobot.mouseMove(current_X+(rate*offsetX), current_Y-(rate*offsetY));
    current_X = current_X+(offsetX/4);
    current_Y = current_Y+(offsetY/4);
  }
  
  void Click(){
    myRobot.mousePress( InputEvent.BUTTON1_MASK );
    myRobot.mouseRelease( InputEvent.BUTTON1_MASK );
  }
}