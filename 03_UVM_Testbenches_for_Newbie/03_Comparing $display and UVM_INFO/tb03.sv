`include "uvm_macros.svh"
import uvm_pkg::*;

module tb;
	initial begin
		#10;
		`uvm_info("TB_TOP", "Hello world: uvm_info", UVM_MEDIUM); //id, msg, verbosity
		$display("Hello world : $display @ %0t",$time);
	end
endmodule