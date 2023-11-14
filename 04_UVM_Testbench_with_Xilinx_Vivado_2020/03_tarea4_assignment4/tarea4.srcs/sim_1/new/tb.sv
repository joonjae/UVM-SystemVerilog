`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.01.2023 00:54:50
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


//Create a class by extending uvm_component consisting of the three data members 
//(reg [3:0] a, reg [3:0] b and reg [4:0] c), create a method that takes two 
//arguments from user to update data members (a and b). Update data member c with 
//the result of addition of the a and b and print all data members.

`include "uvm_macros.svh"

import uvm_pkg::*;



class simple extends uvm_component;

string inst;

reg [3:0] a;

reg [3:0] b;

reg [4:0] c;



function new(input string inst = "INST", uvm_component comp = null);

super.new(inst, comp);

this.inst = inst;

endfunction



`uvm_object_utils_begin(simple)

`uvm_field_string(inst, UVM_DEFAULT)

`uvm_field_int(a, UVM_DEFAULT)

`uvm_field_int(b, UVM_DEFAULT)

`uvm_field_int(c, UVM_DEFAULT)

`uvm_object_utils_end



task add(reg [3:0] a, reg [3:0] b);

this.a = a;

this.b = b;

c = a + b;

this.print();

endtask



endclass



module tb;

simple s;



initial begin

s = new("COMPONENT", null);

s.randomize();

s.add(3, 4);

//s.print();

end



endmodule


//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class simple extends uvm_component;
 
//string name;
//reg [3:0] a; 
//reg [3:0] b; 
//reg [4:0] c;
 
//function new(input string name, uvm_component comp);
//super.new(name, comp);
//this.name = name;
//endfunction

//function update(reg [3:0] a, reg [3:0] b);
//    this.a = a;
//    this.b = b;
//endfunction

//task run();
//$display("Instance Name : %0s",name);
//this.c = this.a + this.b;
//endtask

//function print();
//$display("Instance Name : %0s",name);
//$display("a : %d",this.a);
//$display("b : %d",this.b);
//$display("c : %d",this.c);
//endfunction
 
//endclass
 
 
//module tb;
 
//simple s;
 
//initial begin
//s = new("Component", null);
//s.update(10,12);
//s.run();
//s.print();
//end
 
//endmodule