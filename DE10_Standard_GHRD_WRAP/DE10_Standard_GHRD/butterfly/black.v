`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:15:44 PM
// Design Name: 
// Module Name: black
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


module black (clk,rst,pg, pg0, pgo);
	input clk,rst;
    input [1:0] pg, pg0;
    output  [1:0] pgo;
    
    wire [1:0] pg_w;
    wire [1:0] pg0_w;
    wire [1:0] pgo_w;
    assign pg_w = pg;
    assign pg0_w = pg0;
//	 always @(posedge clk) begin
//		 pgo[1] <= pg[1] & pg0[1];
//		 pgo[0] <= (pg0[0] & pg[1]) | pg[0];
//	 end
    assign pgo_w[1] = pg_w[1] & pg0_w[1];
    assign pgo_w[0] = (pg0_w[0] & pg_w[1]) | pg_w[0];
    assign pgo = pgo_w;
endmodule
