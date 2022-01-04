`timescale 1ns / 1ps

module Datapath(Clk, Rst);
// declare your inputs and output
    input Clk, Rst;
   	wire [31:0] WriteData;

// declare the wires (with appropriate size) you use
    wire RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShamtorALUSrc, AorB;
    wire Zero, Z1;
    wire [31:0] Address, PCResult, PCAddResult, SignExtend, Q_sl, ALUAddResult, ReadData1, ReadData2;
    wire [31:0] Q_aluSrc, A, B, Instruction, ALUResult,  ReadData3;
    wire [3:0] ALUOp;
    wire [4:0] WriteReg;


    (* mark_debug = "true" *) wire [31:0] debug_reg16;
// instantiate your modules here 
// to implement the circuit given in the handout

/////////////////////////////////////////////
// ****************** CPU ******************
/////////////////////////////////////////////
    
    // ProgramCounter(Address, PCResult, Reset, Clk);
    ProgramCounter cpu1(Address, PCResult, Rst, Clk);
    // PCAdder(PCResult, PCAddResult);
    PCAdder cpu2(PCResult, PCAddResult);

   //assign Q_s1 = SignExtend<<2;
    // ALU32Bit(ALUControl, A, B, ALUResult, Zero);
    ALU32Bit cpu4(4'b0000, PCAddResult, SignExtend<<2, ALUAddResult, Z1);
    // Mux2_1(I0, I1, S, Q);
    Mux2_1 cpu5(PCAddResult, ALUAddResult, PCSrc, Address);
    // InstructionMemory(Address, Instruction)
    InstructionMemory a3(PCResult, Instruction);
    
    // Controller(op, funct, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShamtorALUSrc, AorB, ALUOp);  
    Controller c1(Instruction[31:26], Instruction[5:0], Zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShamtorALUSrc, AorB, ALUOp);
    
    //Mux5bit(I0, I1, S, Q);
    Mux5bit m_writereg(Instruction[20:16], Instruction[15:11], RegDst, WriteReg);
    
    // RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
    RegisterFile r(Instruction[25:21], Instruction[20:16], WriteReg, WriteData, RegWrite, Clk, ReadData1, ReadData2, debug_reg16);
    // SignExtension(in, out);
    SignExtension se(Instruction[15:0], SignExtend);   
    // Mux2_1(I0, I1, S, Q);   
    Mux2_1 m_alusrc(ReadData2, SignExtend, ALUSrc, Q_aluSrc);
    // Mux2_1(I0, I1, S, Q); 
    Mux2_1 m_shift(Q_aluSrc, {27'b0, Instruction[10:6]}, ShamtorALUSrc, B);
    // Mux2_1(I0, I1, S, Q); 
    Mux2_1 m_AorB(ReadData1, ReadData2, AorB, A);
    // ALU32Bit(ALUControl, A, B, ALUResult, Zero);
    ALU32Bit alu(ALUOp, A, B, ALUResult, Zero);   
    // DataMemory(Address, WriteData, Clk, MemWrite, MemRead, ReadData); 
    DataMemory dm(ALUResult, ReadData2, Clk, MemWrite, MemRead, ReadData3); 
    // Mux2_1(I0, I1, S, Q);
    Mux2_1 m_writedata(ALUResult, ReadData3, MemtoReg, WriteData);
  
endmodule
