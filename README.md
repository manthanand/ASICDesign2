# ASIC Design 2 - Validation of 128-Bit AES Core

## AES Test Board
This folder contains the KiCAD project files for the board that houses the testbench for the AES Core. It mates with a BASYS 3 ARTIX 7 FPGA Board that is used to stimulate the AES
core with input signals. The following is a list of the pins and what they connect to on the FPGA:
| BASYS 3 Board Pin | AES Core PIN | 
|-------------------|--------------|
|        JB1        |      CLK     |
|        JB2        |      SE      |
|        JB3        |      EN      |
|        JB4        |     KRDY     |
|        JB7        |      SI      |
|        JB8        |     SCLK     |
|        JB9        |      SU      |
|        JB10       |     RSTN     |
|        JC7        |     DRDY     |
|        JC8        |      SO      |
|        JC9        |      BSY     |

`AES Board J3`: The following pin is used to bypass the LDO output to allow for testing with different operating voltages. If jumpered, it will use the LDO output. In order to 
replace with a power supply, remove the jumper, place `V+` of the PSU on the bottom pin and `V-` of the PSU on the `VSS1` testpoint.

## AES Test & Emulation

This folder contains the Vivado project with the testbench and emulation project files. The project is structured such that both modules are in the same project, but one can 
be set as the top module and compiled into a bitstream. That way the same project can be used for both purposes. However, since the emulation did not work when separated onto 
2 boards, this project has now been centered around just the FPGA stimuli into the PCB.

## Scripts

During the course of our debugging, we realized that the scan chains within our core were reordered before tapeout. This meant that we had to parse through the final PNR Signoff
from last semester and recreate the verilog that we emulated this semester to accurately test our scan chain. This folder houses the scripts to automatically generate the verilog
that is necessary to reorder the scan chains for sending data in and out of the core.
