/*
Write a UVM code to use do_hook and create method.

Create a class (my_transaction) by extending uvm_object. 
Add three data members of int type in the class and initialize 
them to the value of 4, 5, and 6. Use create a method to create 
an object of the my_transaction in the testbench top and print 
the values of all the variables by using the do_hook implementation 
of a Print method.

*/

`include "uvm_macros.svh"
import uvm_pkg::*;

class my_transaction extends uvm_object;
	`uvm_object_utils(my_transaction)
	int a;
	int b;
	int c;
	
	function new(string inst = "my_transaction");
		super.new(inst);
	endfunction
	
	virtual function void do_print (uvm_printer printer);
		super.do_print(printer);
		printer.print_field("a", a, $bits(a), UVM_DEC);
		printer.print_field("b", b, $bits(b), UVM_DEC);
		printer.print_field("c", c, $bits(c), UVM_DEC);
	endfunction
	
endclass

module tb;
	my_transaction t;
	initial begin;
		t = new("t");
		t.a=4;
		t.b=5;
		t.c=6;
		t.print(uvm_default_line_printer);
	end
endmodule