<<<<<<< HEAD
module tb;
 
	reg [1:0] a;
	reg [1:0] b;
	// reg [2:0] cc;
	integer i = 0;

	covergroup c ( ref logic [1:0] varb, input string name);
		option.name = name;
		option.per_instance = 1;
		coverpoint varb;   
	endgroup 


	initial begin
		c cia = new(a, "Coverage of Variable a");
		c cib = new(b, "Coverage of Variable b");
		//   c cic = new(cc, "Coverage of Variable c"); 

		for(i = 0; i < 10; i++) begin
			a = $urandom();
			b = $urandom();
			cia.sample();
			cib.sample();
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
 
	reg [1:0] a;
	reg [1:0] b;
	// reg [2:0] cc;
	integer i = 0;

	covergroup c ( ref logic [1:0] varb, input string name);
		option.name = name;
		option.per_instance = 1;
		coverpoint varb;   
	endgroup 


	initial begin
		c cia = new(a, "Coverage of Variable a");
		c cib = new(b, "Coverage of Variable b");
		//   c cic = new(cc, "Coverage of Variable c"); 

		for(i = 0; i < 10; i++) begin
			a = $urandom();
			b = $urandom();
			cia.sample();
			cib.sample();
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