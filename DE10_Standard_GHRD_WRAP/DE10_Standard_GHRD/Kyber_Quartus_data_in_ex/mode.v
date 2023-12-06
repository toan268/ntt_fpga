`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2023 02:27:54 PM
// Design Name: 
// Module Name: mode
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

module mode(clk,mode_in,cal_done,in_done,mode);
    input clk;
    input mode_in;
    input cal_done;
    input in_done;
    output reg [1:0] mode;
    parameter NTT = 2'b00;
    parameter INTT = 2'b01;
    parameter IN = 2'b10;
    parameter OUT = 2'b11;
    always@(posedge clk)
    begin
        if (in_done == 0)
            mode <= IN;
        if (cal_done)
            mode <= OUT;
        if ((in_done) & (cal_done == 0))
            mode <= mode_in ? INTT : NTT;
    end
endmodule
