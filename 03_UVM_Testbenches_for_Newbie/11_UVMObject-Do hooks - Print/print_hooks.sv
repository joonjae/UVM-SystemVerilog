`include "uvm_macros.svh"
import uvm_pkg::*;

/////print , deep copy , compare clone pack/unpack record create : core methods
////inbuit implementation / do hooks
 
//field macros

class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	
	rand bit [3:0] data;
	
	function new(string inst = "transaction");
			super.new(inst);
	endfunction
	
	virtual function void do_print(uvm_printer printer);
		super.do_print(printer);
		printer.print_field("data", data, $bits(data), UVM_DEC);
	endfunction
	
endclass

module tb;
	transaction t;
	
	initial begin
		t = new("t");
		t.randomize();
		t.print(uvm_default_line_printer); ///tree table(default) line
	end
endmodule