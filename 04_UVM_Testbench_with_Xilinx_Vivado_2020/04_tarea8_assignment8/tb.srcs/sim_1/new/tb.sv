`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2023 23:47:32
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

//Create transaction class extending uvm_sequence_item for the RTL module mentioned 
//in the Instruction tab also print the value of the data members inside the class after randomization.

`include "uvm_macros.svh"

import uvm_pkg::*;



//transaction class extenstion of uvm_sequence_item-> uvm_object



class transaction extends uvm_sequence_item;

  //all datta member prnst in module

  rand bit [3:0]mode;

  rand bit rst;

  rand bit clk;

  rand bit loadin;

  bit [15:0]dout;

  bit dbar;

 

  //constraints

  constraint for_mode{mode>4'h1;}

  constraint for_this{clk!=rst;}

   

 

  //constructure

  function new(input string inst="INST");

   super.new(inst);

endfunction 



`uvm_object_utils_begin(transaction)

`uvm_field_int(mode,UVM_DEFAULT)

`uvm_field_int(rst,UVM_DEFAULT)

`uvm_field_int(clk,UVM_DEFAULT)

`uvm_field_int(loadin,UVM_DEFAULT)

`uvm_field_int(dout,UVM_DEFAULT)

`uvm_field_int(dbar,UVM_DEFAULT)



`uvm_object_utils_end



endclass



class adding_datamember extends transaction;

rand bit[15:0]loaddata;





function new (input string inst_s="sinst");



super.new(inst_s);

endfunction



`uvm_object_utils_begin(adding_datamember)

`uvm_field_int(loaddata,UVM_DEFAULT)

`uvm_object_utils_end



endclass



module top(



    );

   

    adding_datamember ta;

    initial begin

    ta=new("inst");

    ta.randomize();

    ta.print();

    end

endmodule
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class transaction extends uvm_sequence_item;
     
//    rand bit [3:0]   mode;
//    rand bit         rst;
//    rand bit         clk;
//    rand bit         loadin;
//    bit      [15:0]  dout;
     
//    function new(input string inst = "TRANS");
//        super.new(inst);
//    endfunction
     
//    `uvm_object_utils_begin(transaction)
//    `uvm_field_int(mode, UVM_DEFAULT)
//    `uvm_field_int(rst, UVM_DEFAULT)
//    `uvm_field_int(clk, UVM_DEFAULT)
//    `uvm_field_int(loadin, UVM_DEFAULT)
//    `uvm_field_int(loadin, UVM_DEFAULT)
//    `uvm_object_utils_end
//endclass
 
//class transaction_statistics extends transaction;
//    rand bit [15:0]  loaddata;
     
     
//    `uvm_object_utils_begin(transaction_statistics)
//    `uvm_field_int(loaddata, UVM_DEFAULT)
//    `uvm_object_utils_end
     
//    function new(input string inst = "TRANS_STAT");
//    super.new(inst);
//    endfunction
 
//endclass
 
 
//module tb;
//    transaction_statistics ts;
     
//    initial begin
//        ts = new("STATS");
//        ts.randomize();  
//        ts.print();
//    end
//endmodule
