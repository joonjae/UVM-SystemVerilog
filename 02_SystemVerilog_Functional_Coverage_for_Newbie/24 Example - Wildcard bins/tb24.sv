<<<<<<< HEAD
module tb;

	reg [3:0] a; 
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint a {
			wildcard bins def_a = {4'b00zz};
		}  
	endgroup 

	c ci;
	initial begin
		ci = new();
		#10;
		a = 4'b0011;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0001;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0010;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0010;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0000;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end

=======
module tb;

	reg [3:0] a; 
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint a {
			wildcard bins def_a = {4'b00zz};
		}  
	endgroup 

	c ci;
	initial begin
		ci = new();
		#10;
		a = 4'b0011;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0001;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0010;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0010;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
		a = 4'b0000;
		$display("Value of a : %b",a);
		ci.sample();
		#10;
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#400;
		$finish();
	end

>>>>>>> origin/main
endmodule