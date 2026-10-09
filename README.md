# SPI-Controller
Designed and implemented an SPI master controller in Verilog HDL supporting 8-bit serial data transmission and reception, configurable clock division, and master–slave communication. Verified functionality through simulation and testbench-based waveform analysis.
# SPI Master Controller in Verilog HDL

## Overview
This project implements an SPI (Serial Peripheral Interface) Master Controller using Verilog HDL for serial communication between digital devices. The controller manages data transmission and reception through the MOSI and MISO signals, generates the SPI clock, and controls slave-device selection using an active-low chip-select signal.

## Features
- 8-bit serial data transmission and reception.
- Configurable clock division for SPI clock generation.
- Master–slave communication using standard SPI interface signals.
- Control signals for transfer initiation and status monitoring.
- Reset support for initializing the controller.
- Simulation-based functional verification using testbenches and waveform analysis.

## Interface Signals
- `clk`: System clock input.
- `rst`: Active-high reset.
- `start`: Initiates a data transfer.
- `tx_data`: 8-bit parallel input data for transmission.
- `rx_data`: 8-bit received data output.
- `sclk`: SPI serial clock output.
- `mosi`: Master Out, Slave In data signal.
- `miso`: Master In, Slave Out data signal.
- `cs_n`: Active-low slave-select signal.
- `busy`: Indicates an ongoing transfer.
- `done`: Indicates transfer completion.

## Working Principle
When the `start` signal is asserted, the controller loads the input data into its transmit register and activates the chip-select signal. It serializes the data onto MOSI while generating the SPI clock according to the configured clock divider. Incoming data is sampled from MISO and assembled into the receive register. Upon completion of the transfer, the controller updates the received data, deactivates chip select, and indicates completion through the status signals.

## Verification
The design is intended for RTL simulation and functional verification using Verilog testbenches. Simulation waveforms can be examined to evaluate clock generation, serial data transfer, chip-select timing, and transfer-status behavior.

## Technologies Used
- Verilog HDL
- RTL Design
- Digital Communication Protocols
- Functional Simulation
- Testbench Development
- Waveform Analysis
