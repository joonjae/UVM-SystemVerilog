<<<<<<< HEAD
module tb;
	reg [3:0] a;
	
	integer i;
	
	initial begin
		#100;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins aV[4] = {[0:8],0,1,2};
			}
	endgroup
	
	initial begin
		c ci=new();
		for(i=0; i<10; i++)begin
			a = $urandom();
			ci.sample;
		end
	end
	
	
=======
module tb;
	reg [3:0] a;
	
	integer i;
	
	initial begin
		#100;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			bins aV[4] = {[0:8],0,1,2};
			}
	endgroup
	
	initial begin
		c ci=new();
		for(i=0; i<10; i++)begin
			a = $urandom();
			ci.sample;
		end
	end
	
	
>>>>>>> origin/main
endmodule