`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.01.2023 23:56:00
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

//Using Configuration Method to Change Verbosity Level : UVM_OBJECT
`include "uvm_macros.svh"
import uvm_pkg::*;
 
 
class object extends uvm_report_object;
`uvm_object_utils(object)
 
function new(input string name = "OBJ");
super.new(name);
endfunction
 
task run();
`uvm_info("OBJ", "Printing String", UVM_HIGH);
endtask
 
endclass
 
module tb;
 
object o;
 
initial begin
o = new("OBJ");
o.set_report_verbosity_level(400);
o.run();
end
endmodule


////Using Configuration Method to Change Verbosity Level : UVM_COMPONENT
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class component extends uvm_component;
//    `uvm_component_utils(component)
     
//    function new(input string name, uvm_component c);
//        super.new(name,c);
//    endfunction
 
//    task run();
//        `uvm_info("COMP", "Printing String", UVM_HIGH);
//    endtask
 
//endclass
 
 
//module tb;
//    component c;
//    integer level;
     
//    initial begin
//        c = new("COMP2", null);
//        c.set_report_verbosity_level(400);
//        level = c.get_report_verbosity_level();
//        `uvm_info("VER", $sformatf("Verbosity Level : %0d",level), UVM_NONE);
//        c.run();
//    end
//endmodule

////Using object_utils and printing specific data on Console
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class simple extends uvm_object;
//    `uvm_object_utils(simple)
     
//    rand bit [3:0] a;
//    string inst;
     
//    function new(input string inst = "INST");
//        super.new(inst);
//        this.inst = inst;
//    endfunction
     
//    virtual function void do_print(uvm_printer printer);
//        super.do_print(printer);
//        printer.print_field_int("a", a,$bits(a),UVM_DEC);
//        printer.print_string("INST",inst);
//    endfunction
 
//endclass
 
 
//class test extends uvm_test;
//    `uvm_component_utils(test)
     
//    function new(input string name, uvm_component c);
//        super.new(name,c);
//    endfunction
     
//    function void build_phase(uvm_phase phase);
//        simple s = simple::type_id::create("INST");
//        s.randomize();
//        s.print();
//    endfunction
 
//endclass
 
//module tb;
//    test t;
     
//    initial begin
//        t = new("TEST",null);
//        run_test();
//    end
//endmodule
 


////Using Create() method instead of new()
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class simple extends uvm_object;
 
//    rand bit [3:0] a;
//    rand bit [3:0] b[4];
//    string inst;
     
//    function new(input string inst = "INST");
//        super.new(inst);
//        this.inst = inst;
//    endfunction
     
//    `uvm_object_utils_begin(simple)
//    `uvm_field_int(a, UVM_DEFAULT)
//    `uvm_field_sarray_int(b, UVM_DEFAULT)
//    `uvm_field_string(inst, UVM_DEFAULT)
//    `uvm_object_utils_end
 
//endclass
 
 
//class test extends uvm_test;
//    `uvm_component_utils(test)
     
//    function new(input string name, uvm_component c);
//        super.new(name,c);
//    endfunction
     
//    function void build_phase(uvm_phase phase);
//        simple s = simple::type_id::create("INST");
//        s.randomize();
//        s.print();
//    endfunction
 
//endclass
 
//module tb;
//    test t;
     
//    initial begin
//        t = new("TEST",null);
//        run_test();
//    end
//endmodule

//// Understanding usage of UVM_COMPONENT
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class simple extends uvm_component;
 
//string name;
 
//function new(input string name, uvm_component c);
//super.new(name, c);
//this.name = name;
//endfunction
 
//task run();
//$display("Instance Name : %0s",name);
//endtask
 
//endclass
 
 
//module tb;
 
//simple s;
 
//initial begin
//s = new("Component", null);
//s.run();
//end
 
//endmodule



//// Understanding usage of UVM_OBJECT class
//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
 
//class simple extends uvm_object;
 
//rand bit [3:0] a;
//string inst;
//rand bit [3:0] b[4];
 
//function new(input string inst = "INST");
//super.new(inst);
//this.inst = inst;
//endfunction
 
//`uvm_object_utils_begin(simple)
//`uvm_field_int(a,UVM_DEFAULT)
//`uvm_field_sarray_int(b, UVM_DEFAULT)
//`uvm_field_string(inst, UVM_DEFAULT)
//`uvm_object_utils_end
 
//endclass
 
//module tb;
//simple s;
 
//initial begin
//s = new("INST");
//s.randomize();
//s.print();
//end
//endmodule