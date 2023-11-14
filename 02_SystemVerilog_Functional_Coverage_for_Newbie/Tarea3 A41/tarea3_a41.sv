/*
Create a stimulus for 100 % coverage of signal y. 
Create two explicit bins, one working with all 
the possible values of a (00,01,10,11) when sel is high 
and the other working with all the possible values of b when sel is low.

Do not Use Cross Coverage, Prefer Wildcard bins.
*/

module tb;
	reg [1:0] a=0,b=0;
	reg sel=0;
	wire [1:0] y;
	
	integer i;
	
	mux_2 dut(a,b,sel,y);
	
	covergroup c;
		option.per_instance = 1;
		coverpoint {sel,a}{
			wildcard bins normal_a = {3'b1??};
		} 
		coverpoint {sel,b}{
			wildcard bins normal_b = {3'b0??};
		}
		coverpoint y;
	endgroup
	
	c ci;
	initial begin
		ci = new();
		sel = 1;
		for(i=0;i<4;i++)begin
			a = i;
			ci.sample();
			#10;
		end
		sel = 0;
		for(i=0;i<4;i++)begin
			b = i;
			ci.sample();
			#10;
		end
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#100
		$finish();
	end
	
endmodule

