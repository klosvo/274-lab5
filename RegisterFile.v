`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Last Edits: Nirmal Kumbhare, Ali Akoglu

// Module - register_file.v
// Description - Implements a register file with 32 32-Bit wide registers.
//               (a 32x32 regsiter file with two read ports and one write port)
// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
// Clk: clock signal

// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// Read: 
// at the "FALLing" edge of the clock signal,
// the content of register file at the address ReadRegister1 will be available 
// on the ReadData1 output
// the content of register file at the address ReadRegister2 will be available 
// on the ReadData2 output
// More details: 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 
// 'ReadData1' and 'ReadData2' are registered outputs (output of register file 
// is written into these registers at the FALLing edge of the clock).
// You can view it as if outputs of registers specified by 
// ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the FALLing edge of the clock. 
// At "RISing" edge of the clock signal, if 'RegWrite' signal is high (logic 1) 
// the data on the "WriteData" input is written into this Register File at 
// the address/location specified by WriteRegister
// More details: during the RISing edge of the clock, set RegWrite to 1 if the input 
// data is to be written into the register file. The content of the register file 
// specified by address 'WriteRegister' is modified at the 
// rising edge of the clock if 'RegWrite' signal is high. 
////////////////////////////////////////////////////////////////////////////////

module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_reg16);

	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;
	output reg [31:0] ReadData1, ReadData2;
	input [31:0] WriteData;

	input Clk, RegWrite;
	integer i;
	output [31:0] debug_reg16;
	
	(* mark_debug = "true" *) reg [31:0] RegFile[0:31];

   initial begin
       for(i=0; i<32; i = i+1) begin
          RegFile[i] <= 32'h0;
       end
   end

   // Read procedure
   always @(negedge Clk) begin
      ReadData1 <= RegFile[ReadRegister1];
      ReadData2 <= RegFile[ReadRegister2];
   end

   // Write procedure
   always @(posedge Clk) begin
      if (RegWrite == 1)
         RegFile[WriteRegister] <= WriteData;
   end
   
   assign debug_reg16 = RegFile[16];
   
endmodule