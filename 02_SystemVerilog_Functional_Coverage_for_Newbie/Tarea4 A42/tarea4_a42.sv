/*
Create a stimulus for 100 % coverage of signal eout (output of the Priority Encoder) 
for all the possible combinations of the pin (Input to the Priority Encoder). 
Prefer Wildcard bins.
*/

module tb;
	reg [4:0] pin;
	wire [1:0] eout;
	
	p_enc dut(pin,eout);
	
	covergroup c;
		option.per_instance = 1;
		coverpoint pin{
			bins 			pin00 = {4'b0001};
			wildcard bins 	pin01 = {4'b001?};
			wildcard bins 	pin10 = {4'b01??};
			wildcard bins 	pin11 = {4'b1???};
		}
		coverpoint eout;
	endgroup
	
	c ci;
	initial begin
      ci = new();
      
      pin = 4'b0001;
      #10;
      ci.sample();
      pin = 4'b0010 | $urandom_range(0,2);
      #10;		
      ci.sample();
      pin = 4'b0100 | $urandom_range(0,4);
      #10;		
      ci.sample();
      pin = 4'b1000 | $urandom_range(0,8);
      #10;		
      ci.sample();
	end
	
	initial begin
		$dumpfile("dump.vcd");
		$dumpvars;
		#50;
		$finish();
	end
endmodule

