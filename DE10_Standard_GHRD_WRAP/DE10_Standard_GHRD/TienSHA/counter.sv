/* Keccak Core
	Module: counter
	Date: 21/12/2021
	Author: Tran Cong Tien
	ID: 1810580
*/

module counter(clk, rst_n, en_counter, round_num);
	input		clk;
	input		rst_n;
	input		en_counter;
	output logic	[4:0] round_num;

always_ff @(posedge clk or negedge rst_n)
begin
	if (!rst_n) round_num <= 0; 
	else 
	begin
		if (!en_counter) round_num <= 0;
			else
			    begin 
				if (round_num == 24) round_num <= 0;
				else
			    	round_num <= round_num + 1;
			    end
	end
end
endmodule