//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 00:55:44
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// Design a testbench for the Combinational Circuit RTL mentioned in the Instruction tab.



`include "uvm_macros.svh"
import uvm_pkg::*;
 
interface au_if();
    logic [3:0] a;
    logic [3:0] b;
    logic [1:0] mode;
    logic [7:0] y;
endinterface

/////////////////////////Transaction 
class transaction extends uvm_sequence_item;
    rand bit [3:0] a;
    rand bit [3:0] b;
    rand bit [1:0] mode;
    bit [7:0] y;
     
    function new(input string inst = "TRANS");
        super.new(inst);
    endfunction
     
    `uvm_object_utils_begin(transaction)
        `uvm_field_int(a, UVM_DEFAULT)
        `uvm_field_int(b, UVM_DEFAULT)
        `uvm_field_int(mode, UVM_DEFAULT)
        `uvm_field_int(y, UVM_DEFAULT)
    `uvm_object_utils_end

endclass
 
//////////////////////////////////////////////////////////////
class generator extends uvm_sequence #(transaction);
    `uvm_object_utils(generator)
     
    transaction t;
    integer i;
     
    function new(input string inst = "GEN");
        super.new(inst);
    endfunction
     
    virtual task body();
        t = transaction::type_id::create("TRANS");
        for(i =0; i< 20; i++) begin
            start_item(t);
            t.randomize();
            `uvm_info("GEN",$sformatf("Data send to Driver a :%0d , b :%0d",t.a,t.b), UVM_NONE);
            t.print(uvm_default_line_printer);
            finish_item(t);
            #10;  
        end
    endtask
 
endclass
 
////////////////////////////////////////////////////////////////////
class driver extends uvm_driver #(transaction);
    `uvm_component_utils(driver)
     
    function new(input string inst = " DRV", uvm_component c);
        super.new(inst, c);
    endfunction
     
    transaction data;
    virtual au_if aif;
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        data = transaction::type_id::create("TRANS");
        if(!uvm_config_db #(virtual au_if)::get(this,"","aif",aif)) 
            `uvm_info("DRV","Unable to access uvm_config_db",UVM_NONE);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
        forever begin
            seq_item_port.get_next_item(data);
            aif.a = data.a;
            aif.b = data.b;
            aif.mode = data.mode;
            `uvm_info("DRV", $sformatf("Trigger DUT a: %0d ,b: %0d, mode: %d",data.a, data.b, data.mode), UVM_NONE);
            data.print(uvm_default_line_printer);
            seq_item_port.item_done();
        end
    endtask
endclass
 
////////////////////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
    `uvm_component_utils(monitor)
     
    uvm_analysis_port #(transaction) send;
     
    function new(input string inst = "MON", uvm_component c);
        super.new(inst, c);
        send = new("Write", this);
    endfunction
     
    transaction t;
    virtual au_if aif;
     
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    t = transaction::type_id::create("TRANS");
    if(!uvm_config_db #(virtual au_if)::get(this,"","aif",aif)) 
        `uvm_info("MON","Unable to access uvm_config_db",UVM_NONE);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
    forever begin
    #10;
    t.a = aif.a;
    t.b = aif.b;
    t.mode = aif.mode;
    t.y = aif.y;
      `uvm_info("MON", $sformatf("Data send to Scoreboard a : %0d , b : %0d and y : %0d", t.a,t.b,t.y), UVM_NONE);
    t.print(uvm_default_line_printer);
    send.write(t);
    end
    endtask
endclass
 
///////////////////////////////////////////////////////////////////////
class scoreboard extends uvm_scoreboard;
    `uvm_component_utils(scoreboard)
     
    uvm_analysis_imp #(transaction,scoreboard) recv;
    transaction data;
     
    function new(input string inst = "SCO", uvm_component c);
        super.new(inst, c);
        recv = new("Read", this);
    endfunction
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        data = transaction::type_id::create("TRANS");
    endfunction
     
    virtual function void write(input transaction t);
        data = t;
        `uvm_info("SCO",$sformatf("Data rcvd from Monitor a: %0d , b: %0d, mode: %d and y: %0d", t.a, t.b, t.mode, t.y), UVM_NONE);
        data.print(uvm_default_line_printer);
        if(data.y == data.a + data.b)
            `uvm_info("SCO","Test Passed", UVM_NONE)
        else
            `uvm_info("SCO","Test Failed", UVM_NONE);
    endfunction
endclass
////////////////////////////////////////////////
 
class agent extends uvm_agent;
    `uvm_component_utils(agent)
     
    function new(input string inst = "AGENT", uvm_component c);
        super.new(inst, c);
    endfunction
     
    monitor m;
    driver d;
    uvm_sequencer #(transaction) seq;
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m = monitor::type_id::create("MON",this);
        d = driver::type_id::create("DRV",this);
        seq = uvm_sequencer #(transaction)::type_id::create("SEQ",this);
    endfunction
     
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        d.seq_item_port.connect(seq.seq_item_export);
    endfunction
endclass
 
/////////////////////////////////////////////////////
 
class env extends uvm_env;
    `uvm_component_utils(env)
     
    function new(input string inst = "ENV", uvm_component c);
        super.new(inst, c);
    endfunction
     
    scoreboard s;
    agent a;
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        s = scoreboard::type_id::create("SCO",this);
        a = agent::type_id::create("AGENT",this);
    endfunction
     
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        a.m.send.connect(s.recv);
    endfunction
     
endclass
 
////////////////////////////////////////////
 
class test extends uvm_test;
    `uvm_component_utils(test)
     
    function new(input string inst = "TEST", uvm_component c);
        super.new(inst, c);
    endfunction
     
    generator gen;
    env e;
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        gen = generator::type_id::create("GEN",this);
        e = env::type_id::create("ENV",this);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(phase);
        gen.start(e.a.seq);
        #10;
        phase.drop_objection(phase);
    endtask
endclass
//////////////////////////////////////
 
module add_tb();
    test t;
    au_if aif();
     
    au dut (.a(aif.a), .b(aif.b), .mode(aif.mode), .y(aif.y));
     
    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;  
        t = new("TEST",null);
        uvm_config_db #(virtual au_if)::set(null, "*", "aif", aif);
        run_test();
    end
 
endmodule