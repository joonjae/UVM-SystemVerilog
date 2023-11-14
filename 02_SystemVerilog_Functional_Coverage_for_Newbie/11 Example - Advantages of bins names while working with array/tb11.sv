<<<<<<< HEAD
module tb;
	reg [1:0] sel;
	reg [3:0] model;
	
	integer i;
	
	initial begin
		#100;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint sel{
			bins sel[] = {[0:3]};
			}
		coverpoint model{
			bins model[]={[0:15]};
		}
	endgroup
	
	initial begin
		c ci=new();
		for(i=0; i<10; i++)begin
			sel = $urandom();
			model = $urandom();
			ci.sample;
		end
	end
	
	
=======
module tb;
	reg [1:0] sel;
	reg [3:0] model;
	
	integer i;
	
	initial begin
		#100;
		$finish();
	end
	
	covergroup c;
		option.per_instance = 1;
		coverpoint sel{
			bins sel[] = {[0:3]};
			}
		coverpoint model{
			bins model[]={[0:15]};
		}
	endgroup
	
	initial begin
		c ci=new();
		for(i=0; i<10; i++)begin
			sel = $urandom();
			model = $urandom();
			ci.sample;
		end
	end
	
	
>>>>>>> origin/main
endmodule