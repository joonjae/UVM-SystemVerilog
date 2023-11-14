/*
Create a stimulus for 2:1 mux to cover following behavior of design.
1) Cover all the possible values of sel line
2) Cover all the possible values of a,b
3) Cover all the possible values of y
*/

module tb;
	reg a,b;
	reg sel;
	wire y;
	
	mux dut(a,b,sel,y);
	
	covergroup c;
		option.per_instance = 1;
		coverpoint a;
		coverpoint b;
		coverpoint sel;
		coverpoint dut.y;
	endgroup
	
	c ci;
	initial begin
		ci = new();
		sel = 0;
		repeat(10) begin
			a = $urandom();
			b = $urandom();
			#5;
			$display("sel=%d, a=%d, b=%d, y=%d", sel, a, b, dut.y);
			ci.sample();
			#5;
		end
		sel = 1;
		repeat(10) begin
			a = $urandom();
			b = $urandom();
			#5;
			$display("sel=%d, a=%d, b=%d, y=%d", sel, a, b, dut.y);
			ci.sample();
			#5;
		end
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars();
		#200;
		$finish;
	end
	
endmodule

