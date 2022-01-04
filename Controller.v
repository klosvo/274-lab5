`timescale 1ns / 1ps

module Controller(op, funct, Zero, RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShamtorALUSrc, AorB, ALUOp);

    input [5:0] op, funct;
    input Zero;
    output reg RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, PCSrc, ShamtorALUSrc, AorB;
    output reg [3:0] ALUOp;

////////////////////////////////////            
  always @* begin
    ALUSrc <= 0; RegDst <= 0; RegWrite <= 0; 
    MemRead <= 0; MemWrite <= 0; MemtoReg <= 0; 
    PCSrc <= 0; ShamtorALUSrc <= 0; AorB <= 0;
   //////////////////
    if( (op == 6'b000000) || (op == 6'b011100) ) begin 
   //////////////////
        case(funct)
            6'b100000: begin // add
              if(op == 6'b000000) begin
                ALUOp <= 4'b0000;
                RegDst <= 1; RegWrite <= 1; 
              end
              else if(op == 6'b011100) begin  // clz
                ALUOp <= 4'b1011;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            6'b100010: begin // sub
              if(op == 6'b000000) begin
                ALUOp <= 4'b0001;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            6'b100100: begin // and
              if(op == 6'b000000) begin
                ALUOp <= 4'b0011;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            6'b100101: begin // or
              if(op == 6'b000000) begin
                ALUOp <= 4'b0100;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            6'b101010: begin // slt
              if(op == 6'b000000) begin
                ALUOp <= 4'b0101;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            6'b000000: begin // sll
              if(op == 6'b000000) begin
                ALUOp <= 4'b1000;
                RegDst <= 1; RegWrite <= 1; 
                ShamtorALUSrc <= 1; 
                AorB <= 1;
              end
            end
    
            6'b000010: begin 
              if(op == 6'b000000) begin  // srl
                ALUOp <= 4'b1001;
                RegDst <= 1; RegWrite <= 1; 
                ShamtorALUSrc <= 1; 
                AorB <= 1;
              end
              else if(op == 6'b011100) begin // mul
                ALUOp <= 4'b0010;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
            6'b100001: begin // clo
              if(op == 6'b011100) begin
                ALUOp <= 4'b1010;
                RegDst <= 1; RegWrite <= 1; 
              end
            end
    
            default: begin
            end
        endcase
    end
    else if(op == 6'b001000) begin // addi
        ALUSrc <= 1; 
       // RegDst <= 0;
        ALUOp <= 4'b0000;
        RegWrite <= 1; 
    end
    else if(op == 6'b001101) begin // ori  
        ALUSrc <= 1; 
       // RegDst <= 0;
        ALUOp <= 4'b0100;
        RegWrite <= 1; 
    end
    else if(op == 6'b100011) begin // lw
       // RegDst <= 0; 
        RegWrite <= 1; 
        ALUSrc <= 1;  
        ALUOp <= 4'b0000;
        MemRead <= 1; 
        MemtoReg <= 1; 
    end
    else if(op == 6'b101011) begin // sw
        ALUSrc <= 1;  
        ALUOp <= 4'b0000; 
        MemWrite <= 1;
    end
    else if(op == 6'b000101) begin // bne
        ALUOp <= 4'b0111; 
        if(Zero == 0) begin
            PCSrc <= 1;
        end
        else begin
            PCSrc <= 0;
        end
    end
  end
endmodule