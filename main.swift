//===----------------------------------------------------------------------===//
//
// Analog Write Example
// Swift For Arduino
//
// Created by Paul Shelley on 10/21/25.
// Copyright © 2020 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//

import CoreAVR



// Verified
// Setup for PWM (Analog Write) on PD6 (OC0A, Timer0 Channel A) or pin 6 on the Arduino Uno.
GPIO.pd6.setDataDirection(.output) 
timer0.CompareOutputModeA = .clear
timer0.waveformGenerationMode = .fastPWM
timer0.prescaler = .sixtyFour
timer0.outputCompareRegisterA = 127



// Verified
// Setup for PWM (Analog Write) on PD5 (OC0B, Timer0 Channel B) or pin 5 on the Arduino Uno. 
GPIO.pd5.setDataDirection(.output) 
timer0.CompareOutputModeB = .clear
timer0.waveformGenerationMode = .fastPWM
timer0.prescaler = .sixtyFour
timer0.outputCompareRegisterB = 127



// Verified
// Setup for PWM (Analog Write) on PB1 (OC1A, Timer1 Channel A) or pin 9 on the Arduino Uno.
GPIO.pb1.setDataDirection(.output) 
timer1.CompareOutputModeA = .clear
timer1.waveformGenerationMode = .fastPWM8Bit
timer1.prescaler = .sixtyFour
timer1.outputCompareRegisterA = 127



// Verified
// Setup for PWM (Analog Write) on PB2 (OC1B, Timer1 Channel B) or pin 10 on the Arduino Uno.
GPIO.pb2.setDataDirection(.output) 
timer1.CompareOutputModeB = .clear
timer1.waveformGenerationMode = .fastPWM8Bit
timer1.prescaler = .sixtyFour
timer1.outputCompareRegisterB = 127



// Verified
// Setup for PWM (Analog Write) on PB3 (OC2A, Timer2 Channel A) or pin 11 on the Arduino Uno.
GPIO.pb3.setDataDirection(.output) 
timer2.CompareOutputModeA = .clear
timer2.waveformGenerationMode = .fastPWM
timer2.prescaler = .sixtyFour
timer2.outputCompareRegisterA = 127



// Setup for PWM (Analog Write) on PD3 (OC2B, Timer2 Channel B) or pin 3 on the Arduino Uno.
GPIO.pd3.setDataDirection(.output) 
timer2.CompareOutputModeB = .clear
timer2.waveformGenerationMode = .fastPWM
timer2.prescaler = .sixtyFour
timer2.outputCompareRegisterB = 127

//DDRD |= (1 << PD3);                  // Set PD3 as output
//TCCR2A = (1 << COM2B1) | (1 << WGM21) | (1 << WGM20);  // Fast PWM, non-inverting on OC2B
//TCCR2B = (1 << CS21) | (1 << CS20);  // Prescaler 64, start timer
//OCR2B = 127;                         // 50% duty cycle (0-255 range)





while(true) {
    
}



