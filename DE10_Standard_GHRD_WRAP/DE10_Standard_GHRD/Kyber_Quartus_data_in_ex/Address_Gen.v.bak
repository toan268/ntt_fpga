`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/16/2023 04:45:00 PM
// Design Name: 
// Module Name: addgen
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

module Address_Gen(clk,rst,newloop,mode,ctr_sig,counterx1,counterx2);
    input clk,rst;
    input [1:0] mode;
    input newloop;
    output reg ctr_sig;
    //output reg [7:0] layer;
//    output reg [7:0] counter;
    output reg [9:0] counterx1;
    output reg [8:0] counterx2;
//    output reg [7:0] counter_clk;
    
    
    parameter NTT = 2'b00;
    parameter INTT = 2'b01;
    parameter IN = 2'b10;
    parameter OUT = 2'b11;
    //reg [7:0] counter = 0;
    //reg [7:0] layer = 0;
    //reg [7:0] counter_clk = 0;
    //reg [7:0] counter2 = 0;
     reg [7:0] counter;
     //reg [8:0] counterx1;
     //reg [8:0] counterx2;
     reg [7:0] counter_clk;
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
             counter <= 0;
             counter_clk <= 0;
             ctr_sig <= 0;
             counterx1 <= 0;
             counterx2 <= 0;
        end
        else 
        begin 
//            if (counter == 1)
//            begin 
//                if ((mode == NTT) | (mode == INTT))
//                begin
//                    layer <= layer + 1;
//                end    
//                else
//                begin
//                    layer <= 0;
//                end
//            end
            if (newloop == 1)
            begin
                counter <= 0;
                counter_clk <= 0;
                ctr_sig <= 0;
                counterx2 <= 0;
            end
            else
            begin
                if (counter == 130)
                begin 
                    case (mode)
                        NTT: begin
                                ctr_sig <= 1;
                        end
                        INTT: begin
                                ctr_sig <= 1;
                        end
                    endcase
                end
                else
                begin  
                    counter_clk <= counter_clk + 1;
					if ((mode == NTT) | (mode == INTT))
					begin
						if ((counter_clk > 13) | (counter < 2))  begin 
							counter <= counter + 1;
							counterx1 <= (counter_clk > 13) ? counterx1 + 1: counterx1;
							ctr_sig <= 0;
							counter_clk <= 0;
						end
					end
					else 
					begin 
					    ctr_sig <= 0;
						if ((counter_clk > 2) | (counter < 2))  begin 
							counter <= counter + 1;
							counterx2 <= (counter_clk > 2) ? counterx2 + 1: counterx2;
							//counterx2 <= counterx2 + 1;
							ctr_sig <= 0;
							counter_clk <= 0;
						end
					end
                end
            end
        end
    end
    
endmodule

