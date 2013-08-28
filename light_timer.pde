/*
light_timer by Steven Morad
Switch off a relay if no activity is found
This will serve to turn off the lights if nobody is home
*/
const int sensor = 2;                             //Infrared movement detector
const int relay = 4;                              //5v to 120v 5amp AC relay

int sensorState = LOW;
int relayState = LOW;
uint32_t previousTime = 0;
uint32_t differenceTime = 0;

uint32_t timerDelay = 40000000;                   //interrupts every 80 million cycles 
                                                  //timer counts every other cycle, processor is 80 MHz, so ~1 interrupt per second
uint32_t powerOffDelay = 5;                       //delay in seconds until relay closes if no movement is detected

void setup(){
  pinMode(sensor, INPUT);
  pinMode(relay, OUTPUT);
  Serial.begin(9600);
  attachCoreTimerService(callback);               //register our interrupt service routine
}

void loop(){ 
  sensorState = digitalRead(sensor);  
  digitalWrite(relay, relayState);
}


uint32_t callback(uint32_t currentTime){
  differenceTime = currentTime - previousTime;
  Serial.print(currentTime);
  Serial.print(" - ");
  Serial.print(previousTime);
  Serial.print(" = ");
  Serial.println(differenceTime);
  if(sensorState)                                    //iff movement detected, update last movement detection time
    previousTime = currentTime;
  if(differenceTime > (timerDelay * powerOffDelay)){ //if last movement is longer than powerOffDelay seconds
    relayState=LOW;                                  //disable light
    Serial.println("Delay exceeded, disable relay");
  }
  else      
    relayState=HIGH;
  return  currentTime + timerDelay;                  //interrupt in timerDelay seconds
}




