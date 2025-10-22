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



// Setup for Analog Write on PB3 or pin 11 on the Arduino Uno.
GPIO.pb3.setDataDirection(.output) 
timer2.CompareOutputModeA = .clear
timer2.waveformGenerationMode = .fastPWM
timer2.prescaler = .sixtyFour
timer2.outputCompareRegisterA = 128


while(true) {
    
}



