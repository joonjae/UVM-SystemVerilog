<<<<<<< HEAD
module tb;
	reg clk = 0;
	reg reset = 0;
	reg din = 0;
	wire dout;

	state_mach dut (reset,clk,din, dout);

	always #5 clk = ~clk;

	initial begin
		reset = 1;
		#30;
		reset = 0;
		#40;
		din = 1;
	end

	covergroup c;
		option.per_instance = 1;    
		coverpoint dut.state;     
	endgroup

	c cia;

	initial begin
		cia = new();
		forever begin
			@(posedge clk);
			cia.sample();
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#300;
		$finish();
	end
   
=======
module tb;
	reg clk = 0;
	reg reset = 0;
	reg din = 0;
	wire dout;

	state_mach dut (reset,clk,din, dout);

	always #5 clk = ~clk;

	initial begin
		reset = 1;
		#30;
		reset = 0;
		#40;
		din = 1;
	end

	covergroup c;
		option.per_instance = 1;    
		coverpoint dut.state;     
	endgroup

	c cia;

	initial begin
		cia = new();
		forever begin
			@(posedge clk);
			cia.sample();
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#300;
		$finish();
	end
   
>>>>>>> origin/main
endmodule