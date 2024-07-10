//===----------------------------------------------------------------------===//
//
// HAL.swift4a
// Swift For Arduino
//
// Created by Paul Shelley on 11/23/20.
// Copyright © 2020 Paul Shelley. All rights reserved.
//
//===----------------------------------------------------------------------===//



/// Setup for UART Transmitting 
uart0.baudRate = 57600
uart0.transmitterEnable = .on

/// Probably needed for UART Receiving 
uart0.receiverEnable = .on
uart0.rxCompleteInterruptEnable = .on
uart0.dataRegisterEmptyInterruptEnable = .on


// Setup for recieve()
//setupSerial(baudRate: 57600)
//activateRxInterruptHandler()



//SPI0.setup()




/// NOTE: 
/// synchronous analog read functions
/// Read the value of one of the 6 analog pins. The voltage will be from 0-1023
/// and will be by comparison to the voltage at AREF.  Note this read will both
/// block until complete and will activate the ADC if not active. If this is the
/// first reading after power on or sleep and the ADC is being activated, you
/// may need to take a few readings to stabilise.

//func startupAdc() {
//    AnalogeDigitalConverter.voltageReferenceSelection = .AVccWithExternalCapacitorAtAnalogReferencePin
//    AnalogeDigitalConverter.prescalerSelectBits = .Factor128
//    AnalogeDigitalConverter.enableADC = true
//
//    delayMilliSeconds(ms: 1000)
//}

//startupAdc(
//var stuff: UInt = 0
//var thing: Bool = false

import CoreAVR

// Setup for blink()
//GPIO.pb5.setDataDirection(.output)



configureSingleConversion(referenceVoltage: .AVccWithExternalCapacitorAtAnalogReferencePin, prescaler: .Factor128)

while(true) {
//    GPIO.pb5.setValue(.high)
//    waitOneSecond()
//    GPIO.pb5.setValue(.low)
    waitOneSecond()
    
//    uart0.write("Hello World\n") // Used to make sure UART is working
    
    // Uncomment to test UInt8 
//    uart0.write(0)
//    uart0.write("\n")
//    let int = analogRead(pin: 4)
    let number = analogRead(on: .ADC0)
    uart0.write(number)
    uart0.write("\n")

    // In HAL (https://github.com/swiftforarduino/HAL) navigate to Module/HAL.swift 
    // Update name of "writeUInt8()" to "write()" 
    // Rebuild HAL in S4A
    // Rebuild ReflowOven (HAL-Testing) 
    // Program size balloons in size and fails to function.
    
//    uart0.writeUInt16v1(564)
//    uart0.write("\n")
}






//int analogRead(uint8_t pin) {
//
//
//
//#if defined(ADCSRB) && defined(MUX5) // Should be true
//	// the MUX5 bit of ADCSRB selects whether we're reading from channels
//	// 0 to 7 (MUX5 low) or 8 to 15 (MUX5 high).
//	ADCSRB = (ADCSRB & ~(1 << MUX5)) | (((pin >> 3) & 0x01) << MUX5); // Pulling the MUX5 bit and OR this with the pin number? Not fully understanding what they are doing here. 
//AnalogeDigitalConverter.ControlAndStatusRegisterB = 
//#endif
//  
//	// set the analog reference (high two bits of ADMUX) and select the
//	// channel (low 4 bits).  this also sets ADLAR (left-adjust result)
//	// to 0 (the default).
//#if defined(ADMUX)
//#if defined(__AVR_ATtiny25__) || defined(__AVR_ATtiny45__) || defined(__AVR_ATtiny85__)
//	ADMUX = (analog_reference << 4) | (pin & 0x07);
//#else
//	ADMUX = (analog_reference << 6) | (pin & 0x07);
//#endif
//#endif
//
//	// without a delay, we seem to read from the wrong channel
//	//delay(1);
//
//#if defined(ADCSRA) && defined(ADC)
//	// start the conversion
//	sbi(ADCSRA, ADSC);
//
//	// ADSC is cleared when the conversion finishes
//	while (bit_is_set(ADCSRA, ADSC));
//
//	// ADC macro takes care of reading ADC register.
//	// avr-gcc implements the proper reading order: ADCL is read first.
//	return ADC;
//#else
//	// we dont have an ADC, return 0
//	return 0;
//#endif
//}



func configureSingleConversion(referenceVoltage: ADC.VoltageReferenceSelection, prescaler: ADC.PrescalerSelectBits) {
    // Self.`adcsra`.`adate` = .init(bitfieldValue: false)
    AnalogeDigitalConverter.autoTriggerEnable = false

    // Self.referenceVoltage = referenceVoltage
    AnalogeDigitalConverter.voltageReferenceSelection = referenceVoltage
    
    // Self.prescaler = prescaler
    AnalogeDigitalConverter.prescalerSelectBits = prescaler
}


//var value: UInt16 {
//    get {
//      Adc.startConversion(on: channel)
//      while !Adc.conversionComplete {}
//      return Adc.data
//    }
//}
func analogRead(on channel: ADC.AnalogChannelSelectionBits) -> UInt16 {
    //    Self.`admux`.`mux` = .init(bitfieldValue: channel.bitfieldValue)
    AnalogeDigitalConverter.analogChannelSelectionBits = channel
    
//    Self.enabled = true
    AnalogeDigitalConverter.enableADC = true
    
//    Self.`adcsra`.`adsc` = .init(bitfieldValue: true)
    AnalogeDigitalConverter.startConversion()
    
    while AnalogeDigitalConverter.conversionRunning { }
    return AnalogeDigitalConverter.DataRegister
}




//func startConversion(on channel: ADC.AnalogChannelSelectionBits) {
////    Self.`admux`.`mux` = .init(bitfieldValue: channel.bitfieldValue)
//    AnalogeDigitalConverter.analogChannelSelectionBits = channel
//    
////    Self.enabled = true
//    AnalogeDigitalConverter.enableADC = true
//    
////    Self.`adcsra`.`adsc` = .init(bitfieldValue: true)
//    AnalogeDigitalConverter.startConversion()
//}


// I think there should be a configuration step required before running the ADC because there are different physical ways to setup the AREF source with a capacitor or what not. I dont think this should change as it's more of a definition of how the hardware is connected to AREF so that the software can act approperatly. 

// This should only accept GPIO pins or better only accept Analog Pins that are defined in other parts of the code. 
//func analogRead(pin: UInt8) -> UInt16 {
//    
//    if(pin>7){ // This should not be needed if we have a way to only pass in valid values.
//        return 0
//    }
//    
//    // Note: The Power Reduction ADC bit, PRADC, in ”Minimizing Power Consumption” on page 51  Consump
//    // must be disabled by writing a logical zero to be able to use the ADC into use the ADC input MUX.
//    // 
//    // Should this be included in the ADC Setup function? Would it need to be called afterput MUX.
//    // 
//    // Should this be includp function? Would it need to be called after leaving low power mode? 
////    if(!adcStarded()) {
////        startupAdc()
////    }
//    
//    // The `pin & 7 seems be a bitmask opperation, maybe to protect against invalid values? 
//    // Probably not the best approach because it could result in unexpected behaviour. Also 
//    // if you already filtered out anything larger than 7 then this should not be necessary. 
//    AnalogeDigitalConverter.MultiplexerSelectionRegister = (pin & 7)     
//    
//    
//    AnalogeDigitalConverter.startConversion()
//    //AnalogeDigitalConverter.ControlAndStatusRegisterA |= 1 << UInt8(AnalogeDigitalConverter.startConversion);
//    
//    while(AnalogeDigitalConverter.conversionRunning){}
//    
//    return AnalogeDigitalConverter.DataRegister
//}

