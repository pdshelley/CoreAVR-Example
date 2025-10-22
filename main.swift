//===----------------------------------------------------------------------===//
//
// Interrupts Example
// Swift For Arduino
//
// Created by Brent Van den Abbeel on 2025-10-22.
// Copyright © 2025 Swift for Arduino. All rights reserved.
//
//===----------------------------------------------------------------------===//

import CoreAVR

// This example shows the basic process for enabling Interrupts on the ATmega328P, and how to hook into them.
// Interrupts are really powerful tools, and should be yielded with care.
// Always try to do as little work as possible whilst in an interrupt routine.

// Good Interrupts use-case:
// - Setting a flag of some kind (e.g. some IO task has completed and the result is available)

// Bad Interrupts use-case:
// - Performing a task that takes some time to complete (e.g. writing something to UART0)

// ------------ CODE ------------ //
// Enable UART
uart0.baudRate = 57600
uart0.transmitterEnable = .on

// Sets PB5 (Pin 13) as an output pin, allowing to connect an external LED to it.
GPIO.pb5.setDataDirection(.output)

// Make sure UART is working correctly
uart0.write("Hello, World!\n")

// A function with the '@interruptHandler' attribute, along with `@_silgen_name("__vector_x")` will be compiled and linked as interrupt routines.
// `__vector_1` is INT0, or External Interrupt Request 0 on the ATmega328P, which is Pin 2 on the Arduino UNO.
// For other interrupts you might be interested in, check out the ATmega328P datasheet, section 12.4 - Innterrupt Vectors.
@interruptHandler
@_silgen_name("__vector_1")
func externalInterrupt0() {
    if GPIO.pb5.value() == .high {
        GPIO.pb5.setValue(.low)
    } else {
        GPIO.pb5.setValue(.high)
    }
}

// When enabling interrupts, always disable UART Interrupts first! If you don't, your program will crash, and the chip will reboot the moment you try to write anything to UART.
InterruptHandler.disableUARTInterrupts()
Interrupts.externalInterruptRequest0Enable = true // Because INT0 is an external interrupt, we have to explicitly enable it.
Interrupts.interruptSenseControl0 = .logical // Trigger the Interrupt when the logic level of pb2 changes
Interrupts.enableInterrupts() // This enables Interrupts globally, allowing INT0 to actually fire, and `externalInterrupt0` to be called.

while mainLoopRunning {} // We do nothing in our main loop.
