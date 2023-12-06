`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/03/2023 08:12:42 PM
// Design Name: 
// Module Name: barrett
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


//module barrett(clk,rst,c,r);
//	input clk,rst;
//    input [63:0] c;
//    output reg [31:0] r;
     
//    localparam m = 32'd268697824;
//    localparam q = 32'd8380417;
    
    
//    reg  [31:0] quo;
//	 always @(posedge clk) begin
//		quo <= ((c >> (23 - 2)) * m) >> 30;
//		r <= c - q*quo;
//	end
  
//endmodule 
//module barrett(clk,rst,c,r);
//	input clk,rst;
//    input [63:0] c;
//    output [31:0] r;
//     
//    localparam m = 32'd268697824;
//    localparam q = 32'd8380417;
//    
//    wire  [63:0] c_w;
//    wire  [31:0] quo;
//    wire  [31:0] r_w;
//        assign c_w = c;
//		assign quo = ((c_w >> 21) * m) >> 30;
//		assign r_w = c_w - q*quo;
//		assign r = r_w;
//  
//endmodule 
//
module barrett(clk,rst,c,r);
	input clk,rst;
    input [31:0] c;
    output [15:0] r;
     
    localparam v = 32'd20159;
    localparam q = 32'd3329;
    
    wire  [31:0] c_w;
	 wire  [63:0] t1;
	 wire  [31:0] t2;
	 wire  [31:0] t3;
    wire  [63:0] t4;
    wire  [15:0] r_w;
        
		assign c_w = c;
		MULT6 iMULT62(clk,v,c_w,t1);
		assign t2 = t1 + 33554432;  
		assign t3 = t2 >> 26;
		MULT6 iMULT63(clk,t3,q,t4);
		assign r_w = c_w - t4;
		assign r = r_w;
 
endmodule 