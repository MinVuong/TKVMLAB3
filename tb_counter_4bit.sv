module counter_4bit_tb();

	logic clk;
	logic rst_n;
	logic sel;
	logic [3:0] out;
	
	synth_wrapper counter_4bit(
		.clk(clk),
		.rst_n(rst_n),
		.sel(sel),
		.out(out)
		);
		
	initial begin
		#0;
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	initial begin
		run_test();
	end
	
	initial begin
		$shm_open("tb.shm");
		$shm_probe("AS");
	end
	
	task run_test();
		#0;
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
		repeat (100) @(posedge clk)
			sel = $urandom() % 2;
			//sel = 1'b1;
		
		#100;
		$finish;
	endtask
	
	task cnt_rst_test();
		#0;
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
		sel= 1'b1;
		#100;
		$finish;
	endtask
	
	task cnt_up_test();
		#0;
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
		sel = 1'b1;
		#100;
		$finish;
	endtask
	
	task cnt_down_test();
		#0;
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
		sel= 1'b0;
		#100;
		$finish;
	endtask
	
	bit flag_check = 1'b0;
	
	task cnt_max_test();
		#0;
		rst_n = 1'b0;
		#20;
		rst_n = 1'b1;
		sel= 1'b1;
		repeat(100) @(posedge clk) begin
			#1;
			if (out == 4'b1111) flag_check = 1'b1;
			else if ((out== 4'b0000) & (!flag_check)) begin
						$display("Failed");
						$finish;
					end
			else flag_check = 1'b0;
		end
		#100;
		$finish;
	endtask
	
	
	task cnt_min_test();
		#0;
		rst_n = 1'b0;
		//flag_check = 1'b0;
		#20;
		rst_n = 1'b1;
		sel = 1'b0;
		repeat(100) @(posedge clk) begin
			#1;
			if (out == 4'b0000) flag_check = 1'b1;
			else if ((out == 4'b1111) & (!flag_check)) begin
						$display("Failed");
						$finish;
					end
			else flag_check = 1'b0;
		end
		#100;
		$finish;
	endtask
	
endmodule
