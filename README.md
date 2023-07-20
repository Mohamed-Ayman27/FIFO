# Verilog FIFO Implementation with 5-bit Address Bus and 8-bit Data Bus

## Description
This project presents a Verilog module for a FIFO (First-In-First-Out) memory structure with a 5-bit address bus and an 8-bit data bus. The FIFO is designed to store and retrieve data in a sequential manner, following the principles of a standard FIFO data structure. The module includes read and write enable signals to control data access, ensuring seamless data transfers.

## Features
- FIFO module designed in Verilog.
- Address bus: 5 bits.
- Data bus: 8 bits.
- Read Enable (RE) and Write Enable (WE) signals for data access control.
- Efficient handling of overflow and underflow conditions.

## Getting Started
### Prerequisites
To simulate the Verilog module, you will need a Verilog simulator (e.g., ModelSim, Icarus Verilog) and a synthesis tool (e.g., Quartus Prime, Vivado) if you plan to implement the design on an FPGA.

### Simulation
1. Clone the repository to your local machine.
2. Open the Verilog module and testbench files in your preferred Verilog simulator.
3. Run the simulation to observe the FIFO behavior under different scenarios.
4. Review the simulation results to verify proper functionality.

### FPGA Implementation (Optional)
1. If you wish to implement the FIFO on an FPGA, ensure you have the necessary FPGA synthesis tool (Quartus Prime or Vivado) installed.
2. Create a new project and import the Verilog module.
3. Follow the synthesis and implementation flow to generate the FPGA configuration file.
4. Program the FPGA with the configuration file and test the functionality on the hardware.

## Notes
- The FIFO module should be compatible with most FPGA boards and can be integrated into larger designs.


