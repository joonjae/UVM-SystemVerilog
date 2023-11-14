`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.01.2023 23:29:34
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

//Create a class extending UVM_COMPONENT consisting of a method to print the string 
//"SUCCESS" using UVM_INFO utility with verbosity (UVM_DEBUG).
`include "uvm_macros.svh"

import uvm_pkg::*;



class ass5 extends uvm_component;

 

  `uvm_component_utils(ass5)

 

  function new(input string name, uvm_component c);

    super.new(name, c);

  endfunction

 

  task run();

    `uvm_info("Assigment 5", "SUCCESS", UVM_DEBUG)

  endtask

 

endclass





module ass5;

  ass5 a;

  integer level;

 

  initial begin

    a = new("ASS5", null);

    level = a.get_report_verbosity_level;

    `uvm_info("Verbo", $sformatf("Verbosity level: %0d", level), UVM_NONE)

    a.run();

    a.set_report_verbosity_level(600);

    level = a.get_report_verbosity_level;

    `uvm_info("Verbo", $sformatf("Verbosity level: %0d", level), UVM_NONE)

    a.run();

  end



endmodule
//`include "uvm_macros.svh"
//import uvm_pkg::*;

//class simple extends uvm_component;
//    `uvm_component_utils(simple)
    
//    function new(input string str="SIMP", uvm_component comp=null);
//        super.new(str,comp);
//    endfunction
    
//    task run();
//        `uvm_info("SIMP", "SUCCESS", UVM_DEBUG);
//    endtask
    
//endclass

//module tb;
//    simple c;
     
//    initial begin
//        c = new("COMP", null);
//        c.set_report_verbosity_level(500);
//        c.run();
//    end
//endmodule
