`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.01.2023 00:27:31
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

// Getting started with Sequencer
`include "uvm_macros.svh"
import uvm_pkg::*;


class transaction extends uvm_sequence_item;
 
 rand bit [3:0] a;
 rand bit [3:0] b;
 rand bit [4:0] y;
 
function new(input string inst = "TRANS");
super.new(inst);
endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_DEFAULT)
`uvm_field_int(y,UVM_DEFAULT)
`uvm_object_utils_end
 
endclass
////////////////////////////////////////////////////////////

class generator extends uvm_sequence#(transaction);
`uvm_object_utils(generator)
 
transaction t;
 
function new(input string inst = "SEQ");
super.new(inst);
endfunction
 
 
virtual task body();
t = transaction::type_id::create("TRANS");
start_item(t);
t.randomize();
t.print();
finish_item(t);
`uvm_info("GEN", "Data send to driver", UVM_NONE);
endtask
 
endclass
////////////////////////////////////////////////////////////

class driver extends uvm_driver #(transaction);
`uvm_component_utils(driver)
 
 transaction t;
 
function new(input string inst = "DRV", uvm_component c);
super.new(inst,c);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS");
endfunction
 
virtual task run_phase(uvm_phase phase);
  phase.raise_objection(phase);
  seq_item_port.get_next_item(t);
  `uvm_info("DRV","Data rcvd from Generator", UVM_NONE);
  t.print();
  seq_item_port.item_done();
  phase.drop_objection(phase); 
endtask
 
endclass
//////////////////////////////////////////////////////////
 
class agent extends uvm_agent;
`uvm_component_utils(agent)
 
 
driver d;
uvm_sequencer #(transaction) sequencer;
 
function new(input string inst = "DRV", uvm_component c);
super.new(inst,c);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
d = driver::type_id::create("DRV",this);
sequencer = uvm_sequencer#(transaction)::type_id::create("seq",this);
endfunction
 
virtual function void connect_phase(uvm_phase phase);
super.connect_phase(phase);
d.seq_item_port.connect(sequencer.seq_item_export);
endfunction
 
endclass
///////////////////////////////////////////////////////////

class env extends uvm_env;
  
    agent a;
    
    `uvm_component_utils(env)
    
    function new(string name = "ENV", uvm_component p);
    super.new(name,p);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    a = agent::type_id::create("AGENT",this);      	
    endfunction
 
endclass
///////////////////////////////////////////////

class test extends uvm_test;
    `uvm_component_utils(test)  
    
    generator gen;
    env e; 
    
    function new(input string inst = "TEST", uvm_component c);
    super.new(inst,c);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    gen = generator::type_id::create("GEN",this);
    e = env::type_id::create("env",this);
    endfunction
  
  
    virtual task run_phase(uvm_phase phase);
    
    phase.raise_objection(this);
    gen.start(e.a.sequencer);  
    phase.drop_objection(this);
    
    endtask
     
  
endclass  

module tb; 
test t;
  
initial begin
t = new("TEST",null);
run_test();
end
 
endmodule

////Typical format of the usage of uvm_config_db
////Example on usage of uvm_config_db

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class transaction extends uvm_sequence_item;
 
// bit [3:0] a ;
// bit [3:0] b ;
// bit [4:0] y;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a,UVM_DEFAULT)
//`uvm_field_int(b,UVM_DEFAULT)
//`uvm_field_int(y,UVM_DEFAULT)
//`uvm_object_utils_end
 
 
//endclass
 
/////////////////////////////////////////////////////////////
//class driver extends uvm_driver;
//`uvm_component_utils(driver)
 
// virtual top_if vif;
// transaction t;
 
//function new(input string inst = "DRV", uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS",this);
  
//  if(!uvm_config_db #(virtual top_if)::get(this, "", "vif",vif))
//   `uvm_info("DRV", "Unable to read db", UVM_NONE);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//  phase.raise_objection(phase);
//  t.a  = 4'b1000;
//  t.b = 4'b0001;
//  t.print();
//vif.a = t.a;
//vif.b = t.b;
//  phase.drop_objection(phase); 
//////Driving the Virtual Interface signals/ net from the Sequence data
///// vif.a = trans.a
//endtask
 
//endclass
 
////////////////////////////////////////////////////////////
//class monitor extends uvm_monitor;
//`uvm_component_utils(monitor)
 
//  virtual top_if vif;
//  transaction tr;
 
//function new(input string inst = "MON", uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//tr = transaction::type_id::create("TRANS",this);
//  if(!uvm_config_db #(virtual top_if)::get(this, "", "vif",vif))
//   `uvm_info("MON", "Unable to read db", UVM_NONE);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//  #10;
//tr.a = vif.a;
//tr.b = vif.b;
//tr.y = vif.y;
//tr.print();
// phase.drop_objection(phase); 
//endtask
 
 
//endclass
///////////////////////////////////////////////////////////////////
 
 
//class env extends uvm_env;
//  `uvm_component_utils(env)
 
//monitor m;
//driver d;
 
//  function new(input string inst = "ENV", uvm_component c);
//super.new(inst,c);
//endfunction
 
 
//       virtual function void build_phase(uvm_phase phase);
//    		super.build_phase(phase);
//        m  = monitor::type_id::create("MON",this);
//        d = driver::type_id::create("DRV", this);
//     endfunction
     
 
 
//endclass
 
 
/////////////////////////////////////////////////
//class test extends uvm_test;
//  `uvm_component_utils(test)  
  
//  env e;
  
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst,c);
//endfunction
 
//         virtual function void build_phase(uvm_phase phase);
//    		super.build_phase(phase);
//           e = env::type_id::create("env",this);
//     endfunction
     
  
//endclass  
  
//module tb;
  
//  top_if vif();
//  top uut (.a(vif.a), .b(vif.b), .y(vif.y));
//  test t;
 
 
 
//initial begin
// t = new("TEST",null);
//  uvm_config_db #(virtual top_if)::set(null,"*","vif",vif);
 
//run_test();
//end
 
//endmodule
//////////////////////////////////////////////
 
 
//module top(
//  input [3:0] a,b,
//  output [4:0] y
//);
  
//  assign y = a + b;
  
  
//endmodule
 
 
 
//interface top_if();
//  logic [3:0] a;
//  logic [3:0] b;
//  logic [4:0] y;
  
//endinterface

// // Understanding uvm_config_db
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//int data;
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
// if(!uvm_config_db #(int)::get(this, "", "data",data))
//   `uvm_info("TEST", "Unable to read db", UVM_NONE);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("TEST", $sformatf("Value read : %0d",data),UVM_NONE);
//endtask
 
 
//endclass
 
  
//module tb2;
//int d = 12;
//test t;
 
 
//initial begin
//t = new("TEST",null);
//uvm_config_db #(int)::set(null,"*","data",d);
//run_test();
//end
 
//endmodule

//// Understanding Simple Monitor and Scoreboard scenario

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
////////////////////////////////////////////////////////
 
//class transaction extends uvm_sequence_item;
 
//  bit [3:0] a = 4'b1010;
//  bit [3:0] b = 4'b1000;
//  bit [4:0] y = 5'b10010;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a, UVM_DEFAULT)
//`uvm_field_int(b, UVM_DEFAULT)
//`uvm_field_int(y, UVM_DEFAULT)
//`uvm_object_utils_end
//endclass
 
/////////////////////////////////////////////
 
//class monitor extends uvm_monitor;
//`uvm_component_utils(monitor)
 
//uvm_analysis_port #(transaction) send;
 
//function new(input string inst = "MON", uvm_component c);
//super.new(inst,c);
//send = new("WRITE",this);
//endfunction
 
//transaction t;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//  phase.raise_objection(phase);
//  send.write(t);
//  `uvm_info("MON", "Data send to Scoreboard", UVM_NONE);
//  #10;
//  phase.drop_objection(phase);
//endtask
 
//endclass
 
/////////////////////////////////////////////////////////////
 
//class scoreboard extends uvm_scoreboard;
//`uvm_component_utils(scoreboard)
 
//uvm_analysis_imp #(transaction,scoreboard) recv;
  
//  transaction data;
 
//function new(input string inst = "SCO", uvm_component c);
//super.new(inst,c);
//recv = new("READ",this);
//endfunction
  
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//data = transaction::type_id::create("TRANS", this);
//endfunction  
  
  
 
//virtual function void write(input transaction t);
//  data = t;
//endfunction
  
 
//  virtual task run_phase(uvm_phase phase);
//forever begin
//  #10;
//  if(data.y == data.a + data.b) 
//begin
//`uvm_info("SCO", "Test Passed", UVM_NONE);
//end
//else
//begin
//`uvm_info("SCO", "Test Failed", UVM_NONE);
//end
//end
//  endtask
 
  
 
//endclass
 
//////////////////////////////////////////////////////////
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//monitor m;
//scoreboard s;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//m = monitor::type_id::create("MON",this);
//s = scoreboard::type_id::create("SCO",this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//m.send.connect(s.recv);
//endfunction
 
//endclass
 
/////////////////////////////////////////////////////////
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
//env e;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
////////////////////////////////////////////////////
 
//module tb2;
 
//  test t;
 
//initial begin
//t = new("TEST",null);
//run_test();
//end    
  
  
//endmodule
 
///////////////////////////////////////////////////////////

////  Understanding Interface p2
//module top(
//input [3:0] a,b,
//input clk,
//output reg [4:0] y
//);
 
//always@(posedge clk)
//begin
// y <= a + b;
//end
 
//endmodule
 
//interface top_if;
//logic [3:0] a;
//logic [3:0] b;
//logic [4:0] y;
//logic clk;
//endinterface
 
//module tb;
 
//top_if tif();
/////class
//top dut (.a(tif.a), .b(tif.b), .y(tif.y), .clk(tif.clk)); //Explicit
 
//initial begin
//tif.clk = 0;
//end
 
//always #5 tif.clk = ~tif.clk;
 
//initial begin
//tif.a = 4'b1010;
//tif.b = 4'b0011;
//end
 
//initial begin
//#100;
//$finish;
//end
 
//endmodule

// //  Understanding Interface p1
//module top(
//input [3:0] a,b,
//output [4:0] y
//);
 
//assign y = a + b;
 
//endmodule
 
//interface top_if;
//logic [3:0] a;
//logic [3:0] b;
//logic [4:0] y;
//endinterface
 
//module tb2;
 
//top_if tif();
/////class
//top dut (.a(tif.a), .b(tif.b), .y(tif.y)); //Explicit
 
 
//initial begin
//tif.a = 4'b1010;
//tif.b = 4'b0011;
//end
 
 
//endmodule 



////Using TLM Analysis Port p2

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class transaction extends uvm_sequence_item;
 
  
//  rand bit [3:0] a;
//  rand bit [7:0] b;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
  
//  `uvm_object_utils_begin(transaction)
//  `uvm_field_int(a, UVM_DEFAULT)
//  `uvm_field_int(b, UVM_DEFAULT)
//  `uvm_object_utils_end
//endclass
 
 
 
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
//transaction t;
//integer i;
 
//uvm_analysis_port #(transaction) send;
 
//function new(input string inst = "PROD", uvm_component c);
//super.new(inst,c);
//send = new("WRITE",this);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("trans",this);
//endfunction
 
 
 
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//for(i =0 ; i < 10 ;i++) begin
//`uvm_info("PROD", "Data send", UVM_NONE);
//t.randomize();
//send.write(t);
//t.print(uvm_default_line_printer);
 
//end
//phase.drop_objection(phase);
//endtask
 
//endclass
 
 
 
//class subscriber1 extends uvm_component;
//`uvm_component_utils(subscriber1)
 
//integer i;
 
//uvm_analysis_imp #(transaction,subscriber1) recv;
 
//function new(input string inst = "SUB1", uvm_component c);
//super.new(inst,c);
//recv = new("READ",this);
//endfunction
 
//virtual function void write(input transaction t);
//`uvm_info("SUB1", "Data rcvd ", UVM_NONE);
//t.print(uvm_default_line_printer);
//endfunction
 
 
//endclass
 
 
//class subscriber2 extends uvm_component;
//`uvm_component_utils(subscriber2)
 
//integer i;
 
//uvm_analysis_imp #(transaction,subscriber2) recv;
 
//function new(input string inst = "SUB2", uvm_component c);
//super.new(inst,c);
//recv = new("READ",this);
//endfunction
 
//virtual function void write(input transaction t);
//`uvm_info("SUB2", "Data rcvd ", UVM_NONE);
//t.print(uvm_default_line_printer);
//endfunction
 
 
//endclass
 
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//producer p;
//subscriber1 s1;
//subscriber2 s2;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//s1 = subscriber1::type_id::create("S1",this);
//s2 = subscriber2::type_id::create("S2",this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(s1.recv);
//p.send.connect(s2.recv);
//endfunction
 
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
//env e;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
//module tb;
//test t;
 
//initial begin
//t = new("TEST",null);
//run_test();
//end
 
//endmodule

////Using TLM Analysis Port p1

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
 
//integer i;
 
//uvm_analysis_port #(integer) send;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//send = new("PUT", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//for(i = 0; i < 10; i++) begin
//`uvm_info("PROD", $sformatf("Data send : %0d",i),UVM_NONE);
//send.write(i);
//#10;
//end
//phase.drop_objection(phase);
//endtask
//endclass
 
 
//class subscriber1 extends uvm_component;
//`uvm_component_utils(subscriber1)
 
//integer i;
//integer data;
 
//uvm_analysis_imp #(integer,subscriber1) recv1;
 
//function new(input string inst = "S1", uvm_component c);
//super.new(inst, c);
//recv1 = new("S1", this);
//endfunction
 
 
//virtual function void write(input integer t);
//`uvm_info("S1", $sformatf("Value of %0d",t), UVM_NONE);
//endfunction
 
//endclass
 
 
 
//class subscriber2 extends uvm_component;
//`uvm_component_utils(subscriber2)
 
//integer i;
//integer data;
 
//uvm_analysis_imp #(integer,subscriber2) recv2;
 
//function new(input string inst = "S2", uvm_component c);
//super.new(inst, c);
//recv2 = new("S2", this);
//endfunction
 
 
//virtual function void write(input integer t);
//`uvm_info("S2", $sformatf("Value of %0d",t), UVM_NONE);
//endfunction
 
//endclass
 
 
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//producer p;
//subscriber1 s1;
//subscriber2 s2;
 
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//s1 = subscriber1::type_id::create("S1",this);
//s2 = subscriber2::type_id::create("S2",this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(s1.recv1);
//p.send.connect(s2.recv2);
//endfunction
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
//env e;
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
//module tb;
//test t;
 
//initial begin
//t = new("TEST", null);
//run_test();
//end 
 
 
//endmodule
 


////Using TLM_FIFO part 2

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class transaction extends uvm_sequence_item;
 
//rand bit [3:0] a;
//rand bit [7:0] b;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a, UVM_DEFAULT)
//`uvm_field_int(b, UVM_DEFAULT)
//`uvm_object_utils_end
 
//endclass
 
 
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
//transaction t;
 
//integer i;
 
//uvm_blocking_put_port #(transaction) send;
 
 
//function new(input string inst = "PROD", uvm_component c);
//super.new(inst, c);
//send  = new("PUT", this);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS",this);
//endfunction
 
 
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//for(i = 0; i < 10; i++) begin
//#40;
//t.randomize();
//`uvm_info("PROD", "DATA Sent",UVM_NONE);  
//t.print(uvm_default_line_printer);
//send.put(t);
//end
//phase.drop_objection(phase);
//endtask
 
//endclass
 
//class consumer extends uvm_component;
//`uvm_component_utils(consumer)
//transaction data;
//integer i;
  
 
//uvm_blocking_get_port #(transaction)  recv;
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//data = transaction::type_id::create("TRANS",this);
//endfunction
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//recv  = new("RECV", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//forever begin
//#40;
//recv.get(data);
//`uvm_info("CONS", "DATA Taken out",UVM_NONE); 
//data.print(uvm_default_line_printer);
//end
//endtask
 
//endclass
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//producer p;
//consumer c;
 
//uvm_tlm_fifo #(transaction) fifo;
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//c = consumer::type_id::create("CONS", this);
//fifo = new("FIFO",this,20);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(fifo.put_export);
//c.recv.connect(fifo.get_export);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//forever begin
//#40;
//  if(fifo.is_full()) 
//begin
//`uvm_info("ENV", "FIFO is Full",UVM_NONE);
//end
//else 
//begin
//`uvm_info("ENV", "FIFO is not full yet",UVM_NONE);
//end
//end
//endtask
 
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//env e;
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
//module tb2;
//test t;
 
 
//initial begin
//t = new("TEST", null);
//run_test();
//end
 
 
//endmodule

////Using TLM_FIFO part 1

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
 
//integer i;
 
//uvm_blocking_put_port #(integer) send;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//send = new("PUT", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//for(i = 0; i < 10; i++) begin
//`uvm_info("PROD", $sformatf("Data send : %0d",i),UVM_NONE);
//send.put(i);
//#10;
//end
//phase.drop_objection(phase);
//endtask
//endclass
 
 
//class consumer extends uvm_component;
//`uvm_component_utils(consumer)
 
//integer i;
//integer data;
 
//uvm_blocking_get_port #(integer) recv;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//recv = new("GET", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
//for(i = 0; i < 10; i++) begin
//recv.get(data);
//`uvm_info("CONS", $sformatf("Data recv : %0d",data),UVM_NONE);
//#10;
//end
//phase.drop_objection(phase);
//endtask
 
//endclass
 
 
//class env extends uvm_env;
//    `uvm_component_utils(env)
     
//    function new(input string inst = "ENV", uvm_component c);
//    super.new(inst, c);
//    endfunction
     
//    producer p;
//    consumer c;
     
//    uvm_tlm_fifo #(integer) fifo;
     
//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        p = producer::type_id::create("PROD",this);
//        c = consumer::type_id::create("CONS",this);
//        fifo = new("FIFO", this, 10);
//    endfunction
     
//    virtual function void connect_phase(uvm_phase phase);
//        super.connect_phase(phase);
//        p.send.connect(fifo.put_export);
//        c.recv.connect(fifo.get_export);
//    endfunction
     
//    virtual task run_phase(uvm_phase phase);
//        forever begin
//            #10;
//            if(fifo.is_full())
//            begin
//                `uvm_info("ENV", "FIFO is full",UVM_NONE);
//            end
//            else
//            begin
//                `uvm_info("ENV", "FIFO is not full yet",UVM_NONE);
//            end
//        end
//    endtask
//endclass
 
//class test extends uvm_test;
//    `uvm_component_utils(test)
//    env e;
     
//    function new(input string inst = "ENV", uvm_component c);
//        super.new(inst, c);
//    endfunction

//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        e = env::type_id::create("ENV",this);
//    endfunction
 
//endclass
 
//module tb;
//    test t;
 
//    initial begin
//    t = new("TEST", null);
//    run_test();
//end 
 
 
//endmodule


////Independent Multiple TLM Blocking Port P1

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
 
///////////////////////////////////////////////////////////////////////////
 
//class producer extends uvm_component;
//  `uvm_component_utils(producer)
 
 
//reg [7:0] a = 8'h12;
//reg [15:0] b = 16'hffff;
//reg [3:0] c = 4'hf;
 
 
//  uvm_blocking_put_port #(reg[7:0]) send1;
//  uvm_blocking_put_port #(reg[15:0]) send2;
//  uvm_blocking_put_port #(reg[3:0]) send3;
 
 
//function new(input string inst="PROD",uvm_component c);
//super.new(inst,c);
//  send1=new("SEND1",this);
//  send2=new("SEND2",this);
//  send3=new("SEND3",this);
//endfunction
 
//task run();
//`uvm_info("PROD",$sformatf("Data Send  a : %0x,  b : %0x and c : %0x", a,b,c),UVM_NONE)
//send1.put(a);
//send2.put(b);
//send3.put(b);
//endtask
 
//endclass
 
 
////////////////////////////////////////////////////////////
 
//class consumer extends uvm_component;
 
 
//`uvm_component_utils(consumer)
 
//`uvm_blocking_put_imp_decl(_1)
//`uvm_blocking_put_imp_decl(_2)
//`uvm_blocking_put_imp_decl(_3)
 
 
 
//  uvm_blocking_put_imp_1 #(reg[7:0],consumer) recv1;
//  uvm_blocking_put_imp_2 #(reg[15:0],consumer) recv2;
//  uvm_blocking_put_imp_3 #(reg[3:0],consumer) recv3;
 
  
//function new(input string inst="CONS",uvm_component c);
//super.new(inst,c);
//    recv1=new("RECV1",this);
//    recv2=new("RECV2",this);
//    recv3=new("RECV3",this);
//endfunction
 
 
//virtual task put_1(input reg[7:0] x );
//    `uvm_info("CONS:RECV1",$sformatf("the data is received  : %0x",x),UVM_NONE)
//endtask
 
 
//  virtual task put_2(input reg[15:0] y);
//    `uvm_info("CONS:RECV2",$sformatf("the data is received : %0X",y),UVM_NONE)
//endtask
 
//  virtual task put_3(input reg[3:0] z);
//    `uvm_info("CONS:RECV3",$sformatf("the data is received : %0X",z),UVM_NONE)
//endtask
 
//endclass
 
 
 
 
 
 
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//producer p;
//consumer c;
 
//function new(input string inst="TEST",uvm_component c);
//super.new(inst,c);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//  p=producer::type_id::create("PROD",this);
//  c=consumer::type_id::create("CONS",this);
//endfunction
 
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//  p.send1.connect(c.recv1);
//  p.send2.connect(c.recv2);
//  p.send3.connect(c.recv3);
//endfunction
 
 
//virtual task run_phase(uvm_phase phase);
//#100;
//global_stop_request();
//endtask
 
//endclass
 
 
 
 
 
 
 
//module top_correct;
//test t;
  
//initial begin
//t=new("TEST",null);
//run_test();
//end
 
 
//endmodule


////Observing output in compact format
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class transaction extends uvm_sequence_item;
 
//rand bit [3:0] a;
//rand bit [7:0] b;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a, UVM_DEFAULT)
//`uvm_field_int(b, UVM_DEFAULT)
//`uvm_object_utils_end
 
//endclass
 
 
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
//transaction t;
//integer i;
 
//uvm_blocking_put_port #(transaction) send;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS",this);
//endfunction
 
//function new(input string inst = "PROD", uvm_component c);
//super.new(inst, c);
//send  = new("PUT", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
 
//for(i =0; i<10; i++) begin
//t.randomize();
//t.print(uvm_default_line_printer);
//send.put(t);
//end
 
//phase.drop_objection(phase);
//endtask
 
//endclass
 
//class consumer extends uvm_component;
//`uvm_component_utils(consumer)
 
//uvm_blocking_put_imp #(transaction,consumer)  recv;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//recv  = new("RECV", this);
//endfunction
 
//virtual task put(input transaction t);
//t.print(uvm_default_line_printer);
//endtask
 
//endclass
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//producer p;
//consumer c;
 
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//c = consumer::type_id::create("CONS", this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(c.recv);
//endfunction
 
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//env e;
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
//module tb2;
//test t;
 
 
//initial begin
//t = new("TEST", null);
//run_test();
//end
 
 
//endmodule



////Replacing global_stop_request
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class transaction extends uvm_sequence_item;
 
//rand bit [3:0] a;
//rand bit [7:0] b;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a, UVM_DEFAULT)
//`uvm_field_int(b, UVM_DEFAULT)
//`uvm_object_utils_end
 
//endclass
 
 
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
//transaction t;
//integer i;
 
//uvm_blocking_put_port #(transaction) send;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS",this);
//endfunction
 
//function new(input string inst = "PROD", uvm_component c);
//super.new(inst, c);
//send  = new("PUT", this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//phase.raise_objection(phase);
 
//for(i =0; i<10; i++) begin
//t.randomize();
//t.print();
//send.put(t);
//end
 
//phase.drop_objection(phase);
//endtask
 
//endclass
 
//class consumer extends uvm_component;
//`uvm_component_utils(consumer)
 
//uvm_blocking_put_imp #(transaction,consumer)  recv;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//recv  = new("RECV", this);
//endfunction
 
//virtual task put(input transaction t);
//t.print();
//endtask
 
//endclass
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//producer p;
//consumer c;
 
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//c = consumer::type_id::create("CONS", this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(c.recv);
//endfunction
 
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//env e;
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
 
//endclass
 
//module tb2;
//test t;
 
 
//initial begin
//t = new("TEST", null);
//run_test();
//end
 
 
//endmodule
 
 

////Working with Transaction data in TLM Blocking Port

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class transaction extends uvm_sequence_item;
 
//rand bit [3:0] a;
//rand bit [7:0] b;
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(a, UVM_DEFAULT)
//`uvm_field_int(b, UVM_DEFAULT)
//`uvm_object_utils_end
 
//endclass
 
 
 
//class producer extends uvm_component;
//`uvm_component_utils(producer)
//transaction t;
 
//uvm_blocking_put_port #(transaction) send;
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//t = transaction::type_id::create("TRANS",this);
//endfunction
 
//function new(input string inst = "PROD", uvm_component c);
//super.new(inst, c);
//send  = new("PUT", this);
//endfunction
 
//task run();
//t.randomize();
//t.print();
//send.put(t);
//endtask
 
//endclass
 
//class consumer extends uvm_component;
//`uvm_component_utils(consumer)
 
//uvm_blocking_put_imp #(transaction,consumer)  recv;
 
//function new(input string inst = "CONS", uvm_component c);
//super.new(inst, c);
//recv  = new("RECV", this);
//endfunction
 
//virtual task put(input transaction t);
//t.print();
//endtask
 
//endclass
 
//class env extends uvm_env;
//`uvm_component_utils(env)
 
//producer p;
//consumer c;
 
 
//function new(input string inst = "ENV", uvm_component c);
//super.new(inst, c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//p = producer::type_id::create("PROD",this);
//c = consumer::type_id::create("CONS", this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//p.send.connect(c.recv);
//endfunction
 
 
//endclass
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//env e;
 
//function new(input string inst = "TEST", uvm_component c);
//super.new(inst, c);
//endfunction
 
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//e = env::type_id::create("ENV",this);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//#100;
//global_stop_request();
//endtask
 
//endclass
 
//module tb2;
//test t;
 
 
//initial begin
//t = new("TEST", null);
//run_test();
//end
 
 
//endmodule
 
 

////Simple Producer Consumer Model

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class producer extends uvm_component;
//    `uvm_component_utils(producer)
     
//    int a = 12;
     
//    uvm_blocking_put_port #(int) send;
     
//    function new(input string inst = "PROD", uvm_component c);
//        super.new(inst, c);
//        send  = new("PUT", this);
//    endfunction
     
//    task run();
//        `uvm_info("PROD", $sformatf("Sending data to Consumer %0d",a), UVM_NONE);
//        send.put(a);
//    endtask
 
//endclass
 
//class consumer extends uvm_component;
//    `uvm_component_utils(consumer)
     
//    uvm_blocking_put_imp #(int,consumer)  recv;
     
//    function new(input string inst = "CONS", uvm_component c);
//        super.new(inst, c);
//        recv  = new("RECV", this);
//    endfunction
     
//    virtual task put(input int t);
//        `uvm_info("CONS", $sformatf("Data received : %0d",t), UVM_NONE);
//    endtask
 
//endclass
 
//class env extends uvm_env;
//    `uvm_component_utils(env)
     
//    producer p;
//    consumer c;
     
//    function new(input string inst = "ENV", uvm_component c);
//        super.new(inst, c);
//    endfunction
     
//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        p = producer::type_id::create("PROD",this);
//        c = consumer::type_id::create("CONS", this);
//    endfunction
     
//    virtual function void connect_phase(uvm_phase phase);
//        super.connect_phase(phase);
//        p.send.connect(c.recv);
//    endfunction
 
//endclass
 
//class test extends uvm_test;
//    `uvm_component_utils(test)
     
//    env e;
     
//    function new(input string inst = "TEST", uvm_component c);
//        super.new(inst, c);
//    endfunction
     
//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        e = env::type_id::create("ENV",this);
//    endfunction
     
//    virtual task run_phase(uvm_phase phase);
//        #100;
//        global_stop_request();
//    endtask
 
//endclass
 
//module tb2;
//    test t;
     
//    initial begin
//        t = new("TEST", null);
//        run_test();
//    end
     
//endmodule


////Understanding UVM Phases and end_of _elaboration_phase

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class driver extends uvm_driver;
//`uvm_component_utils(driver)
 
//function new(input string inst, uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//`uvm_info("DRV", "Build Phase", UVM_NONE);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//`uvm_info("DRV", "Connect Phase", UVM_NONE);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("DRV", "Run Phase", UVM_NONE);
//endtask
 
//virtual function void report_phase(uvm_phase phase);
//super.report_phase(phase);
//`uvm_info("DRV", "Report Phase", UVM_NONE);
//endfunction
 
//endclass
 
 
 
//class monitor extends uvm_monitor;
//`uvm_component_utils(monitor)
 
//function new(input string inst, uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//`uvm_info("MON", "Build Phase", UVM_NONE);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//`uvm_info("MON", "Connect Phase", UVM_NONE);
//endfunction
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("MON", "Run Phase", UVM_NONE);
//endtask
 
//virtual function void report_phase(uvm_phase phase);
//super.report_phase(phase);
//`uvm_info("MON", "Report Phase", UVM_NONE);
//endfunction
 
//endclass
 
//class agent extends uvm_agent;
//`uvm_component_utils(agent)
 
//monitor m;
//driver d;
 
//function new(input string inst, uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//`uvm_info("AGENT", "Build Phase", UVM_NONE);
// m = monitor::type_id::create("MON",this);
// d = driver::type_id::create("DRV", this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//`uvm_info("AGENT", "Connect Phase", UVM_NONE);
//endfunction
 
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("AGENT", "Run Phase", UVM_NONE);
//endtask
 
//virtual function void report_phase(uvm_phase phase);
//super.report_phase(phase);
//`uvm_info("AGENT", "Report Phase", UVM_NONE);
//endfunction
 
//endclass
 
//class env extends uvm_env;
//`uvm_component_utils(env)
//agent a;
 
//function new(input string inst, uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//`uvm_info("ENV", "Build Phase", UVM_NONE);
// a = agent::type_id::create("AGENT",this);
//endfunction
 
//virtual function void connect_phase(uvm_phase phase);
//super.connect_phase(phase);
//`uvm_info("ENV", "Connect Phase", UVM_NONE);
//endfunction
 
 
 
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("ENV", "Run Phase", UVM_NONE);
//endtask
 
//virtual function void report_phase(uvm_phase phase);
//super.report_phase(phase);
//`uvm_info("ENV", "Report Phase", UVM_NONE);
//endfunction
 
//endclass
 
 
//class test extends uvm_test;
//`uvm_component_utils(test)
 
//env e;
 
//function new(input string inst, uvm_component c);
//super.new(inst,c);
//endfunction
 
//virtual function void build_phase(uvm_phase phase);
//super.build_phase(phase);
//`uvm_info("TEST", "Build Phase", UVM_NONE);
//e = env::type_id::create("ENV",this);
//endfunction
 
//virtual function void end_of_elaboration_phase(uvm_phase phase);
//super.end_of_elaboration_phase(phase);
//print();
//endfunction
 
 
//virtual task run_phase(uvm_phase phase);
//`uvm_info("TEST", "Run Phase", UVM_NONE);
//#100;
//global_stop_request();
//endtask
 
 
//endclass
 
 
 
//module tb();
 
//test t;
//initial begin
//t = new("TEST", null);
//run_test();
//end 
 
//endmodule