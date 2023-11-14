`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2023 23:36:56
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

//Assume producer class consists of two data members (reg [7:0] a = 8'h12 and 
//reg [15:0] b = 16'hffff). Use TLM blocking port to communicate this data to 
//Consumer class. Also, print data member values in both Producer and Consumer 
//class for verification.

`include "uvm_macros.svh"
import uvm_pkg::*;
 
class transaction extends uvm_sequence_item;
 
    bit [7:0]  a;
    bit [15:0] b;
     
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
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        t = transaction::type_id::create("TRANS",this);
    endfunction
     
    function new(input string inst = "PROD", uvm_component c);
        super.new(inst, c);
        send  = new("PUT", this);
    endfunction
     
    task run();
        t.a = 8'h12;
        t.b = 16'hffff;
        t.print();
        send.put(t);
    endtask
 
endclass
 
class consumer extends uvm_component;
    `uvm_component_utils(consumer)
     
    uvm_blocking_put_imp #(transaction,consumer)  recv;
     
    function new(input string inst = "CONS", uvm_component c);
        super.new(inst, c);
        recv  = new("RECV", this);
    endfunction
     
    virtual task put(input transaction t);
        t.print();
    endtask
     
endclass
 
class env extends uvm_env;
    `uvm_component_utils(env)
     
    producer p;
    consumer c;
     
    function new(input string inst = "ENV", uvm_component c);
        super.new(inst, c);
    endfunction
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        p = producer::type_id::create("PROD",this);
        c = consumer::type_id::create("CONS", this);
    endfunction
     
    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        p.send.connect(c.recv);
    endfunction
 
endclass
 
class test extends uvm_test;
    `uvm_component_utils(test)
     
    env e;
     
    function new(input string inst = "TEST", uvm_component c);
        super.new(inst, c);
    endfunction
     
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        e = env::type_id::create("ENV",this);
    endfunction
     
    virtual task run_phase(uvm_phase phase);
        #100;
        global_stop_request();
    endtask
endclass
     
module tb;
    test t;
     
    initial begin
    t = new("TEST", null);
    run_test();
    end
  
endmodule
 