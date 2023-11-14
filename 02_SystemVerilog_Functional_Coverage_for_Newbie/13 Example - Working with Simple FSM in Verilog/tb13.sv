<<<<<<< HEAD
module tb;
	  
	reg clk = 0;
	reg reset = 0;
	reg din = 0;
	wire dout;

	covergroup c ;
	option.per_instance = 1;
	coverpoint dut.state;
	endgroup

	fsm dut (clk,reset,din, dout);

	always #5 clk = ~clk;

	initial begin
		reset = 1;
		#30;
		reset = 0;
		#40;
		din = 1;
	end

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
		#200;
		$finish();
	end
=======
module tb;
	  
	reg clk = 0;
	reg reset = 0;
	reg din = 0;
	wire dout;

	covergroup c ;
	option.per_instance = 1;
	coverpoint dut.state;
	endgroup

	fsm dut (clk,reset,din, dout);

	always #5 clk = ~clk;

	initial begin
		reset = 1;
		#30;
		reset = 0;
		#40;
		din = 1;
	end

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
		#200;
		$finish();
	end
>>>>>>> origin/main
endmodule