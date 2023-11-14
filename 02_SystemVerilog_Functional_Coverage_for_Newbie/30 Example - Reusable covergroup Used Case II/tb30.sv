<<<<<<< HEAD
module tb;

	reg [3:0] mode;
	integer i = 0;

	/// 0 - 3 : Arithmetic
	// 4 - 7 : Logical
	// 8 - 11 : Shift
	//12 -15 : Jump

	covergroup check_mode (input int lower, input int high, input string inst_name);
		option.per_instance = 1;
		option.name = inst_name;
		coverpoint mode {
			bins f[] = {[lower: high]};     
		} 
	endgroup 

	initial begin
		check_mode ca = new(0,3,"Arithmetic Operation Coverage");
		check_mode cl = new(4,7,"Logical Operation Coverage");
		check_mode cs = new(8,11,"Shift Operation Coverage");
		check_mode cj = new(12,15,"Jump Operation Coverage");

		for (i = 0; i <20; i++) begin
			mode = $urandom();
			ca.sample();
			cl.sample();
			cs.sample();
			cj.sample();
			#10;
		end   
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#200;
		$finish();
	end

=======
module tb;

	reg [3:0] mode;
	integer i = 0;

	/// 0 - 3 : Arithmetic
	// 4 - 7 : Logical
	// 8 - 11 : Shift
	//12 -15 : Jump

	covergroup check_mode (input int lower, input int high, input string inst_name);
		option.per_instance = 1;
		option.name = inst_name;
		coverpoint mode {
			bins f[] = {[lower: high]};     
		} 
	endgroup 

	initial begin
		check_mode ca = new(0,3,"Arithmetic Operation Coverage");
		check_mode cl = new(4,7,"Logical Operation Coverage");
		check_mode cs = new(8,11,"Shift Operation Coverage");
		check_mode cj = new(12,15,"Jump Operation Coverage");

		for (i = 0; i <20; i++) begin
			mode = $urandom();
			ca.sample();
			cl.sample();
			cs.sample();
			cj.sample();
			#10;
		end   
	end

	initial begin
		$dumpfile("dump.vcd"); 
		$dumpvars;
		#200;
		$finish();
	end

>>>>>>> origin/main
endmodule