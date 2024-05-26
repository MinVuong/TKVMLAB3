
module counter_4bit(
	input logic clk,
	input logic rst_n,
	input logic sel,
	output logic [3:0] out
	);
	
	logic [3:0] add_tmp, sub_tmp, out_tmp;
	
	adder_4bit A0(out_tmp, 4'b1, add_tmp);
	subtractor_4bit S0(out_tmp, 4'b1, sub_tmp);

	always_ff @(posedge clk or negedge rst_n) begin
		if (!rst_n) out_tmp <= 4'b0;
		else begin
			if (sel) out_tmp <= add_tmp;
			else if (!sel) out_tmp <= sub_tmp;
			else out_tmp <= out;
		end
	end
	
	assign out = out_tmp;
	
endmodule
