/* 
Write UVM code to throw a warning at 50 nsec, error at 100 nsec, 
and forcefully stop the simulation at 200 nsec from testbench top.

Use UVM reporting macros

*/
`include "uvm_macros.svh"

import uvm_pkg::*;

module tb;
		
	initial begin
		`uvm_info("TB_TOP","This is informative message",UVM_MEDIUM);
		#50;
		`uvm_warning("TB_TOP", "This is warning");
		#50;
		`uvm_error("TB_TOP", "This is error");
		#100;
		`uvm_fatal("TB_TOP", "This is fatal error, stopping simulation");
	end
	
endmodule