`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:14:51 PM
// Design Name: 
// Module Name: mux_xx2
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

module mux_xx2(a,b,c,d,s,o);
        
    input [1:0] s;
    input [15:0] a,b,c,d;
    output reg [15:0] o;
    
    always @(*) case(s)
        2'b00 : o = a;
        2'b01 : o = b;
        2'b10 : o = c;
        default : o = c;
    endcase
endmodule
