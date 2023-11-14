<<<<<<< HEAD
module tb;
	reg [3:0] a; // 0 - 7
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins used_a[] = {[0:7]};
			bins unused_a = default;
		}
		
	endgroup
	
	c ci;
	initial begin
		ci = new();
		for(i=0; i<40; i++)begin
			a = $urandom_range(0,8);
			
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
	reg [3:0] a; // 0 - 7
	integer i = 0;
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins used_a[] = {[0:7]};
			bins unused_a = default;
		}
		
	endgroup
	
	c ci;
	initial begin
		ci = new();
		for(i=0; i<40; i++)begin
			a = $urandom_range(0,8);
			
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