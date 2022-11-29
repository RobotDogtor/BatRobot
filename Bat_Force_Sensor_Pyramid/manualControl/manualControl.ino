// manual control for the test pyramid


//include for the motor and adafruit feather board
#include <Servo.h>
#include <Adafruit_LSM6 DS33.h>


Adafruit_LSM6DS33 lsm6ds33; // accelerometer, gyroscope

//initialize a variable
Servo ESC;


// Define variables and constants
// The PinValue changes during the program, this changes the motor speed
// The minimum PinValue is 30 and the maximum pinValue is 180. The incrementation of the pinValue is 10
int PinValue;
const int incr = 10;
const int minVal = 30;
const int maxVal = 180;

//serial input from user
char input;
//what tells you to oputput accel data,false = no accel output over serial
bool accelflag = false;


//defines variables to be used in get event function to recieve data from accelerometer
sensors_event_t accel;
sensors_event_t gyro;
sensors_event_t temp; // just a dummy for the acceleration event caller

//variables for acceleration and gyro
float accel_x, accel_y, accel_z;
float gyro_x, gyro_y, gyro_z;


// define states
int switch4all = 0; // variable to show the status of whole system (control pad button 1 + safety switch)




void setup(void)
{

  Serial.begin(115200); // Baud rate
  while ( !Serial ) delay(10);   // for nrf52840 with native usb
 
  //initialize the sensors
  lsm6ds33.begin_I2C();

  // Attach ESC output to pin 11.
  ESC.attach(11, 1000, 2000); // Attached pin # and the minimum and maximum pulse width duration in microseconds
  ESC.write(0); //initialize ESC to 0 at start

  PinValue = minVal; // Set the PinValue as 30 at the beginning. Lower rotational speed of the motor

  Serial.println("a to start, d to stop, w to increment, s to decrement, q for acceleration");
}

void loop()
{
  // loop while listening for commands
  if (Serial.available())
  {
    input = Serial.read();
    // if a is entered turn on the motor
    if (input == 'a')
    {
      Serial.print("switch4all ON\n");
      switch4all = 1;
    }
    // if d is entered turn off
    if (input == 'd')
    {
      //digitalWrite(ledPin, LOW); // turn off notifying light
      Serial.print ("switch4all OFF\n");
      switch4all = 0;
      PinValue = minVal;
    }
    // if w is entered increment by 10 from 30 to 180
    if (input == 'w' && switch4all == 1) //switch4all determines whether motor is currently on, if not it won't increment or decrement
    {
      PinValue += incr;
      Serial.println(PinValue);
    }
    if (input == 's' && switch4all == 1) {
      if (PinValue > minVal && PinValue <= maxVal)
      {
        PinValue -= incr;
        Serial.println(PinValue);
      }
      else {

      }
    }
    if (input == 'q' && accelflag)
    {
      accelflag = false; //accelflag tells the acceleration part whether to print out or not

    }
    else if (input == 'q' && accelflag == false)
    {
      accelflag = true;
    }
    
  }
  //next statements actually start the motor
  if (switch4all == 1)
  {

    ESC.write(PinValue);
  }
  if (switch4all == 0)
  {
    ESC.write(0);
  }
  if (accelflag == true) //prints out continuously while accelflag is true
  {
    lsm6ds33.getEvent(&accel, &gyro, &temp);
    accel_x = accel.acceleration.x;
    accel_y = accel.acceleration.y;
    accel_z = accel.acceleration.z;
    gyro_x = gyro.gyro.x;
    gyro_y = gyro.gyro.y;
    gyro_z = gyro.gyro.z;

    Serial.print(accel_x);
    Serial.print(" ");
    Serial.print(accel_y);
    Serial.print(" ");
    Serial.print(accel_z);
    Serial.print("\n");
  }
}
