//////////////////////////////////////////////////////

`include "uvm_macros.svh"
import uvm_pkg::*;
 
///////////////////////////////////////////////////////////////////////
class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)

	rand bit wr;
	rand bit [7:0] din;
	rand bit [3:0] addr;
	bit [7:0] dout;

	constraint addr_C {addr == 3;};

	function new(input string inst = "transaction");
		super.new(inst);
	endfunction
 
endclass
 
 
/////////////////////////////////////////////////////////////////////
class generator extends uvm_sequence#(transaction);
	`uvm_object_utils(generator)

	transaction t;

	function new(string inst = "generator");
		super.new(inst);
	endfunction

	virtual task body();
		for(int i =0; i< 10; i++) begin
			t = transaction::type_id::create("TRANS");
			start_item(t);
			t.randomize();
			$display("--------------------------------------------");
			`uvm_info("GEN", $sformatf("SEQ -> Driver wr:%0d addr :%0d din:%0d dout:%0d",t.wr, t.addr,t.din, t.dout), UVM_NONE);
			finish_item(t);
		end
	endtask
endclass
 
 
//////////////////////////////////////////////////////////////////////
class driver extends uvm_driver#(transaction);
	`uvm_component_utils(driver)
	 
	transaction t;
	virtual ram_if rif;
 
	function new(input string inst = "driver", uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		t = transaction::type_id::create("t");

		if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
			`uvm_error("DRV", "Unable to access Interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
		seq_item_port.get_next_item(t);
		rif.wr   <= t.wr;
		rif.din  <= t.din;
		rif.addr <= t.addr;
		`uvm_info("DRV", $sformatf("DRV -> DUT wr:%0d addr :%0d din:%0d dout:%0d",t.wr, t.addr,t.din, t.dout), UVM_NONE);

		seq_item_port.item_done();
		@(posedge rif.clk);

		if(t.wr == 1'b0)
			@(posedge rif.clk);

		end
	endtask

endclass
 
/////////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
	`uvm_component_utils(monitor)

	uvm_analysis_port #(transaction) send;
	virtual ram_if rif;
	transaction t;

	function new(input string inst = "monitor", uvm_component parent = null);
		super.new(inst,parent); 
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		t = transaction::type_id::create("TRANS");
		send = new("send",this);

		if(!uvm_config_db#(virtual ram_if)::get(this,"","rif",rif))
			`uvm_error("MON", "Unable to access Interface");
	endfunction

	virtual task run_phase(uvm_phase phase);
		forever begin
			@(posedge rif.clk);  
			t.wr = rif.wr;
			t.din = rif.din;
			t.addr = rif.addr;

			if(rif.wr == 1'b0) begin
				@(posedge rif.clk)
				t.dout = rif.dout;
			end 

			`uvm_info("MON", $sformatf("DUT -> MON wr:%0d addr :%0d din:%0d dout:%0d",t.wr, t.addr,t.din, t.dout), UVM_NONE);
			send.write(t);
		end
	endtask 
endclass
/////////////////////////////////////////////////////////////////////////////////////
class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	uvm_analysis_imp #(transaction,scoreboard) recv;

	reg [7:0] tarr[20] = '{default:0} ;

	function new(input string inst = "SCO", uvm_component c);
		super.new(inst,c);
		recv = new("recv",this);
	endfunction

	virtual function void write(transaction data);
		if(data.wr == 1'b1)begin
			tarr[data.addr] = data.din;
			`uvm_info("SCO", $sformatf("MON -> SCO : DATA WRITE OP :  addr :%0d din:%0d ", data.addr,data.din), UVM_NONE);  
		end 

		if(data.wr == 1'b0)begin
			if(data.dout == tarr[data.addr])
				`uvm_info("SCO", $sformatf("TEST PASSED : DATA READ OP   addr :%0d din:%0d dout:%0d ", data.addr,data.din, data.dout), UVM_NONE)
			else
				`uvm_error("SCO", $sformatf("TEST FAILED : DATA READ OP :  addr :%0d din:%0d dout:%0d ", data.addr,data.din, data.dout)) 
		end
		$display("--------------------------------------------");
	endfunction
endclass
 
////////////////////////////////////////////////////////////////////////////////////////////
 
class agent extends uvm_agent;
	`uvm_component_utils(agent)

	function new(input string inst = "agent", uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	monitor m;
	driver d;
	uvm_sequencer #(transaction) seqr;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		m = monitor::type_id::create("m",this);
		d = driver::type_id::create("d",this);
		seqr = uvm_sequencer #(transaction)::type_id::create("seqr",this);
	endfunction

	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		d.seq_item_port.connect(seqr.seq_item_export);
	endfunction
endclass
 
///////////////////////////////////////////////////////////////
class env extends uvm_env;
	`uvm_component_utils(env)

	function new(input string inst = "env", uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	scoreboard s;
	agent a;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		a = agent::type_id::create("a",this);
		s = scoreboard::type_id::create("s",this);
	endfunction


	virtual function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		a.m.send.connect(s.recv);
	endfunction
endclass
 
///////////////////////////////////////////////////////////////////
 
class test extends uvm_test;
	`uvm_component_utils(test)

	function new(input string inst = "test", uvm_component parent = null);
		super.new(inst,parent);
	endfunction

	generator gen;
	env e;

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		e = env::type_id::create("e",this);
		gen = generator::type_id::create("gen",this);
	endfunction

	virtual task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		gen.start(e.a.seqr);
		#20;  
		phase.drop_objection(this);
	endtask
endclass
 
///////////////////////////////////////////////
module ram_tb;
	ram_if rif();
	 
	ram dut (.clk(rif.clk), .wr(rif.wr), .din(rif.din), .dout(rif.dout), .addr(rif.addr));
	 
	initial begin
		rif.clk = 0;
	end
	 
	always#10 rif.clk = ~rif.clk;
	 
	initial begin
		uvm_config_db #(virtual ram_if)::set(null, "*", "rif", rif);
		run_test("test");
	end
endmodule