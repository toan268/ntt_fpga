`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/07/2023 08:20:11 PM
// Design Name: 
// Module Name: butb
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


module butb();
    // Inputs
    reg clk = 0;
    reg rst = 1;
    reg [1:0] mode = 0;
    reg [15:0] a,b,w;
    wire [15:0] c,d;
    parameter NTT = 2'b00;
    parameter INTT = 2'b01;
    reg [15:0] ctb [0:255];
    reg [15:0] dtb [0:255];
    butterfly dut(
        .clk(clk),
        .rst(rst),
        .mode(mode),
        .a(a),
        .b(b),
        .w(w),
        .c(c),
        .d(d)
    );
    always #5 clk = ~clk;
    initial begin
        // Reset the DUT
        rst = 1;
        #10;
        rst = 0;
        // Wait a few clock cycles before starting the test
        #10;
        mode = INTT;
        a = 461;
        b = 499;
        w = 847;
        #130;
        ctb[1] = c;
        dtb[1] = d;
        a = 29;
        b = 136;
        w = 884;
        #130;
        ctb[2] = c;
        dtb[2] = d;
        a = 198;
        b = 726;
        w = 9;
        #130;
        ctb[3] = c;
        dtb[3] = d;
        a = 646;
        b = 947;
        w = 124;
        #130;
        ctb[4] = c;
        dtb[4] = d;
        a = 419;
        b = 835;
        w = 60;
        #130;
        ctb[5] = c;
        dtb[5] = d;
        a = 927;
        b = 195;
        w = 248;
        #130;
		  mode = NTT;
        ctb[6] = c;
        dtb[6] = d;
        a = 52;
        b = 25;
        w = 68;
        #130;
        ctb[7] = c;
        dtb[7] = d;
        a = 418;
        b = 92;
        w = 147;
        #130;
        ctb[8] = c;
        dtb[8] = d;
        a = 203;
        b = 608;
        w = 451;
        #130;
        ctb[9] = c;
        dtb[9] = d;
        a = 397;
        b = 89;
        w = 251;
        #130;
        ctb[10] = c;
        dtb[10] = d;
        a = 531;
        b = 438;
        w = 905;
        #130;
		  $finish;
    end
//    initial 
//    begin
//        $writememh("out_c.txt",ctb);
//        $writememh("out_d.txt",dtb);
//        #1300;
//    end
endmodule
