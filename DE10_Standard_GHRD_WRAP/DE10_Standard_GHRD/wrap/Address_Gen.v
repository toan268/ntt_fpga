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

module Address_Gen(clk,rst,newloop,mode,ctr_sig,Radda1,Radda2,Raddb1,Raddb2,TFadd1,TFadd2);
    input clk,rst;
    input [1:0] mode;
    input newloop;
    output reg ctr_sig;
    output reg [7:0] Radda1,Radda2,Raddb1,Raddb2;
    output reg [7:0] TFadd1,TFadd2;
    //output reg [7:0] layer;
    //output reg [7:0] counter;
    //output reg [7:0] counter_clk;
    
    parameter NTT = 2'b00;
    parameter INTT = 2'b01;
    parameter IN = 2'b10;
    parameter OUT = 2'b11;
    reg [7:0] counter = 0;
    reg [7:0] layer = 0;
    reg [7:0] k = 0;
    reg [7:0] count = 0;
    reg [7:0] TFadd1r = 0;
    reg [7:0] TFadd2r = 0;
    reg [7:0] counter_clk = 0;
    reg [7:0] counter2 = 0;
    
    always @(posedge clk or posedge rst)
    begin
        if (rst)
        begin
             counter <= 0;
             counter_clk <= 0;
             counter2 <= 0;
             layer <= 0;
             k <= 0;
             count <= 0;
             ctr_sig <= 0;
             TFadd1r <= 0;
             TFadd2r <= 0;
             Radda1 <= 0;
             Radda2 <= 0;
             Raddb1 <= 0;
             Raddb2 <= 0;
             TFadd1 <= 0;
             TFadd2 <= 0;
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
                k <= 0;
                counter <= 0;
                counter_clk <= 0;
                count <= 0;
                ctr_sig <= 0;
                Radda1 <= 0;
                Radda2 <= 0;
                Raddb1 <= 0;
                Raddb2 <= 0;
                counter2 <= 0;
                if ((mode == NTT) | (mode == INTT))
                begin
                    if (layer == 0)
                    begin
                        layer <= layer + 1;
                    end
                    else
                    begin
                        counter2 <= counter2 + 1;
                        if (counter2 == 2) 
                        begin
                            layer <= layer + 1;
                            counter2 <= 0;
                        end
                    end
                end
                else
                begin
                    layer <= 0;
                end
            end
            else
            begin
                if (counter == 66)
                begin 
                    case (mode)
                        NTT: begin
                            if (layer == 1)
                            begin
                                TFadd1r <= 2;
                                TFadd2r <= 2;
                                ctr_sig <= 1;
                            end
                            else if (layer == 0)
                            begin
                                ctr_sig <= 0;
                            end
                            else
                            begin
                                ctr_sig <= 1;
                                TFadd1r <= TFadd1 + 1;
                                TFadd2r <= TFadd2 + 1;
                            end
                        end
                        INTT: begin
								if (layer == 1)
                            begin
                                TFadd1r <= 63;
                                TFadd2r <= 63;
                                ctr_sig <= 1;
                            end
                            else
                            begin 
                                ctr_sig <= 1;
                                TFadd1r <= TFadd1 - 1;
                                TFadd2r <= TFadd2 - 1;
                            end
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
							ctr_sig <= 0;
							counter_clk <= 0;
							case (mode)
							NTT: begin
								if ((layer == 1) & (counter != 0)) begin
									Radda1 <= counter - 1;
									Radda2 <= counter - 1 + 64;
									Raddb1 <= counter - 1 + 128;
									Raddb2 <= counter - 1 + 64 + 128;
									
									
									
									TFadd1 <= 1;
									TFadd2 <= 1;  
								end
								
								if ((layer == 2) & (counter != 0)) begin 
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 32;
									Raddb1 <= counter + k - 1 + 64;
									Raddb2 <= counter + k - 1 + 32 + 64;
								
									if (count < 31)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r + 1;
											TFadd2r <= TFadd2r + 1;
										end
										k <= k + 96;
									end
								end
								
								if ((layer == 3) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 16;
									Raddb1 <= counter + k - 1 + 32;
									Raddb2 <= counter + k - 1 + 16 + 32;
									
									if (count < 15)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else 
									begin 
										count <= 0;
										k <= k + 48;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r + 1;
											TFadd2r <= TFadd2r + 1;
										end
									end
								end
								
								if ((layer == 4) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 8;
									Raddb1 <= counter + k - 1 + 16;
									Raddb2 <= counter + k - 1 + 8 + 16;
									
									if (count < 7)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r + 1;
											TFadd2r <= TFadd2r + 1;
										end
										k <= k + 24;
									end
								end
								
								if ((layer == 5) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 4;
									Raddb1 <= counter + k - 1 + 8;
									Raddb2 <= counter + k - 1 + 4 + 8;
								

									if (count < 3)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r + 1;
											TFadd2r <= TFadd2r + 1;
										end
										k <= k + 12;
									end
								end
								
								if ((layer == 6) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 2;
									Raddb1 <= counter + k - 1 + 4;
									Raddb2 <= counter + k - 1 + 2 + 4;
									
									if (count < 1)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r + 1;
											TFadd2r <= TFadd2r + 1;
										end
										k <= k + 6;
									end
								end
								
								if ((layer == 7) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 1;
									Raddb1 <= counter + k - 1 + 2;
									Raddb2 <= counter + k - 1 + 1 + 2;
								
									count <= count + 1;
									TFadd1 <= TFadd1r;
									TFadd2 <= TFadd2r;
									TFadd1r <= TFadd1r + 1;
									TFadd2r <= TFadd2r + 1;
									k <= k + 3;                        
								end
								
								
							end
							
							INTT: begin
								if ((layer == 1) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 1;
									Raddb1 <= counter + k - 1 + 2;
									Raddb2 <= counter + k - 1 + 1 + 2;
									
									if (count < 1)
									begin
										count <= count + 1;
										TFadd1 <= 127;
										TFadd2 <= 127;
										TFadd1r <= 126;
										TFadd2r <= 126;
										k <= k + 3;
									end
									else
									begin 
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										TFadd1r <= TFadd1r - 1;
										TFadd2r <= TFadd2r - 1;
										k <= k + 3;
									end
								end
								if ((layer == 2) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 2;
									Raddb1 <= counter + k - 1 + 4;
									Raddb2 <= counter + k - 1 + 2 + 4;
								

									if (count < 1)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r - 1;
											TFadd2r <= TFadd2r - 1;
										end
										k <= k + 6;
									end
								end
								if ((layer == 3) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 4;
									Raddb1 <= counter + k - 1 + 8;
									Raddb2 <= counter + k - 1 + 4 + 8;
								

									if (count < 3)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r - 1;
											TFadd2r <= TFadd2r - 1;
										end
										k <= k + 12;
									end
								end
								if ((layer == 4) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 8;
									Raddb1 <= counter + k - 1 + 16;
									Raddb2 <= counter + k - 1 + 8 + 16;
							

									if (count < 7)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r - 1;
											TFadd2r <= TFadd2r - 1;
										end
										k <= k + 24;
									end
								end
								if ((layer == 5) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 16;
									Raddb1 <= counter + k - 1 + 32;
									Raddb2 <= counter + k - 1 + 16 + 32;
								

									if (count < 15)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else 
									begin 
										count <= 0;
										k <= k + 48;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r - 1;
											TFadd2r <= TFadd2r - 1;
										end
									end
								end
								if ((layer == 6) & (counter != 0)) begin
									Radda1 <= counter + k - 1;
									Radda2 <= counter + k - 1 + 32;
									Raddb1 <= counter + k - 1 + 64;
									Raddb2 <= counter + k - 1 + 32 + 64;
								
									
									if (count < 31)
									begin
										count <= count + 1;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
									end
									else
									begin 
										count <= 0;
										TFadd1 <= TFadd1r;
										TFadd2 <= TFadd2r;
										if (counter < 64)
										begin
											TFadd1r <= TFadd1r - 1;
											TFadd2r <= TFadd2r - 1;
										end
										k <= k + 96;
									end
								end
								if ((layer == 7) & (counter != 0)) begin
									Radda1 <= counter - 1;
									Radda2 <= counter - 1 + 64;
									Raddb1 <= counter - 1 + 128;
									Raddb2 <= counter - 1 + 64 + 128;
								
									
									TFadd1 <= TFadd1r;
									TFadd2 <= TFadd2r;
								end
							end
							endcase
						end
					end
					else 
					begin 
					    ctr_sig <= 0;
						if ((counter_clk > 2) | (counter < 2))  begin 
							counter <= counter + 1;
							ctr_sig <= 0;
							counter_clk <= 0;
							if (counter != 0) begin
								Radda1 <= counter + k - 1;
								Radda2 <= counter + k - 1 + 1;
								Raddb1 <= counter + k - 1 + 2;
								Raddb2 <= counter + k - 1 + 2 + 1;
							
								if (count < 1)
								begin
									count <= count + 1;
									TFadd1 <= 0;
									TFadd2 <= 0;
									k <= k + 3;
								end
								else
								begin 
									count <= count + 1;
									TFadd1 <= 0;
									TFadd2 <= 0;
									k <= k + 3;
								end
								if (counter > 64)
                                begin
                                    ctr_sig <= 0;
                                end
							end
						end
					end
                end
            end
        end
    end
endmodule

