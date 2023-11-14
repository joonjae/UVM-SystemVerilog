`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2023 23:27:34
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

//Create transaction class extending uvm_sequence_item for the RTL module 
//mentioned in the Instruction tab also print the value of the data 
//members inside the class after randomization.

//module dff
//(
//input [3:0] mode,
//input rst,
//input clk,
//input din,
//output dout,
//output dbar
//);
//endmodule

`include "uvm_macros.svh"
import uvm_pkg::*;

class transaction extends uvm_sequence_item;
    rand bit [3:0]  mode;
    rand bit        rst;
    rand bit        clk;
    rand bit        din;
    bit             dout;
    bit             dbar;
    
    function new(input string inst = "TRANS");
        super.new(inst);
    endfunction
    
    `uvm_object_utils_begin(transaction)
    `uvm_field_int(mode, UVM_DEFAULT)
    `uvm_field_int(rst, UVM_DEFAULT)
    `uvm_field_int(clk, UVM_DEFAULT)
    `uvm_field_int(din, UVM_DEFAULT)
    `uvm_field_int(dout, UVM_DEFAULT)
    `uvm_field_int(dbar, UVM_DEFAULT)
    `uvm_object_utils_end
endclass

module tb;
transaction ts;
 
initial begin
    ts = new("STATS");
    ts.randomize();  
    ts.print();
end
endmodule
