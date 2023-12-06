module avalon_control(
  /* verilator lint_off UNUSED */
  input clk,
  input reset,
  input [31:0] avs_s0_writedata,
  /* verilator lint_on UNUSED */
  input 		avs_s0_write,
  output 		do_read
);

// Write anything to trigger a write.
// Without a waitrequest from the agent (this module)
// the `write` signal is asserted for exactly one cycle.
assign do_read = avs_s0_write;

endmodule