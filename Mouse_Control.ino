const int button = 2;
const int Click = 3;
const int PotenX = 0;
const int PotenY = 1;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(button, INPUT);                                   
  pinMode(Click, INPUT);
  digitalWrite(button, HIGH); // pull up
  digitalWrite(Click, HIGH); // pull up
}

void loop() {
  // put your main code here, to run repeatedly:
//  int x = (512 - analogRead(PotenX))/4;
//  int y = (512 - analogRead(PotenY))/4;
  int x = map (analogRead(PotenX), 0, 1023, -35, 35);
  int y = map (analogRead(PotenY), 0, 1023, -35, 35);
  Serial.print("Data,");
  Serial.print(x,DEC);
  Serial.print(",");
  Serial.print(y,DEC);
  Serial.print(",");

  if (digitalRead(button) == LOW){
    Serial.print("1"); 
  }
  else {
    Serial.print("0"); 
  }
  Serial.print(",");

  if (digitalRead(Click) == LOW){
    Serial.print("1"); 
  }
  else {
    Serial.print("0"); 
  }

  Serial.println(","); 
  delay(50);

}
