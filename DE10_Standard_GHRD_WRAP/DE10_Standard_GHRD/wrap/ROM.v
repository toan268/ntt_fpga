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

module ROM(clk,address1,address2,tw1,tw2);

	input clk;
	input [7:0] address1,address2;
	output reg [15:0] tw1,tw2;
	// Declare the ROM variable
	reg [15:0] mem_ROM [127:0];


	// Initialize the ROM with $readmemb.  Put the memory contents
	// in the file dual_port_rom_init.txt.  Without this file,
	// this design will not compile.
	// See Verilog LRM 1364-2001 Section 17.2.8 for details on the
	// format of this file.

	initial 
	begin 
		mem_ROM[0] = -16'sd1044;
		mem_ROM[1] = -16'sd758;
		mem_ROM[2] = -16'sd359;
		mem_ROM[3] = -16'sd1517;
		mem_ROM[4] = 16'sd1493;
		mem_ROM[5] = 16'sd1422;
		mem_ROM[6] = 16'sd287;
		mem_ROM[7] = 16'sd202;
		mem_ROM[8] = -16'sd171;
		mem_ROM[9] = 16'sd622;
		mem_ROM[10] = 16'sd1577;
		mem_ROM[11] = 16'sd182;
		mem_ROM[12] = 16'sd962;
		mem_ROM[13] = -16'sd1202;
		mem_ROM[14] = -16'sd1474;
		mem_ROM[15] = 16'sd1468;
		mem_ROM[16] = 16'sd573;
		mem_ROM[17] = -16'sd1325;
		mem_ROM[18] = 16'sd264;
		mem_ROM[19] = 16'sd383;
		mem_ROM[20] = -16'sd829;
		mem_ROM[21] = 16'sd1458;
		mem_ROM[22] = -16'sd1602;
		mem_ROM[23] = -16'sd130;
		mem_ROM[24] = -16'sd681;
		mem_ROM[25] = 16'sd1017;
		mem_ROM[26] = 16'sd732;
		mem_ROM[27] = 16'sd608;
		mem_ROM[28] = -16'sd1542;
		mem_ROM[29] = 16'sd411;
		mem_ROM[30] = -16'sd205;
		mem_ROM[31] = -16'sd1571;
		mem_ROM[32] = 16'sd1223;
		mem_ROM[33] = 16'sd652;
		mem_ROM[34] = -16'sd552;
		mem_ROM[35] = 16'sd1015;
		mem_ROM[36] = -16'sd1293;
		mem_ROM[37] = 16'sd1491;
		mem_ROM[38] = -16'sd282;
		mem_ROM[39] = -16'sd1544;
		mem_ROM[40] = 16'sd516;
		mem_ROM[41] = -16'sd8;
		mem_ROM[42] = -16'sd320;
		mem_ROM[43] = -16'sd666;
		mem_ROM[44] = -16'sd1618;
		mem_ROM[45] = -16'sd1162;
		mem_ROM[46] = 16'sd126;
		mem_ROM[47] = 16'sd1469;
		mem_ROM[48] = -16'sd853;
		mem_ROM[49] = -16'sd90;
		mem_ROM[50] = -16'sd271;
		mem_ROM[51] = 16'sd830;
		mem_ROM[52] = 16'sd107;
		mem_ROM[53] = -16'sd1421;
		mem_ROM[54] = -16'sd247;
		mem_ROM[55] = -16'sd951;
		mem_ROM[56] = -16'sd398;
		mem_ROM[57] = 16'sd961;
		mem_ROM[58] = -16'sd1508;
		mem_ROM[59] = -16'sd725;
		mem_ROM[60] = 16'sd448;
		mem_ROM[61] = -16'sd1065;
		mem_ROM[62] = 16'sd677;
		mem_ROM[63] = -16'sd1275;
		mem_ROM[64] = -16'sd1103;
		mem_ROM[65] = 16'sd430;
		mem_ROM[66] = 16'sd555;
		mem_ROM[67] = 16'sd843;
		mem_ROM[68] = -16'sd1251;
		mem_ROM[69] = 16'sd871;
		mem_ROM[70] = 16'sd1550;
		mem_ROM[71] = 16'sd105;
		mem_ROM[72] = 16'sd422;
		mem_ROM[73] = 16'sd587;
		mem_ROM[74] = 16'sd177;
		mem_ROM[75] = -16'sd235;
		mem_ROM[76] = -16'sd291;
		mem_ROM[77] = -16'sd460;
		mem_ROM[78] = 16'sd1574;
		mem_ROM[79] = 16'sd1653;
		mem_ROM[80] = -16'sd246;
		mem_ROM[81] = 16'sd778;
		mem_ROM[82] = 16'sd1159;
		mem_ROM[83] = -16'sd147;
		mem_ROM[84] = -16'sd777;
		mem_ROM[85] = 16'sd1483;
		mem_ROM[86] = -16'sd602;
		mem_ROM[87] = 16'sd1119;
		mem_ROM[88] = -16'sd1590;
		mem_ROM[89] = 16'sd644;
		mem_ROM[90] = -16'sd872;
		mem_ROM[91] = 16'sd349;
		mem_ROM[92] = 16'sd418;
		mem_ROM[93] = 16'sd329;
		mem_ROM[94] = -16'sd156;
		mem_ROM[95] = -16'sd75;
		mem_ROM[96] = 16'sd817;
		mem_ROM[97] = 16'sd1097;
		mem_ROM[98] = 16'sd603;
		mem_ROM[99] = 16'sd610;
		mem_ROM[100] = 16'sd1322;
		mem_ROM[101] = -16'sd1285;
		mem_ROM[102] = -16'sd1465;
		mem_ROM[103] = 16'sd384;
		mem_ROM[104] = -16'sd1215;
		mem_ROM[105] = -16'sd136;
		mem_ROM[106] = 16'sd1218;
		mem_ROM[107] = -16'sd1335;
		mem_ROM[108] = -16'sd874;
		mem_ROM[109] = 16'sd220;
		mem_ROM[110] = -16'sd1187;
		mem_ROM[111] = -16'sd1659;
		mem_ROM[112] = -16'sd1185;
		mem_ROM[113] = -16'sd1530;
		mem_ROM[114] = -16'sd1278;
		mem_ROM[115] = 16'sd794;
		mem_ROM[116] = -16'sd1510;
		mem_ROM[117] = -16'sd854;
		mem_ROM[118] = -16'sd870;
		mem_ROM[119] = 16'sd478;
		mem_ROM[120] = -16'sd108;
		mem_ROM[121] = -16'sd308;
		mem_ROM[122] = 16'sd996;
		mem_ROM[123] = 16'sd991;
		mem_ROM[124] = 16'sd958;
		mem_ROM[125] = -16'sd1460;
		mem_ROM[126] = 16'sd1522;
		mem_ROM[127] = 16'sd1628;    
	end

	always @(posedge clk)
	begin
		tw1 <= mem_ROM[address1];
		tw2 <= mem_ROM[address2];
	end  
endmodule
