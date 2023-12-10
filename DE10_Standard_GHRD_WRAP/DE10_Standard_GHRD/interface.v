module interface(
	//***********input***************
	input wire  		clk_top,
	input wire 			aclr_fifo1_top,
	input wire 			wr_clk_fifo1_top,
	input wire			rd_req_fifo1_top,
	input wire 			wr_req_fifo1_top,
	
	input wire [31:0] wr_data1_fifo1_top,
	input wire [31:0] wr_data2_fifo2_top,

	input wire 			sel_mux1_top,
	input wire 			sel_mux2_top,
	
	input wire 			mode_top,
	input wire 			start_top,
	input wire 			we_top,
	input wire 			rst_top,

	input wire 			read_clk_top,
	input wire 			write_clk_top,

	
	input wire 			aclr_fifo3_top,
	input wire			rd_clk_fifo3_top,
//	input wire 			wr_req_fifo3_top,
	input wire 			rd_req_fifo3_top,
	//***********output***************
	output wire 			wr_full_fifo1_top,
	output wire 			[8:0] wr_used_fifo1_top,
	output wire				rd_empty_fifo1_top,
	output wire 			[8:0] rd_used_fifo1_top,
	
	output wire 			wr_full_fifo2_top,
	output wire 			[8:0] wr_used_fifo2_top,
	output wire				rd_empty_fifo2_top,
	output wire 			[8:0] rd_used_fifo2_top,
	
	output wire 			in_done_top,
	output wire 			done_top,
	
	output wire 			wr_full_fifo3_top,
	output wire 			[8:0] wr_used_fifo3_top,
	output wire				rd_empty_fifo3_top,
	output wire 			[8:0] rd_used_fifo3_top,
	output wire 			[31:0]	rd_data_fifo3_top,
	output wire 			init_done
	);
wire [31:0]	rd_data1,rd_data2;
wire read_clk;
wire write_clk;
fifo fifo1(
	.aclr(aclr_fifo1_top),

	.rd_dat(rd_data1),
	.rd_clk(read_clk),
	.rd_req(rd_req_fifo1_top),
	
	.rd_empty(rd_empty_fifo1_top),
	.rd_used(rd_used_fifo1_top),

	.wr_dat(wr_data1_fifo1_top),
	.wr_clk(wr_clk_fifo1_top),
	.wr_req(wr_req_fifo1_top),
	
	.wr_full(wr_full_fifo1_top),
	.wr_used(wr_used_fifo1_top)
);

fifo fifo2(
	.aclr(aclr_fifo1_top),

	.rd_dat(rd_data2),
	.rd_clk(read_clk),
	.rd_req(rd_req_fifo1_top),
	
	.rd_empty(rd_empty_fifo2_top),
	.rd_used(rd_used_fifo2_top),

	.wr_dat(wr_data2_fifo2_top),
	.wr_clk(wr_clk_fifo1_top),
	.wr_req(wr_req_fifo1_top),
	
	.wr_full(wr_full_fifo2_top),
	.wr_used(wr_used_fifo2_top)
);
/*
always @(*) begin
	case(sel_mux1_top)
	1'b0:begin
		read_clk = clk_top;
	end
	1'b1:begin
		read_clk = read_clk_top;
	end
	endcase
end
*/
assign  read_clk = (sel_mux1_top==1'b1)?read_clk_top:clk_top;
wire [15:0] data_ina,data_inb,data_out1,data_out2;
wire [7:0] address_ina,address_inb;
wrap top(
	//***********input***************
    .clk(clk_top),
    .rst(rst_top),
    .start(start_top),
    .mode(mode_top), 
	 .we(we_top),
	 .address_ina(address_ina),
	 .address_inb(address_inb),
 	//***********output***************
    .data_ina(data_ina),
	 .data_inb(data_inb),
	 .data_out1(data_out1),
	 .data_out2(data_out2),
    .in_done(in_done_top),
    .cal_done(cal_done),
    .done(done_top),
	 .init_done(init_done)
);
assign rd_data1[23:16] = address_ina;
assign rd_data1[15:0] = data_ina;

assign rd_data2[23:16] = address_inb;
assign rd_data2[15:0] = data_inb;
/*
always @(*) begin
	case(sel_mux2_top)
	1'b0:begin
		write_clk = clk_top;
	end
	1'b1:begin
		write_clk = write_clk_top;
	end
	endcase
end
*/
assign  write_clk = (sel_mux2_top==1'b1)?write_clk_top:clk_top;
fifo fifo3(
	.aclr(aclr_fifo3_top),

	.rd_dat(rd_data_fifo3_top),
	.rd_clk(rd_clk_fifo3_top),
	.rd_req(rd_req_fifo3_top),
	.rd_empty(rd_empty_fifo3_top),
	.rd_used(rd_used_fifo3_top),

	.wr_dat({data_out2,data_out1}),
	.wr_clk(write_clk),
	.wr_req(cal_done),
	.wr_full(wr_full_fifo3_top),
	.wr_used(wr_used_fifo3_top)
);
endmodule 