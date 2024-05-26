module tb_counter_4bit();

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
		rst_n=0;
                sel=0;
		clk = 1'b0;
		forever #5 clk = ~clk;
	end
	
	
	
	initial begin
		$shm_open("tb.shm");
		$shm_probe("AS");
	end
	
	initial begin
           #20 rst_n=1;
           sel=1;
           #100  
   	   sel=0;
	   #50
           sel=1;
           #100 rst_n=0;
           #100
	   $finish;
        end
	
endmodule
