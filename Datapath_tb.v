`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2020 07:22:04 PM
// Design Name: 
// Module Name: Datapath_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Datapath_tb();
    reg Clk, Rst;
    //wire [31:0] WriteData;
    //integer i;
    
    Datapath a1(Clk, Rst);
    
    always begin
        Clk <= 0;
        #100;
        Clk <= 1;
        #100;
    end
    
    initial begin
        Rst <= 1; 
        @ (posedge Clk);
        #100 Rst <= 0;
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        @ (posedge Clk);
        //for(i = 0; i < 50; i = i+1) begin
            @ (posedge Clk);
        //end
    end
endmodule
