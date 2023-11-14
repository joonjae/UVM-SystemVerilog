`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
	int verbosity = 0;
	initial begin
		//verbosity = uvm_top.get_report_verbosity_level();
		//$display("Default verbosity level: %0d", verbosity);
		//`uvm_info("TB_TOP","This is informative message of UVM_LOW", UVM_LOW);
		
		uvm_top.Set_report_verbosity_level(UVM_HIGH);
		`uvm_info("TB_TOP","This is informative message of UVM_HIGH", UVM_HIGH);
		verbosity = uvm_top.get_report_verbosity_level();
		$display("UVM_HIGH verbosity level: %0d", verbosity);
	end
endmodule