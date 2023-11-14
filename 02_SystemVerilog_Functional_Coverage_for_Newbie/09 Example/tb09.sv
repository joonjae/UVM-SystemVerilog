<<<<<<< HEAD
module tb;
	reg [3:0] a;
	
	integer i;
	
	initial begin
		#100;
		$finish();
	end
	
	///////(1) Values of a = 16 , create 4 bins evenly disttibuted case
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 4;
		}
	endgroup
	*/
	/////// (2) Values of a = 16, create 3 bins uneven distribution case
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 3;
		}
	endgroup
	*/
	//////// (3) values of a = 16 , bins = 16
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 16;
		}
	endgroup
	*/
	///////// (4) values of a = 16, bins = 64
	covergroup c;
		option.per_instance = 1;
		coverpoint a {
			option.auto_bin_max = 64;
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
	
	///////(1) Values of a = 16 , create 4 bins evenly disttibuted case
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 4;
		}
	endgroup
	*/
	/////// (2) Values of a = 16, create 3 bins uneven distribution case
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 3;
		}
	endgroup
	*/
	//////// (3) values of a = 16 , bins = 16
	/*
	covergroup c;
		option.per_instance = 1;
		coverpoint a{
			option.auto_bin_max = 16;
		}
	endgroup
	*/
	///////// (4) values of a = 16, bins = 64
	covergroup c;
		option.per_instance = 1;
		coverpoint a {
			option.auto_bin_max = 64;
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