`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:09:59 PM
// Design Name: 
// Module Name: butterfly
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

//module butterfly(clk,rst,mode,a,b,w,c,d);
    
//	input clk;
//	input rst;
//	input [31:0] a;
//	input [31:0] b;
//	input [31:0] w;
//	input [1:0] mode; //00: NTT; 01:NTT; 10:Bypass; 11: Idle
////	output reg [31:0] c;
////	output reg [31:0] d;
//	output  [31:0] c;
//	output  [31:0] d;

////	reg [31:0] c_ntt,c_intt,c_bp;
////	reg [31:0] d_ntt,d_intt,d_bp;
//	wire [31:0] c_ntt,c_intt,c_bp;
//	wire  [31:0] d_ntt,d_intt,d_bp;
//	wire [31:0] sum,sub; 
//	wire [63:0] mult;
//	wire [31:0] ba;
//	wire [31:0] mult_a,mult_b,add_a,add_b,sub_a,sub_b;
////	reg [31:0] mult_a,mult_b,add_a,add_b,sub_a,sub_b;
//	wire [31:0] cmux,dmux;

////	always @(*) begin
////		sub_a = a;
////		sub_b = (mode==2'b00)? ba : b;
////		add_a = a;
////		add_b = (mode==2'b00)? ba : b;
////		mult_a = (mode==2'b00)? w : -w;
////		mult_b = (mode==2'b00)? b : sub;
////	end
//	assign sub_a = a;
//	assign sub_b = (mode==2'b00)? ba : b;

//	assign add_a = a;
//	assign add_b = (mode==2'b00)? ba : b;

//	assign mult_a = (mode==2'b00)? w : -w;
//	assign mult_b = (mode==2'b00)? b : sub;
//	MULT iMULT(clk,rst,mult_a,mult_b,mult);
//	barrett ibarrett (clk,rst,mult,ba);
//	BKmodADD  iBKmodADD (clk,rst,add_a,add_b,sum);
//	BKmodSUB  iBKmodSUB (clk,rst,sub_a,sub_b,sub);
////	always @(*) begin
////		c_ntt = sum;
////		d_ntt = sub;
////		c_intt  = sum;
////		d_intt = ba;
////		c_bp = a;
////		d_bp = b;
////	end
	
//	//////////OUTPUT-mux///////////
//	//mode NTT
//	assign c_ntt = sum;
//	assign d_ntt = sub;
//	//////////
//	//mode INTT
//	assign c_intt  = sum;
//	assign d_intt = ba;
//	//mode bypass
//	assign c_bp = a;
//	assign d_bp = b;

//	mux_xx2 imux_xx21 (c_ntt,c_intt,c_bp,32'b0,mode,cmux);
//	mux_xx2 imux_xx22 (d_ntt,d_intt,d_bp,32'b0,mode,dmux);
////always @(posedge clk) begin
////	c <= cmux;
////	d <= dmux;
////end
//	assign c = cmux;
//	assign d = dmux;
//endmodule

module butterfly(clk,mode,a,b,w,c,d);
    
	input clk;
	input [15:0] a;
	input [15:0] b;
	input [15:0] w;
	input [1:0] mode; //00: NTT; 01:NTT; 10:Bypass; 11: Idle
//	output reg [31:0] c;
//	output reg [31:0] d;
	output [15:0] c;
	output [15:0] d;

//	reg [31:0] c_ntt,c_intt,c_bp;
//	reg [31:0] d_ntt,d_intt,d_bp;
	wire [15:0] c_ntt,c_intt,c_bp;
	wire  [15:0] d_ntt,d_intt,d_bp;
	wire [15:0] sum,sub; 
	wire [31:0] mult;
	wire [15:0] ba;
	wire [15:0] mult_a,mult_b,add_a,add_b,sub_a,sub_b;
//	reg [31:0] mult_a,mult_b,add_a,add_b,sub_a,sub_b;
	wire [15:0] cmux,dmux;

//	always @(*) begin
//		sub_a = a;
//		sub_b = (mode==2'b00)? ba : b;
//		add_a = a;
//		add_b = (mode==2'b00)? ba : b;
//		mult_a = (mode==2'b00)? w : -w;
//		mult_b = (mode==2'b00)? b : sub;
//	end
	assign sub_a = a;
	assign sub_b = (mode==2'b00)? ba : b;

	assign add_a = a;
	assign add_b = (mode==2'b00)? ba : b;

	assign mult_a = (mode==2'b00)? w : -w;
	assign mult_b = (mode==2'b00)? b : sub;
//	MULT iMULT(clk,rst,mult_a,mult_b,mult);
	MULT3 iMULT31(clk,mult_a,mult_b,mult);
	barrett ibarrett (clk,mult,ba);
	BKmodADD  iBKmodADD (add_a,add_b,sum);
	BKmodSUB  iBKmodSUB (sub_a,sub_b,sub);
//	always @(*) begin
//		c_ntt = sum;
//		d_ntt = sub;
//		c_intt  = sum;
//		d_intt = ba;
//		c_bp = a;
//		d_bp = b;
//	end
	
	//////////OUTPUT-mux///////////
	//mode NTT
	assign c_ntt = sum;
	assign d_ntt = sub;
	//////////
	//mode INTT
	assign c_intt  = sum;
	assign d_intt = ba;
	//mode bypass
	assign c_bp = a;
	assign d_bp = b;

	mux_xx2 imux_xx21 (c_ntt,c_intt,c_bp,16'b0,mode,cmux);
	mux_xx2 imux_xx22 (d_ntt,d_intt,d_bp,16'b0,mode,dmux);
//always @(posedge clk) begin
//	c <= cmux;
//	d <= dmux;
//end
	
	assign c = cmux;
	assign d = dmux;
endmodule