<<<<<<< HEAD
module tb;
	reg [1:0] a;
	integer  i = 0;

	covergroup c (logic [1:0] aV);
		option.per_instance = 1;
		coverpoint a {
			bins f[] = {[0:aV]};
	}

	endgroup 


	initial begin
		c cia = new(1);
		for(i = 0; i< 10; i++) begin
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

endmodule
=======
module tb;
	reg [1:0] a;
	integer  i = 0;

	covergroup c (logic [1:0] aV);
		option.per_instance = 1;
		coverpoint a {
			bins f[] = {[0:aV]};
	}

	endgroup 


	initial begin
		c cia = new(1);
		for(i = 0; i< 10; i++) begin
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

endmodule
>>>>>>> origin/main
