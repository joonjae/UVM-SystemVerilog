`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.02.2023 12:35:46
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

//Assume you have producer consisting of three data members 
//( reg [1:0] a = 2'b11, reg [3:0] b = 4'b0100 and reg c = 1'b1 ). 
//Communicate this data to three subscribers with the help of analysis port. 
//Print the data sent by the producer as well as received by all the subscribers for verification.

`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class transaction extends uvm_sequence_item;
    bit [1:0] a;
    bit [3:0] b;
    bit       c;
    
    function new(input string inst = "TRANS");
        super.new(inst);
    endfunction
    
    `uvm_object_utils_begin(transaction)
    `uvm_field_int(a, UVM_DEFAULT)
    `uvm_field_int(b, UVM_DEFAULT)
    `uvm_field_int(c, UVM_DEFAULT)
    `uvm_object_utils_end
endclass
 
 
 
 
class producer extends uvm_component;
    `uvm_component_utils(producer)
    transaction t;
     
    uvm_analysis_port #(transaction) send;
     
    function new(input string inst = "PROD", uvm_component c);
        super.new(inst,c);
        send = new("WRITE",this);
    endfunction
     
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t = transaction::type_id::create("trans",this);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(phase);
        `uvm_info("PROD", "Data send", UVM_NONE);
        t.a = 2'b11;
        t.b = 4'b0100;
        t.c = 1'b1; 
        t.print(uvm_default_line_printer);
        send.write(t);
        phase.drop_objection(phase);
    endtask
 
endclass
 
 
 
class subscriber1 extends uvm_component;
    `uvm_component_utils(subscriber1)
     
    uvm_analysis_imp #(transaction,subscriber1) recv;
     
    function new(input string inst = "SUB1", uvm_component c);
        super.new(inst,c);
        recv = new("READ",this);
    endfunction
     
    virtual function void write(input transaction t);
        `uvm_info("SUB1", "Data rcvd ", UVM_NONE);
        t.print(uvm_default_line_printer);
    endfunction
 
endclass
 
 
class subscriber2 extends uvm_component;
    `uvm_component_utils(subscriber2)
     
    uvm_analysis_imp #(transaction,subscriber2) recv;
     
    function new(input string inst = "SUB2", uvm_component c);
        super.new(inst,c);
        recv = new("READ",this);
    endfunction
     
    virtual function void write(input transaction t);
        `uvm_info("SUB2", "Data rcvd ", UVM_NONE);
        t.print(uvm_default_line_printer);
    endfunction
endclass
 
 
class env extends uvm_env;
    `uvm_component_utils(env)
     
    function new(input string inst = "ENV", uvm_component c);
        super.new(inst, c);
    endfunction
     
    producer p;
    subscriber1 s1;
    subscriber2 s2;
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        p = producer::type_id::create("PROD",this);
        s1 = subscriber1::type_id::create("S1",this);
        s2 = subscriber2::type_id::create("S2",this);
    endfunction
     
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        p.send.connect(s1.recv);
        p.send.connect(s2.recv);
    endfunction
 
endclass
 
class test extends uvm_test;
    `uvm_component_utils(test)
     
    function new(input string inst = "TEST", uvm_component c);
        super.new(inst, c);
    endfunction

    env e;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e = env::type_id::create("ENV",this);
    endfunction
  
endclass
 
module tb;
    test t;
    initial begin
        t = new("TEST",null);
        run_test();
    end
 
endmodule
