<<<<<<< HEAD
module tb;
	reg [7:0] y;
	wire [2:0] a;
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint y {
			bins zero = { 8'b00000001};
			wildcard bins one =   {8'b0000001?};
			wildcard bins two =   {8'b000001??};
			wildcard bins three = {8'b00001???};
			wildcard bins four =  {8'b0001????};
			wildcard bins five =  {8'b001?????};
			wildcard bins six =   {8'b01??????};
			wildcard bins seven = {8'b1???????};
		}
		coverpoint a;  
	endgroup

	penc dut (y,a); 

	c ci;
	initial begin
		ci = new();
		for(i = 0; i<300; i++) begin 
			y = $urandom();
			ci.sample();
			#10;  
		end
	end

	initial begin
		#3000;
		$finish();
	end
=======
module tb;
	reg [7:0] y;
	wire [2:0] a;
	integer i = 0;

	covergroup c;
		option.per_instance = 1;
		coverpoint y {
			bins zero = { 8'b00000001};
			wildcard bins one =   {8'b0000001?};
			wildcard bins two =   {8'b000001??};
			wildcard bins three = {8'b00001???};
			wildcard bins four =  {8'b0001????};
			wildcard bins five =  {8'b001?????};
			wildcard bins six =   {8'b01??????};
			wildcard bins seven = {8'b1???????};
		}
		coverpoint a;  
	endgroup

	penc dut (y,a); 

	c ci;
	initial begin
		ci = new();
		for(i = 0; i<300; i++) begin 
			y = $urandom();
			ci.sample();
			#10;  
		end
	end

	initial begin
		#3000;
		$finish();
	end
>>>>>>> origin/main
endmodule