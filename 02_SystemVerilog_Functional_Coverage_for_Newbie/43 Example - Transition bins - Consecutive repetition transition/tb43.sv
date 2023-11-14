<<<<<<< HEAD
module tb();
 
	reg clk = 0;

	reg data[] = {1,0,1,1,0,1,0,1};   
	reg state = 0;
	integer i = 0;

	always #5 clk = ~clk;

	initial begin
		for(i = 0; i< 8; i++) begin
			@(posedge clk);
			state = data[i];
		end
	end

	covergroup c @(posedge clk);
		option.per_instance = 1;
		coverpoint state {
			bins trans_0_1 = (0 => 1[*4]);
		}  
	endgroup

	c ci;

	initial begin
		ci = new();
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#200;
		$finish();
	end
  
=======
module tb();
 
	reg clk = 0;

	reg data[] = {1,0,1,1,0,1,0,1};   
	reg state = 0;
	integer i = 0;

	always #5 clk = ~clk;

	initial begin
		for(i = 0; i< 8; i++) begin
			@(posedge clk);
			state = data[i];
		end
	end

	covergroup c @(posedge clk);
		option.per_instance = 1;
		coverpoint state {
			bins trans_0_1 = (0 => 1[*4]);
		}  
	endgroup

	c ci;

	initial begin
		ci = new();
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#200;
		$finish();
	end
  
>>>>>>> origin/main
endmodule