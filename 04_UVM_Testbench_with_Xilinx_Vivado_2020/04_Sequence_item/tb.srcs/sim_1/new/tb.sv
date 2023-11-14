`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2023 20:24:49
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

//Understanding reusability
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class transaction extends uvm_sequence_item;
 
rand bit [7:0] din;
rand bit [5:0] addr;
rand bit wr;
rand bit oe;
bit [7:0] dout;
 
constraint data_c {din > 8'h10; addr > 6'h1;}
constraint control_c {wr != oe;}
 
function new(input string inst = "TRANS");
super.new(inst);
endfunction
 
`uvm_object_utils_begin(transaction)
`uvm_field_int(din, UVM_DEFAULT)
`uvm_field_int(addr, UVM_DEFAULT)
`uvm_field_int(wr, UVM_DEFAULT)
`uvm_field_int(oe, UVM_DEFAULT)
`uvm_field_int(dout, UVM_DEFAULT)
`uvm_object_utils_end
 
endclass
 
class transaction_statistics extends transaction;
rand bit [5:0] saddr;
 
 
`uvm_object_utils_begin(transaction_statistics)
`uvm_field_int(saddr, UVM_DEFAULT)
`uvm_object_utils_end
 
function new(input string inst = "TRANS_STAT");
super.new(inst);
endfunction
 
endclass
 
 
module tb;
transaction_statistics ts;
 
initial begin
ts = new("STATS");
ts.randomize();  
ts.print();
$display(ts.din);
end
endmodule
 


////Creating UVM_SEQUENCE_ITEM example 2
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//////uvm_sequence_item -> uvm_object
//class transaction extends uvm_sequence_item;
//rand bit [7:0] din;
//rand bit [5:0] addr;
//rand bit wr;
//rand bit oe;
//bit [7:0] dout;
 
 
//constraint data_c {din < 8'h11 ; addr < 6'h1 ; }
//constraint cntrl_c {wr != oe;} 
 
//function new(input string inst = "TRANS");
//super.new(inst);
//endfunction
 
//`uvm_object_utils_begin(transaction)
//`uvm_field_int(din,UVM_DEFAULT);
//`uvm_field_int(addr,UVM_DEFAULT);
//`uvm_field_int(wr,UVM_DEFAULT);
//`uvm_field_int(oe,UVM_DEFAULT);
//`uvm_field_int(dout,UVM_DEFAULT);
//`uvm_object_utils_end
 
//endclass
 
//module tb;
 
//transaction t;
 
//initial begin
//t = new("TRANS");
//t.randomize();
//t.print();
//end
 
 
 
//endmodule


//Creating UVM_SEQUENCE_ITEM example 1
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//////uvm_sequence_item -> uvm_object
//class transaction extends uvm_sequence_item;
//    rand bit [3:0] a;
//    rand bit [3:0] b;
//    bit [4:0] y;
     
//    function new(input string inst = "TRANS");
//    super.new(inst);
//    endfunction
     
//    `uvm_object_utils_begin(transaction)
//        `uvm_field_int(a,UVM_DEFAULT);
//        `uvm_field_int(b,UVM_DEFAULT);
//        `uvm_field_int(y,UVM_DEFAULT);
//    `uvm_object_utils_end
//endclass
 
//module tb;
 
//    transaction t;
     
//    initial begin
//        t = new("TRANS");
//        t.randomize();
//        t.print();
//    end
 
//endmodule

