<<<<<<< HEAD
module tb;

	reg [3:0] a;
	reg [1:0] b;
	integer i = 0;
	/* 
	covergroup check_var (ref logic [3:0] var_name);
		option.per_instance = 1;
		coverpoint var_name;
	endgroup  
	*/

	/*
	covergroup check_var (int var_value);
		option.per_instance = 1;
		coverpoint a {
			bins f[] = {[0:var_value]};
		}
	endgroup
	*/

	covergroup check_var (ref logic [3:0] var_name, input int var_value);
		option.per_instance = 1;
		coverpoint var_name {
			bins f[] = {[0:var_value]};
		}
	endgroup

	initial begin
		check_var cia = new(a,5);
		for(i = 0; i < 10; i++) begin
			a = $urandom();
			cia.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#100;
		$finish();
	end

=======
module tb;

	reg [3:0] a;
	reg [1:0] b;
	integer i = 0;
	/* 
	covergroup check_var (ref logic [3:0] var_name);
		option.per_instance = 1;
		coverpoint var_name;
	endgroup  
	*/

	/*
	covergroup check_var (int var_value);
		option.per_instance = 1;
		coverpoint a {
			bins f[] = {[0:var_value]};
		}
	endgroup
	*/

	covergroup check_var (ref logic [3:0] var_name, input int var_value);
		option.per_instance = 1;
		coverpoint var_name {
			bins f[] = {[0:var_value]};
		}
	endgroup

	initial begin
		check_var cia = new(a,5);
		for(i = 0; i < 10; i++) begin
			a = $urandom();
			cia.sample();
			#10;
		end
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#100;
		$finish();
	end

>>>>>>> origin/main
endmodule