`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:16:24 PM
// Design Name: 
// Module Name: gray
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
module gray (clk,rst,pg, pg0, pgo);
	input clk,rst;
    input [1:0] pg;
    input pg0;
    output pgo;
    wire [1:0] pg_w;
    wire pg0_w;
    wire pgo_w;
    assign pg_w = pg;
    assign pg0_w = pg0;
    
//	 always @(posedge clk) begin
//		pgo <= (pg0 & pg[1]) | pg[0];
//	 end
    assign pgo_w = (pg0_w & pg_w[1]) | pg_w[0];
    assign pgo = pgo_w;
endmodule
