`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/15/2023 04:09:11 PM
// Design Name: 
// Module Name: ROM
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

module ROMIN1(clk,address1,address2,a,b);

	input clk;
	input [7:0] address1,address2;
	output reg [15:0] a,b;
	// Declare the ROM variable
	reg [15:0] mem_ROMWRAP [255:0];


	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file dual_port_rom_init.txt.  Without this file,
	// this design will not compile.
	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file.

	initial 
	begin 
		mem_ROMWRAP[0] = 0;
		mem_ROMWRAP[1] = 1;
		mem_ROMWRAP[2] = 2;
		mem_ROMWRAP[3] = 3;
		mem_ROMWRAP[4] = 4;
		mem_ROMWRAP[5] = 5;
		mem_ROMWRAP[6] = 6;
		mem_ROMWRAP[7] = 7;
		mem_ROMWRAP[8] = 8;
		mem_ROMWRAP[9] = 9;
		mem_ROMWRAP[10] = 10;
		mem_ROMWRAP[11] = 11;
		mem_ROMWRAP[12] = 12;
		mem_ROMWRAP[13] = 13;
		mem_ROMWRAP[14] = 14;
		mem_ROMWRAP[15] = 15;
		mem_ROMWRAP[16] = 16;
		mem_ROMWRAP[17] = 17;
		mem_ROMWRAP[18] = 18;
		mem_ROMWRAP[19] = 19;
		mem_ROMWRAP[20] = 20;
		mem_ROMWRAP[21] = 21;
		mem_ROMWRAP[22] = 22;
		mem_ROMWRAP[23] = 23;
		mem_ROMWRAP[24] = 24;
		mem_ROMWRAP[25] = 25;
		mem_ROMWRAP[26] = 26;
		mem_ROMWRAP[27] = 27;
		mem_ROMWRAP[28] = 28;
		mem_ROMWRAP[29] = 29;
		mem_ROMWRAP[30] = 30;
		mem_ROMWRAP[31] = 31;
		mem_ROMWRAP[32] = 32;
		mem_ROMWRAP[33] = 33;
		mem_ROMWRAP[34] = 34;
		mem_ROMWRAP[35] = 35;
		mem_ROMWRAP[36] = 36;
		mem_ROMWRAP[37] = 37;
		mem_ROMWRAP[38] = 38;
		mem_ROMWRAP[39] = 39;
		mem_ROMWRAP[40] = 40;
		mem_ROMWRAP[41] = 41;
		mem_ROMWRAP[42] = 42;
		mem_ROMWRAP[43] = 43;
		mem_ROMWRAP[44] = 44;
		mem_ROMWRAP[45] = 45;
		mem_ROMWRAP[46] = 46;
		mem_ROMWRAP[47] = 47;
		mem_ROMWRAP[48] = 48;
		mem_ROMWRAP[49] = 49;
		mem_ROMWRAP[50] = 50;
		mem_ROMWRAP[51] = 51;
		mem_ROMWRAP[52] = 52;
		mem_ROMWRAP[53] = 53;
		mem_ROMWRAP[54] = 54;
		mem_ROMWRAP[55] = 55;
		mem_ROMWRAP[56] = 56;
		mem_ROMWRAP[57] = 57;
		mem_ROMWRAP[58] = 58;
		mem_ROMWRAP[59] = 59;
		mem_ROMWRAP[60] = 60;
		mem_ROMWRAP[61] = 61;
		mem_ROMWRAP[62] = 62;
		mem_ROMWRAP[63] = 63;
		mem_ROMWRAP[64] = 64;
		mem_ROMWRAP[65] = 65;
		mem_ROMWRAP[66] = 66;
		mem_ROMWRAP[67] = 67;
		mem_ROMWRAP[68] = 68;
		mem_ROMWRAP[69] = 69;
		mem_ROMWRAP[70] = 70;
		mem_ROMWRAP[71] = 71;
		mem_ROMWRAP[72] = 72;
		mem_ROMWRAP[73] = 73;
		mem_ROMWRAP[74] = 74;
		mem_ROMWRAP[75] = 75;
		mem_ROMWRAP[76] = 76;
		mem_ROMWRAP[77] = 77;
		mem_ROMWRAP[78] = 78;
		mem_ROMWRAP[79] = 79;
		mem_ROMWRAP[80] = 80;
		mem_ROMWRAP[81] = 81;
		mem_ROMWRAP[82] = 82;
		mem_ROMWRAP[83] = 83;
		mem_ROMWRAP[84] = 84;
		mem_ROMWRAP[85] = 85;
		mem_ROMWRAP[86] = 86;
		mem_ROMWRAP[87] = 87;
		mem_ROMWRAP[88] = 88;
		mem_ROMWRAP[89] = 89;
		mem_ROMWRAP[90] = 90;
		mem_ROMWRAP[91] = 91;
		mem_ROMWRAP[92] = 92;
		mem_ROMWRAP[93] = 93;
		mem_ROMWRAP[94] = 94;
		mem_ROMWRAP[95] = 95;
		mem_ROMWRAP[96] = 96;
		mem_ROMWRAP[97] = 97;
		mem_ROMWRAP[98] = 98;
		mem_ROMWRAP[99] = 99;
		mem_ROMWRAP[100] = 100;
		mem_ROMWRAP[101] = 101;
		mem_ROMWRAP[102] = 102;
		mem_ROMWRAP[103] = 103;
		mem_ROMWRAP[104] = 104;
		mem_ROMWRAP[105] = 105;
		mem_ROMWRAP[106] = 106;
		mem_ROMWRAP[107] = 107;
		mem_ROMWRAP[108] = 108;
		mem_ROMWRAP[109] = 109;
		mem_ROMWRAP[110] = 110;
		mem_ROMWRAP[111] = 111;
		mem_ROMWRAP[112] = 112;
		mem_ROMWRAP[113] = 113;
		mem_ROMWRAP[114] = 114;
		mem_ROMWRAP[115] = 115;
		mem_ROMWRAP[116] = 116;
		mem_ROMWRAP[117] = 117;
		mem_ROMWRAP[118] = 118;
		mem_ROMWRAP[119] = 119;
		mem_ROMWRAP[120] = 120;
		mem_ROMWRAP[121] = 121;
		mem_ROMWRAP[122] = 122;
		mem_ROMWRAP[123] = 123;
		mem_ROMWRAP[124] = 124;
		mem_ROMWRAP[125] = 125;
		mem_ROMWRAP[126] = 126;
		mem_ROMWRAP[127] = 127;
		mem_ROMWRAP[128] = 128;
		mem_ROMWRAP[129] = 129;
		mem_ROMWRAP[130] = 130;
		mem_ROMWRAP[131] = 131;
		mem_ROMWRAP[132] = 132;
		mem_ROMWRAP[133] = 133;
		mem_ROMWRAP[134] = 134;
		mem_ROMWRAP[135] = 135;
		mem_ROMWRAP[136] = 136;
		mem_ROMWRAP[137] = 137;
		mem_ROMWRAP[138] = 138;
		mem_ROMWRAP[139] = 139;
		mem_ROMWRAP[140] = 140;
		mem_ROMWRAP[141] = 141;
		mem_ROMWRAP[142] = 142;
		mem_ROMWRAP[143] = 143;
		mem_ROMWRAP[144] = 144;
		mem_ROMWRAP[145] = 145;
		mem_ROMWRAP[146] = 146;
		mem_ROMWRAP[147] = 147;
		mem_ROMWRAP[148] = 148;
		mem_ROMWRAP[149] = 149;
		mem_ROMWRAP[150] = 150;
		mem_ROMWRAP[151] = 151;
		mem_ROMWRAP[152] = 152;
		mem_ROMWRAP[153] = 153;
		mem_ROMWRAP[154] = 154;
		mem_ROMWRAP[155] = 155;
		mem_ROMWRAP[156] = 156;
		mem_ROMWRAP[157] = 157;
		mem_ROMWRAP[158] = 158;
		mem_ROMWRAP[159] = 159;
		mem_ROMWRAP[160] = 160;
		mem_ROMWRAP[161] = 161;
		mem_ROMWRAP[162] = 162;
		mem_ROMWRAP[163] = 163;
		mem_ROMWRAP[164] = 164;
		mem_ROMWRAP[165] = 165;
		mem_ROMWRAP[166] = 166;
		mem_ROMWRAP[167] = 167;
		mem_ROMWRAP[168] = 168;
		mem_ROMWRAP[169] = 169;
		mem_ROMWRAP[170] = 170;
		mem_ROMWRAP[171] = 171;
		mem_ROMWRAP[172] = 172;
		mem_ROMWRAP[173] = 173;
		mem_ROMWRAP[174] = 174;
		mem_ROMWRAP[175] = 175;
		mem_ROMWRAP[176] = 176;
		mem_ROMWRAP[177] = 177;
		mem_ROMWRAP[178] = 178;
		mem_ROMWRAP[179] = 179;
		mem_ROMWRAP[180] = 180;
		mem_ROMWRAP[181] = 181;
		mem_ROMWRAP[182] = 182;
		mem_ROMWRAP[183] = 183;
		mem_ROMWRAP[184] = 184;
		mem_ROMWRAP[185] = 185;
		mem_ROMWRAP[186] = 186;
		mem_ROMWRAP[187] = 187;
		mem_ROMWRAP[188] = 188;
		mem_ROMWRAP[189] = 189;
		mem_ROMWRAP[190] = 190;
		mem_ROMWRAP[191] = 191;
		mem_ROMWRAP[192] = 192;
		mem_ROMWRAP[193] = 193;
		mem_ROMWRAP[194] = 194;
		mem_ROMWRAP[195] = 195;
		mem_ROMWRAP[196] = 196;
		mem_ROMWRAP[197] = 197;
		mem_ROMWRAP[198] = 198;
		mem_ROMWRAP[199] = 199;
		mem_ROMWRAP[200] = 200;
		mem_ROMWRAP[201] = 201;
		mem_ROMWRAP[202] = 202;
		mem_ROMWRAP[203] = 203;
		mem_ROMWRAP[204] = 204;
		mem_ROMWRAP[205] = 205;
		mem_ROMWRAP[206] = 206;
		mem_ROMWRAP[207] = 207;
		mem_ROMWRAP[208] = 208;
		mem_ROMWRAP[209] = 209;
		mem_ROMWRAP[210] = 210;
		mem_ROMWRAP[211] = 211;
		mem_ROMWRAP[212] = 212;
		mem_ROMWRAP[213] = 213;
		mem_ROMWRAP[214] = 214;
		mem_ROMWRAP[215] = 215;
		mem_ROMWRAP[216] = 216;
		mem_ROMWRAP[217] = 217;
		mem_ROMWRAP[218] = 218;
		mem_ROMWRAP[219] = 219;
		mem_ROMWRAP[220] = 220;
		mem_ROMWRAP[221] = 221;
		mem_ROMWRAP[222] = 222;
		mem_ROMWRAP[223] = 223;
		mem_ROMWRAP[224] = 224;
		mem_ROMWRAP[225] = 225;
		mem_ROMWRAP[226] = 226;
		mem_ROMWRAP[227] = 227;
		mem_ROMWRAP[228] = 228;
		mem_ROMWRAP[229] = 229;
		mem_ROMWRAP[230] = 230;
		mem_ROMWRAP[231] = 231;
		mem_ROMWRAP[232] = 232;
		mem_ROMWRAP[233] = 233;
		mem_ROMWRAP[234] = 234;
		mem_ROMWRAP[235] = 235;
		mem_ROMWRAP[236] = 236;
		mem_ROMWRAP[237] = 237;
		mem_ROMWRAP[238] = 238;
		mem_ROMWRAP[239] = 239;
		mem_ROMWRAP[240] = 240;
		mem_ROMWRAP[241] = 241;
		mem_ROMWRAP[242] = 242;
		mem_ROMWRAP[243] = 243;
		mem_ROMWRAP[244] = 244;
		mem_ROMWRAP[245] = 245;
		mem_ROMWRAP[246] = 246;
		mem_ROMWRAP[247] = 247;
		mem_ROMWRAP[248] = 248;
		mem_ROMWRAP[249] = 249;
		mem_ROMWRAP[250] = 250;
		mem_ROMWRAP[251] = 251;
		mem_ROMWRAP[252] = 252;
		mem_ROMWRAP[253] = 253;
		mem_ROMWRAP[254] = 254;
		mem_ROMWRAP[255] = 255;
	end

	always @(posedge clk)
	begin
		a <= mem_ROMWRAP[address1];
		b <= mem_ROMWRAP[address2];
	end  
endmodule
