`timescale 1ns / 1ps 

////////////////////////////////////////////////////////////////////////////////// 

// Company:  

// Engineer:  

//  

// Create Date: 09/15/2023 04:17:28 PM 

// Design Name:  

// Module Name: wrap_tb 

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

  

module Wrap_tb; 

  

    reg clk = 0; 

    reg rst = 0; 
	 
	 reg start = 1;
	 
	 reg mode = 0; 

    wire [15:0] data_out1;
	 
	 wire [15:0] data_out2;
	 
	 wire [15:0] data_out3;
	 
	 wire [15:0] data_out4;
	 
	 wire in_done;
	 
	 wire cal_done;
	 
	 wire done;
	 


  // Instantiate the wrap module 
	
	wrap dut (
		.clk(clk),
		.rst(rst),
		.start(start),
		.mode(mode),
		.data_out1(data_out1),
		.data_out2(data_out2),
		.data_out3(data_out3),
		.data_out4(data_out4),
		.in_done(in_done),
		.cal_done(cal_done),
		.done(done)
		);


  // Clock generation 

    always #5 clk = ~clk; 

  

  // Reset generation 

    initial begin 
			rst = 0;
			#1000 
        rst = 1; 

        //#1000 
		  start = 1;	 
		  mode = 0;

        // Reset for a few clock cycles 

        #1000  

        rst = 0; 

        // Start processing 
         
		  #38000  

        start = 0; 

		  wait(done);

        #70 
		  start = 1;
		 #80 

//        mem[0] = datao1; 
//
//        mem[1] = datao2; 
//
//        mem[2] = datao3; 
//
//        mem[3] = datao4; 
//
//        #40 
//
//        mem[4] = datao1; 
//
//        mem[5] = datao2; 
//
//        mem[6] = datao3; 
//
//        mem[7] = datao4; 
//
//        #40 
//
//        mem[8] = datao1; 
//
//        mem[9] = datao2; 
//
//        mem[10] = datao3; 
//
//        mem[11] = datao4; 
//
//        #40 
//
//        mem[12] = datao1; 
//
//        mem[13] = datao2; 
//
//        mem[14] = datao3; 
//
//        mem[15] = datao4; 
//
//        #40 
//
//        mem[16] = datao1; 
//
//        mem[17] = datao2; 
//
//        mem[18] = datao3; 
//
//        mem[19] = datao4; 
//
//        #40 
//
//        mem[20] = datao1; 
//
//        mem[21] = datao2; 
//
//        mem[22] = datao3; 
//
//        mem[23] = datao4; 
//
//        #40 
//
//        mem[24] = datao1; 
//
//        mem[25] = datao2; 
//
//        mem[26] = datao3; 
//
//        mem[27] = datao4; 
//
//        #40 
//
//        mem[28] = datao1; 
//
//        mem[29] = datao2; 
//
//        mem[30] = datao3; 
//
//        mem[31] = datao4; 
//
//        #40 
//
//        mem[32] = datao1; 
//
//        mem[33] = datao2; 
//
//        mem[34] = datao3; 
//
//        mem[35] = datao4; 
//
//        #40 
//
//        mem[36] = datao1; 
//
//        mem[37] = datao2; 
//
//        mem[38] = datao3; 
//
//        mem[39] = datao4; 
//
//        #40 
//
//        mem[40] = datao1; 
//
//        mem[41] = datao2; 
//
//        mem[42] = datao3; 
//
//        mem[43] = datao4; 
//
//        #40 
//
//        mem[44] = datao1; 
//
//        mem[45] = datao2; 
//
//        mem[46] = datao3; 
//
//        mem[47] = datao4; 
//
//        #40 
//
//        mem[48] = datao1; 
//
//        mem[49] = datao2; 
//
//        mem[50] = datao3; 
//
//        mem[51] = datao4; 
//
//        #40 
//
//        mem[52] = datao1; 
//
//        mem[53] = datao2; 
//
//        mem[54] = datao3; 
//
//        mem[55] = datao4; 
//
//        #40 
//
//        mem[56] = datao1; 
//
//        mem[57] = datao2; 
//
//        mem[58] = datao3; 
//
//        mem[59] = datao4; 
//
//        #40 
//
//        mem[60] = datao1; 
//
//        mem[61] = datao2; 
//
//        mem[62] = datao3; 
//
//        mem[63] = datao4; 
//
//        #40 
//
//        mem[64] = datao1; 
//
//        mem[65] = datao2; 
//
//        mem[66] = datao3; 
//
//        mem[67] = datao4; 
//
//        #40 
//
//        mem[68] = datao1; 
//
//        mem[69] = datao2; 
//
//        mem[70] = datao3; 
//
//        mem[71] = datao4; 
//
//        #40 
//
//        mem[72] = datao1; 
//
//        mem[73] = datao2; 
//
//        mem[74] = datao3; 
//
//        mem[75] = datao4; 
//
//        #40 
//
//        mem[76] = datao1; 
//
//        mem[77] = datao2; 
//
//        mem[78] = datao3; 
//
//        mem[79] = datao4; 
//
//        #40 
//
//        mem[80] = datao1; 
//
//        mem[81] = datao2; 
//
//        mem[82] = datao3; 
//
//        mem[83] = datao4; 
//
//        #40 
//
//        mem[84] = datao1; 
//
//        mem[85] = datao2; 
//
//        mem[86] = datao3; 
//
//        mem[87] = datao4; 
//
//        #40 
//
//        mem[88] = datao1; 
//
//        mem[89] = datao2; 
//
//        mem[90] = datao3; 
//
//        mem[91] = datao4; 
//
//        #40 
//
//        mem[92] = datao1; 
//
//        mem[93] = datao2; 
//
//        mem[94] = datao3; 
//
//        mem[95] = datao4; 
//
//        #40 
//
//        mem[96] = datao1; 
//
//        mem[97] = datao2; 
//
//        mem[98] = datao3; 
//
//        mem[99] = datao4; 
//
//        #40 
//
//        mem[100] = datao1; 
//
//        mem[101] = datao2; 
//
//        mem[102] = datao3; 
//
//        mem[103] = datao4; 
//
//        #40 
//
//        mem[104] = datao1; 
//
//        mem[105] = datao2; 
//
//        mem[106] = datao3; 
//
//        mem[107] = datao4; 
//
//        #40 
//
//        mem[108] = datao1; 
//
//        mem[109] = datao2; 
//
//        mem[110] = datao3; 
//
//        mem[111] = datao4; 
//
//        #40 
//
//        mem[112] = datao1; 
//
//        mem[113] = datao2; 
//
//        mem[114] = datao3; 
//
//        mem[115] = datao4; 
//
//        #40 
//
//        mem[116] = datao1; 
//
//        mem[117] = datao2; 
//
//        mem[118] = datao3; 
//
//        mem[119] = datao4; 
//
//        #40 
//
//        mem[120] = datao1; 
//
//        mem[121] = datao2; 
//
//        mem[122] = datao3; 
//
//        mem[123] = datao4; 
//
//        #40 
//
//        mem[124] = datao1; 
//
//        mem[125] = datao2; 
//
//        mem[126] = datao3; 
//
//        mem[127] = datao4; 
//
//        #40 
//
//        mem[128] = datao1; 
//
//        mem[129] = datao2; 
//
//        mem[130] = datao3; 
//
//        mem[131] = datao4; 
//
//        #40 
//
//        mem[132] = datao1; 
//
//        mem[133] = datao2; 
//
//        mem[134] = datao3; 
//
//        mem[135] = datao4; 
//
//        #40 
//
//        mem[136] = datao1; 
//
//        mem[137] = datao2; 
//
//        mem[138] = datao3; 
//
//        mem[139] = datao4; 
//
//        #40 
//
//        mem[140] = datao1; 
//
//        mem[141] = datao2; 
//
//        mem[142] = datao3; 
//
//        mem[143] = datao4; 
//
//        #40 
//
//        mem[144] = datao1; 
//
//        mem[145] = datao2; 
//
//        mem[146] = datao3; 
//
//        mem[147] = datao4; 
//
//        #40 
//
//        mem[148] = datao1; 
//
//        mem[149] = datao2; 
//
//        mem[150] = datao3; 
//
//        mem[151] = datao4; 
//
//        #40 
//
//        mem[152] = datao1; 
//
//        mem[153] = datao2; 
//
//        mem[154] = datao3; 
//
//        mem[155] = datao4; 
//
//        #40 
//
//        mem[156] = datao1; 
//
//        mem[157] = datao2; 
//
//        mem[158] = datao3; 
//
//        mem[159] = datao4; 
//
//        #40 
//
//        mem[160] = datao1; 
//
//        mem[161] = datao2; 
//
//        mem[162] = datao3; 
//
//        mem[163] = datao4; 
//
//        #40 
//
//        mem[164] = datao1; 
//
//        mem[165] = datao2; 
//
//        mem[166] = datao3; 
//
//        mem[167] = datao4; 
//
//        #40 
//
//        mem[168] = datao1; 
//
//        mem[169] = datao2; 
//
//        mem[170] = datao3; 
//
//        mem[171] = datao4; 
//
//        #40 
//
//        mem[172] = datao1; 
//
//        mem[173] = datao2; 
//
//        mem[174] = datao3; 
//
//        mem[175] = datao4; 
//
//        #40 
//
//        mem[176] = datao1; 
//
//        mem[177] = datao2; 
//
//        mem[178] = datao3; 
//
//        mem[179] = datao4; 
//
//        #40 
//
//        mem[180] = datao1; 
//
//        mem[181] = datao2; 
//
//        mem[182] = datao3; 
//
//        mem[183] = datao4; 
//
//        #40 
//
//        mem[184] = datao1; 
//
//        mem[185] = datao2; 
//
//        mem[186] = datao3; 
//
//        mem[187] = datao4; 
//
//        #40 
//
//        mem[188] = datao1; 
//
//        mem[189] = datao2; 
//
//        mem[190] = datao3; 
//
//        mem[191] = datao4; 
//
//        #40 
//
//        mem[192] = datao1; 
//
//        mem[193] = datao2; 
//
//        mem[194] = datao3; 
//
//        mem[195] = datao4; 
//
//        #40 
//
//        mem[196] = datao1; 
//
//        mem[197] = datao2; 
//
//        mem[198] = datao3; 
//
//        mem[199] = datao4; 
//
//        #40 
//
//        mem[200] = datao1; 
//
//        mem[201] = datao2; 
//
//        mem[202] = datao3; 
//
//        mem[203] = datao4; 
//
//        #40 
//
//        mem[204] = datao1; 
//
//        mem[205] = datao2; 
//
//        mem[206] = datao3; 
//
//        mem[207] = datao4; 
//
//        #40 
//
//        mem[208] = datao1; 
//
//        mem[209] = datao2; 
//
//        mem[210] = datao3; 
//
//        mem[211] = datao4; 
//
//        #40 
//
//        mem[212] = datao1; 
//
//        mem[213] = datao2; 
//
//        mem[214] = datao3; 
//
//        mem[215] = datao4; 
//
//        #40 
//
//        mem[216] = datao1; 
//
//        mem[217] = datao2; 
//
//        mem[218] = datao3; 
//
//        mem[219] = datao4; 
//
//        #40 
//
//        mem[220] = datao1; 
//
//        mem[221] = datao2; 
//
//        mem[222] = datao3; 
//
//        mem[223] = datao4; 
//
//        #40 
//
//        mem[224] = datao1; 
//
//        mem[225] = datao2; 
//
//        mem[226] = datao3; 
//
//        mem[227] = datao4; 
//
//        #40 
//
//        mem[228] = datao1; 
//
//        mem[229] = datao2; 
//
//        mem[230] = datao3; 
//
//        mem[231] = datao4; 
//
//        #40 
//
//        mem[232] = datao1; 
//
//        mem[233] = datao2; 
//
//        mem[234] = datao3; 
//
//        mem[235] = datao4; 
//
//        #40 
//
//        mem[236] = datao1; 
//
//        mem[237] = datao2; 
//
//        mem[238] = datao3; 
//
//        mem[239] = datao4; 
//
//        #40 
//
//        mem[240] = datao1; 
//
//        mem[241] = datao2; 
//
//        mem[242] = datao3; 
//
//        mem[243] = datao4; 
//
//        #40 
//
//        mem[244] = datao1; 
//
//        mem[245] = datao2; 
//
//        mem[246] = datao3; 
//
//        mem[247] = datao4; 
//
//        #40 
//
//        mem[248] = datao1; 
//
//        mem[249] = datao2; 
//
//        mem[250] = datao3; 
//
//        mem[251] = datao4; 
//
//        #40 
//
//        mem[252] = datao1; 
//
//        mem[253] = datao2; 
//
//        mem[254] = datao3; 
//
//        mem[255] = datao4; 
//
//        #40 
//
//        $writememh("/home/doe/Downloads/outNTTv2.txt",mem); 
//
//		  wait(outnnt_done); 
//
//		  #40 

        // Simulation done 

        $finish; 
    end 

  

endmodule 

 

 