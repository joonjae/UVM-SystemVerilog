<<<<<<< HEAD
module tb; 
	reg [1:0] a = 0;
	reg clk = 0;
	integer i = 0;

	always #5 clk = ~clk;

	covergroup c ;
		option.per_instance = 1;
		coverpoint a;
	endgroup

	c ci; 
	initial begin
		ci = new();
		for (i = 0; i <40; i++) begin
			@(posedge clk);
			a = $urandom();
			ci.sample();
		end
	end
	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end
=======
module tb; 
	reg [1:0] a = 0;
	reg clk = 0;
	integer i = 0;

	always #5 clk = ~clk;

	covergroup c ;
		option.per_instance = 1;
		coverpoint a;
	endgroup

	c ci; 
	initial begin
		ci = new();
		for (i = 0; i <40; i++) begin
			@(posedge clk);
			a = $urandom();
			ci.sample();
		end
	end
	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end
>>>>>>> origin/main
endmodule