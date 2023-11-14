<<<<<<< HEAD


module tb;
   
	reg clk = 0, din = 0, rst = 0;
	wire dout;
	
	fsm dut (clk,din,rst,dout);

	always #5 clk = ~clk;
  
	initial begin
		repeat(4) @(posedge clk) {rst, din} = 2'b10;
		repeat(4) @(posedge clk) {rst, din} = 2'b01;
		repeat(4) @(posedge clk) {rst, din} = 2'b10;
		repeat(1) @(posedge clk) {rst, din} = 2'b01;
		repeat(4) @(posedge clk) {rst, din} = 2'b00;
	end
  
	covergroup cv @(posedge clk);
		option.per_instance = 1;
		coverpoint rst{
			bins rst_l = {0};
			bins rst_h = {1};
		}
		coverpoint din{
			bins din_h = {1};
		}
		coverpoint dout{
			bins dout_l = {0};
			bins dout_h = {1};
		}

		coverpoint dut.state{
			bins trans_s0_s1 = (dut.s0 => dut.s1);
			bins trans_s1_s0 = (dut.s1 => dut.s0);
		}
		cross din,dut.state;
	endgroup

	covergroup c2 @(posedge clk);
		option.per_instance = 1;

		coverpoint din {
			bins din_l = {0};
		}

		coverpoint dut.state {
			bins trans_s0_S0 = (dut.s0 => dut.s0);      
			bins trans_s1_S1 = (dut.s1 => dut.s1);
		}
		cross din,dut.state;
	endgroup

	cv ci;
	c2 ci2;

	initial begin
	ci = new();
	ci2 = new();
	$dumpfile("dump.vcd"); 
	$dumpvars;
	#500;
	$finish();
	end

=======


module tb;
   
	reg clk = 0, din = 0, rst = 0;
	wire dout;
	
	fsm dut (clk,din,rst,dout);

	always #5 clk = ~clk;
  
	initial begin
		repeat(4) @(posedge clk) {rst, din} = 2'b10;
		repeat(4) @(posedge clk) {rst, din} = 2'b01;
		repeat(4) @(posedge clk) {rst, din} = 2'b10;
		repeat(1) @(posedge clk) {rst, din} = 2'b01;
		repeat(4) @(posedge clk) {rst, din} = 2'b00;
	end
  
	covergroup cv @(posedge clk);
		option.per_instance = 1;
		coverpoint rst{
			bins rst_l = {0};
			bins rst_h = {1};
		}
		coverpoint din{
			bins din_h = {1};
		}
		coverpoint dout{
			bins dout_l = {0};
			bins dout_h = {1};
		}

		coverpoint dut.state{
			bins trans_s0_s1 = (dut.s0 => dut.s1);
			bins trans_s1_s0 = (dut.s1 => dut.s0);
		}
		cross din,dut.state;
	endgroup

	covergroup c2 @(posedge clk);
		option.per_instance = 1;

		coverpoint din {
			bins din_l = {0};
		}

		coverpoint dut.state {
			bins trans_s0_S0 = (dut.s0 => dut.s0);      
			bins trans_s1_S1 = (dut.s1 => dut.s1);
		}
		cross din,dut.state;
	endgroup

	cv ci;
	c2 ci2;

	initial begin
	ci = new();
	ci2 = new();
	$dumpfile("dump.vcd"); 
	$dumpvars;
	#500;
	$finish();
	end

>>>>>>> origin/main
endmodule