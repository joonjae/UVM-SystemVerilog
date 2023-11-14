`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2023 00:15:10
// Design Name: 
// Module Name: tb2
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

//Typical format of the usage of uvm_config_db
//Example on usage of uvm_config_db

`include "uvm_macros.svh"
import uvm_pkg::*;
 
class transaction extends uvm_sequence_item;
 
 bit [3:0] a ;
 bit [3:0] b ;
 bit [4:0] y;
 
function new(input string inst = "TRANS");
super.new(inst);
endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_DEFAULT)
`uvm_field_int(y,UVM_DEFAULT)
`uvm_object_utils_end
 
 
endclass
 
///////////////////////////////////////////////////////////
class driver extends uvm_driver;
`uvm_component_utils(driver)
 
 virtual top_if vif;
 transaction t;
 
function new(input string inst = "DRV", uvm_component c);
super.new(inst,c);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
t = transaction::type_id::create("TRANS",this);
  
  if(!uvm_config_db #(virtual top_if)::get(this, "", "vif",vif))
   `uvm_info("DRV", "Unable to read db", UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
  phase.raise_objection(phase);
  t.a  = 4'b1000;
  t.b = 4'b0001;
  t.print();
vif.a = t.a;
vif.b = t.b;
  phase.drop_objection(phase); 
////Driving the Virtual Interface signals/ net from the Sequence data
/// vif.a = trans.a
endtask
 
endclass
 
//////////////////////////////////////////////////////////
class monitor extends uvm_monitor;
`uvm_component_utils(monitor)
 
  virtual top_if vif;
  transaction tr;
 
function new(input string inst = "MON", uvm_component c);
super.new(inst,c);
endfunction
 
virtual function void build_phase(uvm_phase phase);
super.build_phase(phase);
tr = transaction::type_id::create("TRANS",this);
  if(!uvm_config_db #(virtual top_if)::get(this, "", "vif",vif))
   `uvm_info("MON", "Unable to read db", UVM_NONE);
endfunction
 
virtual task run_phase(uvm_phase phase);
phase.raise_objection(phase);
  #10;
tr.a = vif.a;
tr.b = vif.b;
tr.y = vif.y;
tr.print();
 phase.drop_objection(phase); 
endtask
 
 
endclass
/////////////////////////////////////////////////////////////////
 
 
class env extends uvm_env;
  `uvm_component_utils(env)
 
monitor m;
driver d;
 
  function new(input string inst = "ENV", uvm_component c);
super.new(inst,c);
endfunction
 
 
       virtual function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
        m  = monitor::type_id::create("MON",this);
        d = driver::type_id::create("DRV", this);
     endfunction
     
 
 
endclass
 
 
///////////////////////////////////////////////
class test extends uvm_test;
  `uvm_component_utils(test)  
  
  env e;
  
function new(input string inst = "TEST", uvm_component c);
super.new(inst,c);
endfunction
 
         virtual function void build_phase(uvm_phase phase);
    		super.build_phase(phase);
           e = env::type_id::create("env",this);
     endfunction
     
  
endclass  
  
module tb2;
  
  top_if vif();
  top uut (.a(vif.a), .b(vif.b), .y(vif.y));
  test t;
 
 
 
initial begin
 t = new("TEST",null);
  uvm_config_db #(virtual top_if)::set(null,"*","vif",vif);
 
run_test();
end
 
endmodule
////////////////////////////////////////////
 
 
module top(
  input [3:0] a,b,
  output [4:0] y
);
  
  assign y = a + b;
  
  
endmodule
 
 
 
interface top_if();
  logic [3:0] a;
  logic [3:0] b;
  logic [4:0] y;
  
endinterface

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