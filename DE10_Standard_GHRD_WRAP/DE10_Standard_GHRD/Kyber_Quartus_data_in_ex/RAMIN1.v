`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:06:09 PM
// Design Name: 
// Module Name: RAM
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


//module RAM(clk,rst,DA1in,DA2in,DB1in,DB2in,A1radd,A2radd,B1radd,B2radd,A1wadd,A2wadd,B1wadd,B2wadd,DA1out,DA2out,DB1out,DB2out,we);
//    parameter WID = 32;
//    parameter AWID = 8;
//    parameter DEP = 1<<AWID;
//    input clk;
//    input rst;
//    input [AWID-1:0] A1radd,A2radd, B1radd, B2radd; //read address
//    input [AWID-1:0] A1wadd, A2wadd, B1wadd, B2wadd; //write address
//    input [WID-1:0] DA1in, DA2in, DB1in, DB2in;// data to RAM
//    output [WID-1:0] DA1out, DA2out, DB1out, DB2out;//data from RAM
//    input we;
    
//    ////////////////////////////////////////////////////////////////////////////////
//// Local logic and instantiation
//    reg [WID-1:0]    mem [DEP-1:0]; 
//    reg [AWID-1:0]   A1radd_reg,B1radd_reg,A2radd_reg,B2radd_reg;
//    reg [WID-1:0]    DA1outnor,DB1outnor,DA2outnor,DB2outnor;
    
//    always@(posedge clk)
//    begin
//        if(we)
//        begin 
//            mem[A1wadd] <= DA1in;
//            mem[B1wadd] <= DB1in;
//            mem[A2wadd] <= DA2in;
//            mem[B2wadd] <= DB2in;
//        end
//        else
//        begin 
//            DA1outnor <= mem[A1radd_reg];
//            DB1outnor <= mem[B1radd_reg];
//            DA2outnor <= mem[A2radd_reg];
//            DB2outnor <= mem[B2radd_reg];
//            A1radd_reg <= A1radd;
//            B1radd_reg <= B1radd;
//            A2radd_reg <= A2radd;
//            B2radd_reg <= B2radd;
//        end
//    end

//        wire sa1,sa2,sa3,sa4; //same address
//        wire [WID-1:0] DAin1,DBin1;
//        wire [WID-1:0] DAin2,DBin2;
        
//        assign sa1 = (A1radd == A1wadd) && we;
//        assign sa2 = (B1radd == B1wadd) && we;
//        assign sa3 = (A2radd == A2wadd) && we;
//        assign sa4 = (B2radd == B2wadd) && we;
        
        
//        assign DA1out = sa1? DA1in : DA1outnor;
//        assign DB1out = sa2? DB1in : DB1outnor;
//        assign DA2out = sa3? DA2in : DA2outnor;
//        assign DB2out = sa4? DB2in : DB2outnor;
    
//endmodule
module RAMIN1(clk,DA1in,DB1in,A1radd,B1radd,DA1out,DB1out,we1,we2);

    input clk;
    input [7:0] A1radd, B1radd; //read address
    input [15:0] DA1in, DB1in;// data to RAM
    output reg [15:0] DA1out, DB1out;//data from RAM
    input we1,we2;
    
    ////////////////////////////////////////////////////////////////////////////////
// Local logic and instantiation
    reg [15:0]    mem [255:0]; 
 
    
    always@(posedge clk)
    begin
        if(we1)
        begin 
            mem[A1radd] <= DA1in;
        end
        else
        begin 
            DA1out <= mem[A1radd];
        end
    end    
    always@(posedge clk)
    begin
        if(we2)
        begin 
            mem[B1radd] <= DB1in;
        end
        else
        begin 
            DB1out <= mem[B1radd];
        end
    end   
endmodule

