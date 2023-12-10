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
    
    reg we = 0;
    
    reg [7:0] address_ina;
    
    reg [7:0] address_inb;
    
    reg [15:0] data_ina;
    
    reg [15:0] data_inb;
    
    wire [15:0] data_out1;
    
    wire [15:0] data_out2;
    
    wire init_done;
    
    wire in_done;
    
    wire cal_done;
    
    wire done;
    
	 
	 
	 


  // Instantiate the wrap module 
	
	wrap dut (
		.clk(clk),
		.rst(rst),
		.start(start),
		.mode(mode),
		.we(we),
		.address_ina(address_ina),
		.address_inb(address_inb),
		.data_ina(data_ina),
		.data_inb(data_inb),
		.data_out1(data_out1),
		.data_out2(data_out2),
		.init_done(init_done),
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
        
        #1000  
        we = 1;
address_ina = 0;
address_inb = 1;
data_ina = 0;
data_inb = 1;
#10
address_ina = 2;
address_inb = 3;
data_ina = 2;
data_inb = 3;
#10
address_ina = 4;
address_inb = 5;
data_ina = 4;
data_inb = 5;
#10
address_ina = 6;
address_inb = 7;
data_ina = 6;
data_inb = 7;
#10
address_ina = 8;
address_inb = 9;
data_ina = 8;
data_inb = 9;
#10
address_ina = 10;
address_inb = 11;
data_ina = 10;
data_inb = 11;
#10
address_ina = 12;
address_inb = 13;
data_ina = 12;
data_inb = 13;
#10
address_ina = 14;
address_inb = 15;
data_ina = 14;
data_inb = 15;
#10
address_ina = 16;
address_inb = 17;
data_ina = 16;
data_inb = 17;
#10
address_ina = 18;
address_inb = 19;
data_ina = 18;
data_inb = 19;
#10
address_ina = 20;
address_inb = 21;
data_ina = 20;
data_inb = 21;
#10
address_ina = 22;
address_inb = 23;
data_ina = 22;
data_inb = 23;
#10
address_ina = 24;
address_inb = 25;
data_ina = 24;
data_inb = 25;
#10
address_ina = 26;
address_inb = 27;
data_ina = 26;
data_inb = 27;
#10
address_ina = 28;
address_inb = 29;
data_ina = 28;
data_inb = 29;
#10
address_ina = 30;
address_inb = 31;
data_ina = 30;
data_inb = 31;
#10
address_ina = 32;
address_inb = 33;
data_ina = 32;
data_inb = 33;
#10
address_ina = 34;
address_inb = 35;
data_ina = 34;
data_inb = 35;
#10
address_ina = 36;
address_inb = 37;
data_ina = 36;
data_inb = 37;
#10
address_ina = 38;
address_inb = 39;
data_ina = 38;
data_inb = 39;
#10
address_ina = 40;
address_inb = 41;
data_ina = 40;
data_inb = 41;
#10
address_ina = 42;
address_inb = 43;
data_ina = 42;
data_inb = 43;
#10
address_ina = 44;
address_inb = 45;
data_ina = 44;
data_inb = 45;
#10
address_ina = 46;
address_inb = 47;
data_ina = 46;
data_inb = 47;
#10
address_ina = 48;
address_inb = 49;
data_ina = 48;
data_inb = 49;
#10
address_ina = 50;
address_inb = 51;
data_ina = 50;
data_inb = 51;
#10
address_ina = 52;
address_inb = 53;
data_ina = 52;
data_inb = 53;
#10
address_ina = 54;
address_inb = 55;
data_ina = 54;
data_inb = 55;
#10
address_ina = 56;
address_inb = 57;
data_ina = 56;
data_inb = 57;
#10
address_ina = 58;
address_inb = 59;
data_ina = 58;
data_inb = 59;
#10
address_ina = 60;
address_inb = 61;
data_ina = 60;
data_inb = 61;
#10
address_ina = 62;
address_inb = 63;
data_ina = 62;
data_inb = 63;
#10
address_ina = 64;
address_inb = 65;
data_ina = 64;
data_inb = 65;
#10
address_ina = 66;
address_inb = 67;
data_ina = 66;
data_inb = 67;
#10
address_ina = 68;
address_inb = 69;
data_ina = 68;
data_inb = 69;
#10
address_ina = 70;
address_inb = 71;
data_ina = 70;
data_inb = 71;
#10
address_ina = 72;
address_inb = 73;
data_ina = 72;
data_inb = 73;
#10
address_ina = 74;
address_inb = 75;
data_ina = 74;
data_inb = 75;
#10
address_ina = 76;
address_inb = 77;
data_ina = 76;
data_inb = 77;
#10
address_ina = 78;
address_inb = 79;
data_ina = 78;
data_inb = 79;
#10
address_ina = 80;
address_inb = 81;
data_ina = 80;
data_inb = 81;
#10
address_ina = 82;
address_inb = 83;
data_ina = 82;
data_inb = 83;
#10
address_ina = 84;
address_inb = 85;
data_ina = 84;
data_inb = 85;
#10
address_ina = 86;
address_inb = 87;
data_ina = 86;
data_inb = 87;
#10
address_ina = 88;
address_inb = 89;
data_ina = 88;
data_inb = 89;
#10
address_ina = 90;
address_inb = 91;
data_ina = 90;
data_inb = 91;
#10
address_ina = 92;
address_inb = 93;
data_ina = 92;
data_inb = 93;
#10
address_ina = 94;
address_inb = 95;
data_ina = 94;
data_inb = 95;
#10
address_ina = 96;
address_inb = 97;
data_ina = 96;
data_inb = 97;
#10
address_ina = 98;
address_inb = 99;
data_ina = 98;
data_inb = 99;
#10
address_ina = 100;
address_inb = 101;
data_ina = 100;
data_inb = 101;
#10
address_ina = 102;
address_inb = 103;
data_ina = 102;
data_inb = 103;
#10
address_ina = 104;
address_inb = 105;
data_ina = 104;
data_inb = 105;
#10
address_ina = 106;
address_inb = 107;
data_ina = 106;
data_inb = 107;
#10
address_ina = 108;
address_inb = 109;
data_ina = 108;
data_inb = 109;
#10
address_ina = 110;
address_inb = 111;
data_ina = 110;
data_inb = 111;
#10
address_ina = 112;
address_inb = 113;
data_ina = 112;
data_inb = 113;
#10
address_ina = 114;
address_inb = 115;
data_ina = 114;
data_inb = 115;
#10
address_ina = 116;
address_inb = 117;
data_ina = 116;
data_inb = 117;
#10
address_ina = 118;
address_inb = 119;
data_ina = 118;
data_inb = 119;
#10
address_ina = 120;
address_inb = 121;
data_ina = 120;
data_inb = 121;
#10
address_ina = 122;
address_inb = 123;
data_ina = 122;
data_inb = 123;
#10
address_ina = 124;
address_inb = 125;
data_ina = 124;
data_inb = 125;
#10
address_ina = 126;
address_inb = 127;
data_ina = 126;
data_inb = 127;
#10
address_ina = 128;
address_inb = 129;
data_ina = 128;
data_inb = 129;
#10
address_ina = 130;
address_inb = 131;
data_ina = 130;
data_inb = 131;
#10
address_ina = 132;
address_inb = 133;
data_ina = 132;
data_inb = 133;
#10
address_ina = 134;
address_inb = 135;
data_ina = 134;
data_inb = 135;
#10
address_ina = 136;
address_inb = 137;
data_ina = 136;
data_inb = 137;
#10
address_ina = 138;
address_inb = 139;
data_ina = 138;
data_inb = 139;
#10
address_ina = 140;
address_inb = 141;
data_ina = 140;
data_inb = 141;
#10
address_ina = 142;
address_inb = 143;
data_ina = 142;
data_inb = 143;
#10
address_ina = 144;
address_inb = 145;
data_ina = 144;
data_inb = 145;
#10
address_ina = 146;
address_inb = 147;
data_ina = 146;
data_inb = 147;
#10
address_ina = 148;
address_inb = 149;
data_ina = 148;
data_inb = 149;
#10
address_ina = 150;
address_inb = 151;
data_ina = 150;
data_inb = 151;
#10
address_ina = 152;
address_inb = 153;
data_ina = 152;
data_inb = 153;
#10
address_ina = 154;
address_inb = 155;
data_ina = 154;
data_inb = 155;
#10
address_ina = 156;
address_inb = 157;
data_ina = 156;
data_inb = 157;
#10
address_ina = 158;
address_inb = 159;
data_ina = 158;
data_inb = 159;
#10
address_ina = 160;
address_inb = 161;
data_ina = 160;
data_inb = 161;
#10
address_ina = 162;
address_inb = 163;
data_ina = 162;
data_inb = 163;
#10
address_ina = 164;
address_inb = 165;
data_ina = 164;
data_inb = 165;
#10
address_ina = 166;
address_inb = 167;
data_ina = 166;
data_inb = 167;
#10
address_ina = 168;
address_inb = 169;
data_ina = 168;
data_inb = 169;
#10
address_ina = 170;
address_inb = 171;
data_ina = 170;
data_inb = 171;
#10
address_ina = 172;
address_inb = 173;
data_ina = 172;
data_inb = 173;
#10
address_ina = 174;
address_inb = 175;
data_ina = 174;
data_inb = 175;
#10
address_ina = 176;
address_inb = 177;
data_ina = 176;
data_inb = 177;
#10
address_ina = 178;
address_inb = 179;
data_ina = 178;
data_inb = 179;
#10
address_ina = 180;
address_inb = 181;
data_ina = 180;
data_inb = 181;
#10
address_ina = 182;
address_inb = 183;
data_ina = 182;
data_inb = 183;
#10
address_ina = 184;
address_inb = 185;
data_ina = 184;
data_inb = 185;
#10
address_ina = 186;
address_inb = 187;
data_ina = 186;
data_inb = 187;
#10
address_ina = 188;
address_inb = 189;
data_ina = 188;
data_inb = 189;
#10
address_ina = 190;
address_inb = 191;
data_ina = 190;
data_inb = 191;
#10
address_ina = 192;
address_inb = 193;
data_ina = 192;
data_inb = 193;
#10
address_ina = 194;
address_inb = 195;
data_ina = 194;
data_inb = 195;
#10
address_ina = 196;
address_inb = 197;
data_ina = 196;
data_inb = 197;
#10
address_ina = 198;
address_inb = 199;
data_ina = 198;
data_inb = 199;
#10
address_ina = 200;
address_inb = 201;
data_ina = 200;
data_inb = 201;
#10
address_ina = 202;
address_inb = 203;
data_ina = 202;
data_inb = 203;
#10
address_ina = 204;
address_inb = 205;
data_ina = 204;
data_inb = 205;
#10
address_ina = 206;
address_inb = 207;
data_ina = 206;
data_inb = 207;
#10
address_ina = 208;
address_inb = 209;
data_ina = 208;
data_inb = 209;
#10
address_ina = 210;
address_inb = 211;
data_ina = 210;
data_inb = 211;
#10
address_ina = 212;
address_inb = 213;
data_ina = 212;
data_inb = 213;
#10
address_ina = 214;
address_inb = 215;
data_ina = 214;
data_inb = 215;
#10
address_ina = 216;
address_inb = 217;
data_ina = 216;
data_inb = 217;
#10
address_ina = 218;
address_inb = 219;
data_ina = 218;
data_inb = 219;
#10
address_ina = 220;
address_inb = 221;
data_ina = 220;
data_inb = 221;
#10
address_ina = 222;
address_inb = 223;
data_ina = 222;
data_inb = 223;
#10
address_ina = 224;
address_inb = 225;
data_ina = 224;
data_inb = 225;
#10
address_ina = 226;
address_inb = 227;
data_ina = 226;
data_inb = 227;
#10
address_ina = 228;
address_inb = 229;
data_ina = 228;
data_inb = 229;
#10
address_ina = 230;
address_inb = 231;
data_ina = 230;
data_inb = 231;
#10
address_ina = 232;
address_inb = 233;
data_ina = 232;
data_inb = 233;
#10
address_ina = 234;
address_inb = 235;
data_ina = 234;
data_inb = 235;
#10
address_ina = 236;
address_inb = 237;
data_ina = 236;
data_inb = 237;
#10
address_ina = 238;
address_inb = 239;
data_ina = 238;
data_inb = 239;
#10
address_ina = 240;
address_inb = 241;
data_ina = 240;
data_inb = 241;
#10
address_ina = 242;
address_inb = 243;
data_ina = 242;
data_inb = 243;
#10
address_ina = 244;
address_inb = 245;
data_ina = 244;
data_inb = 245;
#10
address_ina = 246;
address_inb = 247;
data_ina = 246;
data_inb = 247;
#10
address_ina = 248;
address_inb = 249;
data_ina = 248;
data_inb = 249;
#10
address_ina = 250;
address_inb = 251;
data_ina = 250;
data_inb = 251;
#10
address_ina = 252;
address_inb = 253;
data_ina = 252;
data_inb = 253;
#10
address_ina = 254;
address_inb = 255;
data_ina = 254;
data_inb = 255;
#10
        wait(init_done);
        #30
        we = 0;

        
        // Start processing 
         
		  #38000  

        start = 0; 
        
        
		  wait(done);

        #70 
		  start = 1;
		 #80 


        $finish; 
    end 

  

endmodule 

 

 