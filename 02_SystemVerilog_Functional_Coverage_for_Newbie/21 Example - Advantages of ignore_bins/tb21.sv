<<<<<<< HEAD
module tb;
	reg [7:0] a;
	integer i = 0;
		
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins used_a [] = {[0:100]};
			ignore_bins unused_a [] = {23,45,67,89,93};
		}
		
	endgroup
	
	c ci;
	initial begin
		ci = new();
		for(i=0; i<40; i++)begin
			a = $urandom();
			
			ci.sample();
			#10;
		end
	end
	
	initial begin
		#400;
		$finish();
	end
	
=======
module tb;
	reg [7:0] a;
	integer i = 0;
		
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins used_a [] = {[0:100]};
			ignore_bins unused_a [] = {23,45,67,89,93};
		}
		
	endgroup
	
	c ci;
	initial begin
		ci = new();
		for(i=0; i<40; i++)begin
			a = $urandom();
			
			ci.sample();
			#10;
		end
	end
	
	initial begin
		#400;
		$finish();
	end
	
>>>>>>> origin/main
endmodule