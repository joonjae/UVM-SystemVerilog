`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
	rand bit [3:0] a;
	rand bit [7:0] b;

	function new(input string inst = "TRANS");
		super.new(inst);
	endfunction

	`uvm_object_utils_begin(transaction)
	`uvm_field_int(a, UVM_DEFAULT)
	`uvm_field_int(b, UVM_DEFAULT)
	`uvm_object_utils_end
endclass

class producer extends uvm_component;
	`uvm_component_utils(producer)

	transaction t;

	uvm_blocking_put_port #(transaction) send;

	function new(input string inst = "producer", uvm_component parent = null);
		super.new(inst, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		t = transaction::type_id::create("t");
		send = new("send",this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		t.randomize();
		`uvm_info("PROD", "DATA SENT TO CONSUMER", UVM_NONE);
		t.print();
		send.put(t);
		phase.drop_objection(this);
	endtask

endclass

class consumer extends uvm_component;
	`uvm_component_utils(consumer)
	uvm_blocking_put_imp #(transaction, consumer) recv;

	function new (input string inst = "consumer", uvm_component parent = null);
		super.new(inst, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		recv = new("recv", this);
	endfunction

	virtual task put(transaction t);
		`uvm_info("CONS", "DATA RECV FROM PRODUCER", UVM_NONE);
		t.print();
	endtask
endclass

class env extends uvm_env;
	`uvm_component_utils(env)

	producer p;
	consumer c;

	function new(input string inst = "env", uvm_component parent = null);
		super.new(inst, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		p = producer::type_id::create("p",this);
		c = consumer::type_id::create("c",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		p.send.connect(c.recv);
	endfunction
	
endclass

class test extends uvm_test;
	`uvm_component_utils(test)

	env e;

	function new(input string inst = "test", uvm_component parent = null);
		super.new(inst, parent);
	endfunction

	virtual function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		e = env::type_id::create("e",this);
	endfunction
	
endclass

module tb;
	initial begin
		run_test("test");
	end
endmodule