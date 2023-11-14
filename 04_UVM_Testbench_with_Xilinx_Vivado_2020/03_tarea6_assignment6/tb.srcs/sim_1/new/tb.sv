`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.01.2023 19:45:09
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

//Create a class extending UVM_OBJECT consisting of a method to print the string "DOUBLE SUCCESS" using UVM_INFO utility with verbosity (UVM_DEBUG).
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class simple extends uvm_report_object;
    `uvm_object_utils(simple)
     
    function new(input string name = "SIMP");
        super.new(name);
    endfunction
     
    task run();
        `uvm_info("SIMP", "DOUBLE SUCCESS", UVM_DEBUG);
    endtask
endclass
 
module tb;
     
    simple os;
     
    initial begin
        os = new("OBJ");
        os.set_report_verbosity_level(600);
        os.run();
    end
endmodule
