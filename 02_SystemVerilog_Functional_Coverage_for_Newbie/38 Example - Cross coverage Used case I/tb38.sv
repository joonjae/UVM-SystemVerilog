<<<<<<< HEAD
module tb;   
	reg wr;
	reg [3:0] addr;
	
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint wr{
			bins wr_low = {0};
			bins wr_high = {1};
		}
		
		coverpoint addr;
/*
		coverpoint addr{
			bins lower_addr = {[0:3]};
			bins mid_addr = {[4:11]};
			bins high_addr = {[12:15]};
		}
*/		
		cross wr, addr;
	endgroup
	
	c ci;

	initial begin
		ci = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			ci.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#500;
		$finish();
	end
=======
module tb;   
	reg wr;
	reg [3:0] addr;
	
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint wr{
			bins wr_low = {0};
			bins wr_high = {1};
		}
		
		coverpoint addr;
/*
		coverpoint addr{
			bins lower_addr = {[0:3]};
			bins mid_addr = {[4:11]};
			bins high_addr = {[12:15]};
		}
*/		
		cross wr, addr;
	endgroup
	
	c ci;

	initial begin
		ci = new();
		for (i = 0; i <50; i++) begin
			addr = $urandom();
			wr = $urandom();
			ci.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#500;
		$finish();
	end
>>>>>>> origin/main
endmodule