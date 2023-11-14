<<<<<<< HEAD
module tb;
	reg [7:0] a; // 256 combinations
 	reg [1:0] b;
	
	integer i = 0;
	
	initial begin
		#100;
		$finish();
	end
	
	
	covergroup c1;
		option.per_instance = 1;
		
		coverpoint a{option.auto_bin_max = 256;}
		coverpoint b;
	endgroup
	
	initial begin
		c1 cI = new();
		for(i=0; i < 10; i++) begin
			a = $urandom();
			b = $urandom();
			cI.sample();
		end
	end
 
=======
module tb;
	reg [7:0] a; // 256 combinations
 	reg [1:0] b;
	
	integer i = 0;
	
	initial begin
		#100;
		$finish();
	end
	
	
	covergroup c1;
		option.per_instance = 1;
		
		coverpoint a{option.auto_bin_max = 256;}
		coverpoint b;
	endgroup
	
	initial begin
		c1 cI = new();
		for(i=0; i < 10; i++) begin
			a = $urandom();
			b = $urandom();
			cI.sample();
		end
	end
 
>>>>>>> origin/main
endmodule