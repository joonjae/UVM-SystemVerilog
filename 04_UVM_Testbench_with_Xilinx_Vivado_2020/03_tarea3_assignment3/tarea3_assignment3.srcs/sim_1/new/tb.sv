`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.01.2023 00:05:28
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
//Create class extending uvm_object base class consisting of three data members (reg [3:0] a, reg [7:0] b, reg [15:0] c). 
//Use the Random number facility of SV to generate a random number for b and c. Finally, print the value of all the data members on the Console.

`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class simple extends uvm_object;
 
reg [3:0] a;
rand reg [7:0] b;
rand reg [15:0] c;
 
function new(input string inst = "INST");
super.new(inst);
this.a = 12;
endfunction
 
`uvm_object_utils_begin(simple)
`uvm_field_int(a,UVM_DEFAULT)
`uvm_field_int(b,UVM_DEFAULT)
`uvm_field_int(c,UVM_DEFAULT)
`uvm_object_utils_end
 
endclass
 
module tb;
simple s;
 
initial begin
s = new();
s.randomize();
s.print();
end
endmodule
 

