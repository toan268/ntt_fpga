`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:00:41 PM
// Design Name: 
// Module Name: wrap
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

module wrap(clk,rst,start,mode,data_out1,data_out2,data_out3,data_out4,in_done,cal_done,done);
    input clk;
    input rst;
    input start;
    input mode; //0: NTT, 1: INTT
    output [15:0] data_out1,data_out2,data_out3,data_out4;
    output in_done;
    output cal_done;
    output done;
	 
    wire newloop_w;
    wire [1:0] mode_w;
    wire crt_sig_w;
    wire wen_w;
    wire [7:0] Radda1_w;
    wire [7:0] Radda2_w;
    wire [7:0] Raddb1_w;
    wire [7:0] Raddb2_w;
    wire [7:0] TFadd1_w;
    wire [7:0] TFadd2_w;
    wire [15:0] tw1_w;
    wire [15:0] tw2_w;
    wire [15:0] DA1in_w;
    wire [15:0] DA1in_bu;
    wire [15:0] DA2in_w;
    wire [15:0] DA2in_bu;
    wire [15:0] DB1in_w;
    wire [15:0] DB1in_bu;
    wire [15:0] DB2in_w;
    wire [15:0] DB2in_bu;
    wire [15:0] DA1out_w;
    wire [15:0] DA1out_out;
    wire [15:0] DA1out_bu;
    wire [15:0] DA2out_w;
    wire [15:0] DA2out_out;
    wire [15:0] DA2out_bu;
    wire [15:0] DB1out_w;
    wire [15:0] DB1out_out;
    wire [15:0] DB1out_bu;
    wire [15:0] DB2out_w;
    wire [15:0] DB2out_out;
    wire [15:0] DB2out_bu;
    wire [15:0] data_in1;
    wire [15:0] data_in2;
    wire [15:0] data_in3;
    wire [15:0] data_in4;


	ROMIN1 iROMIN11 (
		.clk(clk),
		.address1(Radda1_w),
		.address2(Radda2_w),
		.a(data_in1),
		.b(data_in2)
		);
	
	ROMIN1 iROMIN12 (
		.clk(clk),
		.address1(Raddb1_w),
		.address2(Raddb2_w),
		.a(data_in3),
		.b(data_in4)
		);
		
	 
    Address_Gen iAddress_Gen1 (
		.clk(clk),
		.rst(rst),
		.newloop(newloop_w),
		.mode(mode_w),
		.ctr_sig(crt_sig_w),
		.Radda1(Radda1_w),
		.Radda2(Radda2_w),
		.Raddb1(Raddb1_w),
		.Raddb2(Raddb2_w),
		.TFadd1(TFadd1_w),
		.TFadd2(TFadd2_w)
		);   

	assign DA1in_w = (in_done == 1'b0)? data_in1 : DA1in_bu;
	assign DA2in_w = (in_done == 1'b0)? data_in2 : DA2in_bu;
	assign DB1in_w = (in_done == 1'b0)? data_in3 : DB1in_bu;
	assign DB2in_w = (in_done == 1'b0)? data_in4 : DB2in_bu;
	
	RAM iRAM1 (
			.clk(clk),
			.DA1in(DA1in_w),
			.DA2in(DA2in_w),
			.DB1in(DB1in_w),
			.DB2in(DB2in_w),
			.A1radd(Radda1_w),
			.A2radd(Radda2_w),
			.B1radd(Raddb1_w),
			.B2radd(Raddb2_w),
			.DA1out(DA1out_w),
			.DA2out(DA2out_w),
			.DB1out(DB1out_w),
			.DB2out(DB2out_w),
			.we(wen_w)
			);		
    
    
     control icontrol (
         .clk(clk),
         .rst(rst),
         .start(start),
         .mode_in(mode),
         .crt_sig(crt_sig_w),
         .mode_out(mode_w),
         .newloop(newloop_w),
         .wen(wen_w),
         .done(done),
         .cal_done(cal_done),
         .in_done(in_done)
         );
     
    ROM iROM (
        .clk(clk),
        .address1(TFadd1_w),
        .address2(TFadd2_w),
        .tw1(tw1_w),
        .tw2(tw2_w)
        );
        
    butterfly ibutterfly1 (
        .clk(clk),
        .mode(mode_w),
        .a(DA1out_w),
        .b(DB1out_w),
        .w(tw1_w),
        .c(DA1in_bu),
        .d(DB1in_bu)
        );     
        
    butterfly ibutterfly2 (
        .clk(clk),
        .mode(mode_w),
        .a(DA2out_w),
        .b(DB2out_w),
        .w(tw2_w),
        .c(DA2in_bu),
        .d(DB2in_bu)
        ); 
 
//	assign data_out1 = DA1out_w;
//	assign data_out2 = DA2out_w;
//	assign data_out3 = DB1out_w;
//	assign data_out4 = DB2out_w;
	assign data_out1 = (cal_done == 1) ? DA1out_w : 0;
	assign data_out2 = (cal_done == 1) ? DA2out_w : 0;
	assign data_out3 = (cal_done == 1) ? DB1out_w : 0;
	assign data_out4 = (cal_done == 1) ? DB2out_w : 0;
endmodule

