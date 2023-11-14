`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
	initial begin
		`uvm_info("TB_TOP","This is informative message",UVM_MEDIUM);
		#10;
		`uvm_warning("TB_TOP", "This is warning");
		#10;
		`uvm_error("TB_TOP", "This is error");
		#10;
		`uvm_fatal("TB_TOP", "This is fatal error, stopping simulation");
	end
endmodule