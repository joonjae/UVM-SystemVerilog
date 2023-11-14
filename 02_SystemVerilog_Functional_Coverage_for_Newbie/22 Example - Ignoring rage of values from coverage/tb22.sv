<<<<<<< HEAD
module tb;
	reg [5:0] a;
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			ignore_bins unused_range1 [] = {[3:7]};
			ignore_bins unused_range2 [] = {[32:36]};
			ignore_bins unused_range3 [] = {[47:50]};
			ignore_bins unused_range4 [] = {[61:64]};
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
	reg [5:0] a;
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			ignore_bins unused_range1 [] = {[3:7]};
			ignore_bins unused_range2 [] = {[32:36]};
			ignore_bins unused_range3 [] = {[47:50]};
			ignore_bins unused_range4 [] = {[61:64]};
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