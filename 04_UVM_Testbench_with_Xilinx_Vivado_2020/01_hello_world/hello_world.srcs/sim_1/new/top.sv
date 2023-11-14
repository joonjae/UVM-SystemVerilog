`include "uvm_macros.svh"
import uvm_pkg::*;

class display extends uvm_test;
    `uvm_component_utils(display)
    
    rand bit[15:0] a;
    
    function new(input string name, uvm_component p);
        super.new(name, p);
    endfunction
    
    task run();
    `uvm_info_begin("DISPLAY", "This is table ",UVM_NONE)
    `uvm_message_add_int(a, UVM_DEC)
    `uvm_info_end
    endtask
endclass

module tb;
    display d1;
    initial begin
        d1 = new("DISPLAY",null);
        d1.randomize();
        d1.run();
    end 
endmodule


//`include "uvm_macros.svh"
//module tb;
//   import uvm_pkg::*;
  
//  initial begin
//    `uvm_info("Test 1","Hello World", UVM_NONE);
//     uvm_report_info("TEST 2", "This is Reporting", UVM_MEDIUM);
//     uvm_report_info("TEST 2", "This is Reporting", UVM_FULL); 
//  end
  
//endmodule

// ------------------------------------------------------------------

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//module tb;
 
//initial begin
//`uvm_info("INFO","This is INFO",UVM_NONE);
//`uvm_warning("WARN", "This is Warning");
//`uvm_error("ERROR", "This is Error");
//`uvm_fatal("FATAL", "This is fatal error");
//end
 
//endmodule

// ------------------------------------------------------------------

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//module tb;
//    reg [3:0] a = 4'b1010;
//    reg [15:0 ] b = 16'h1122;
//    integer c = 12;
//    reg d = 1;
         
//    initial begin
//    `uvm_info("INFO",$sformatf("Value of a = %0x",a),UVM_NONE);
//    `uvm_info("INFO",$sformatf("Value of b = %0x",b),UVM_NONE);
//    `uvm_info("INFO",$sformatf("Value of c = %0x",c),UVM_NONE);
//    `uvm_info("INFO",$sformatf("Value of d = %0x",d),UVM_NONE);
//    end
     
//endmodule

// ------------------------------------------------------------------

//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//module tb;
 
//integer data1 = 50;
//reg [15:0] data2 = 16'h1234;
 
//initial begin
//`uvm_info_begin("Table 1", "This is Table 1", UVM_NONE)
//`uvm_message_add_tag("DATA1", "Value")
//`uvm_message_add_int(data1, UVM_DEC)
//`uvm_message_add_int(data1, UVM_BIN)
//`uvm_message_add_int(data1, UVM_HEX)
//`uvm_info_end
 
//`uvm_info_begin("Table 2", "This is Table 2", UVM_NONE)
//`uvm_message_add_tag("DATA2", "Value")
//`uvm_message_add_int(data2, UVM_DEC)
//`uvm_message_add_int(data2, UVM_BIN)
//`uvm_message_add_int(data2, UVM_HEX)
//`uvm_info_end
//end
 
//endmodule

// ------------------------------------------------------------------


//class add;
//reg [3:0] a;
//reg [3:0] b;
 
//function new(input reg [3:0] a,input reg [3:0] b);
//this.a = a;
//this.b = b;
//endfunction
 
//reg [4:0] result;
 
//task add_two();
//result = a + b;
//endtask
 
//endclass
 
//class sub extends add;
 
//function new(input reg [3:0] a, input reg [3:0] b);
//super.new(a,a);
//endfunction
 
//endclass
 
//module temp;
 
//sub a1;
//reg [3:0] a = 12;
//reg [3:0] b = 3;
//reg [4:0] r;
 
//initial begin
//a1 = new(a,b);
//a1.add_two();
//r = a1.result;
//$display("Value of addition : %0d",r);
//end
 
//endmodule