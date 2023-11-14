<<<<<<< HEAD
module tb;
	reg [3:0] a;
	reg [1:0] b;
	reg [4:0] cin;
	
	integer i = 0;
	
	/*
	covergroup c;
		coverpoint a{
			bins va[] = {[0:3]};
		}
		coverpoint b{
			bins vb[] = {0,1};
		}
		
		coverpoint cin{
			bins vc[] = {[25:27]};
		}
		
		cross_b_a: cross b,a;
		cross_b_cin: cross b,cin;
		cross_a_b_cin: cross b,a,cin;
	endgroup
	*/

	covergroup c;
		option.per_instance = 1;
		coverpoint a;
		coverpoint b;
		coverpoint cin;
		
		cross_a_b: cross b,a{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_a = binsof(a) intersect {4,15};
		}
		cross_com_b: cross b,cin{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_cin = binsof(cin) intersect {[0:24],[28:31]};
		}
		cross_a_b_cin: cross b,a,cin{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_a = binsof(a) intersect{[4:15]};
			ignore_bins unused_cin = binsof(cin) intersect{[0:24],[28:31]};
		}
	endgroup

	c ci;
	initial begin
		ci = new();
		for (i = 0; i <100; i++) begin
			a = $urandom();
			b = $urandom();
			cin = $urandom();
			ci.sample();
			#10;
		end  
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#1000;
		$finish();
	end  
=======
module tb;
	reg [3:0] a;
	reg [1:0] b;
	reg [4:0] cin;
	
	integer i = 0;
	
	/*
	covergroup c;
		coverpoint a{
			bins va[] = {[0:3]};
		}
		coverpoint b{
			bins vb[] = {0,1};
		}
		
		coverpoint cin{
			bins vc[] = {[25:27]};
		}
		
		cross_b_a: cross b,a;
		cross_b_cin: cross b,cin;
		cross_a_b_cin: cross b,a,cin;
	endgroup
	*/

	covergroup c;
		option.per_instance = 1;
		coverpoint a;
		coverpoint b;
		coverpoint cin;
		
		cross_a_b: cross b,a{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_a = binsof(a) intersect {4,15};
		}
		cross_com_b: cross b,cin{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_cin = binsof(cin) intersect {[0:24],[28:31]};
		}
		cross_a_b_cin: cross b,a,cin{
			ignore_bins unused_b = binsof(b) intersect{2,3};
			ignore_bins unused_a = binsof(a) intersect{[4:15]};
			ignore_bins unused_cin = binsof(cin) intersect{[0:24],[28:31]};
		}
	endgroup

	c ci;
	initial begin
		ci = new();
		for (i = 0; i <100; i++) begin
			a = $urandom();
			b = $urandom();
			cin = $urandom();
			ci.sample();
			#10;
		end  
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#1000;
		$finish();
	end  
>>>>>>> origin/main
endmodule