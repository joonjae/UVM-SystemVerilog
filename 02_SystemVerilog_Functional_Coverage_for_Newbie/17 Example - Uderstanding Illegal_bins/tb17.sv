<<<<<<< HEAD
module tb;
	reg rst=0, clk=0, din=0;
	wire dout;
	
	state_mach dut (rst, clk, din, dout);
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		#30;
		rst = 0;
		#40;
		din = 1;
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint dut.state{
			bins fsm_state[] = {0,1,2};
			illegal_bins unused_state = {3};
		}		
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		forever begin
			@(posedge clk);
			ci.sample();
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
	reg rst=0, clk=0, din=0;
	wire dout;
	
	state_mach dut (rst, clk, din, dout);
	
	always #5 clk = ~clk;
	
	initial begin
		rst = 1;
		#30;
		rst = 0;
		#40;
		din = 1;
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint dut.state{
			bins fsm_state[] = {0,1,2};
			illegal_bins unused_state = {3};
		}		
	endgroup
	
	c ci;
	
	initial begin
		ci = new();
		forever begin
			@(posedge clk);
			ci.sample();
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