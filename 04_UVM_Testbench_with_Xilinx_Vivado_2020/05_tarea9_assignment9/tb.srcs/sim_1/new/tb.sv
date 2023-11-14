`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.01.2023 00:58:14
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

//Design SV testbench capable of sending the data (reg [7:0] din = 8'h11) 
//from Component A to Component B using TLM blocking Port. Achieve the connection 
//between the port and the Implementation in the TEST class instead of the ENV class 
//as we did in our previous lecture.
`include "uvm_macros.svh"

import uvm_pkg::*;

class compA extends uvm_component;

`uvm_component_utils(compA)



int din = 8'h11;



uvm_blocking_put_port #(int) send;

function new(input string inst = "COMPA", uvm_component c);

super.new(inst, c);

send  = new("PUT", this);

endfunction

task run();

`uvm_info("CompA", $sformatf("Sending data to CompB %0d",din), UVM_NONE);

send.put(din);

endtask

endclass

class compB extends uvm_component;

`uvm_component_utils(compB)

uvm_blocking_put_imp #(int,compB) recv;

function new(input string inst = "COMPB", uvm_component c);

super.new(inst, c);

recv  = new("RECV", this);

endfunction

virtual task put(input int t);

`uvm_info("COMPB", $sformatf("Data received : %0d",t), UVM_NONE);

endtask

endclass

class env extends uvm_env;

`uvm_component_utils(env)

function new(input string inst = "ENV", uvm_component c);

super.new(inst, c);

endfunction

virtual function void build_phase(uvm_phase phase);

super.build_phase(phase);



endfunction

virtual function void connect_phase(uvm_phase phase);

super.connect_phase(phase);



endfunction

endclass

class test extends uvm_test;

`uvm_component_utils(test)



compA a;

compB b;

env e;

function new(input string inst = "TEST", uvm_component c);

super.new(inst, c);

endfunction

virtual function void build_phase(uvm_phase phase);

super.build_phase(phase);

a = compA::type_id::create("compA",this);

b = compB::type_id::create("compB",this);

e = env::type_id::create("ENV",this);

endfunction



virtual function void connect_phase(uvm_phase phase);

super.connect_phase(phase);

a.send.connect(b.recv);

endfunction

virtual task run_phase(uvm_phase phase);

#100;

global_stop_request();

endtask

endclass

module tlm_ports;

test t;

initial begin

t = new("TEST", null);

run_test();

end

endmodule



//`include "uvm_macros.svh"
//import uvm_pkg::*;
 
//class component_a extends uvm_component;
//    `uvm_component_utils(component_a)
     
//    bit [7:0] din = 8'h11;
     
//    uvm_blocking_put_port #(bit [7:0]) send;
     
//    function new(input string inst = "C_A", uvm_component c);
//        super.new(inst, c);
//        send  = new("PUT", this);
//    endfunction
     
//    task run();
//        `uvm_info("C_A", $sformatf("Sending data to C_B %0d",din), UVM_NONE);
//        send.put(din);
//    endtask
 
//endclass
 
//class component_b  extends uvm_component;
//    `uvm_component_utils(component_b)

//    uvm_blocking_put_imp #(bit [7:0],component_b)  recv;

//    function new(input string inst = "C_B", uvm_component c);
//        super.new(inst, c);
//        recv  = new("RECV", this);
//    endfunction
     
//    virtual task put(input int t);
//        `uvm_info("C_B", $sformatf("Data received : %0d",t), UVM_NONE);
//    endtask
//endclass
 
//class env extends uvm_env;
//    `uvm_component_utils(env)
//    component_a a;
//    component_b b;
//    function new(input string inst = "ENV", uvm_component c);
//       super.new(inst, c);
//    endfunction
     
//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        a = component_a::type_id::create("PROD",this);
//        b = component_b::type_id::create("CONS", this);
//    endfunction
     
//    virtual function void connect_phase(uvm_phase phase);
//        super.connect_phase(phase);
//        a.send.connect(b.recv);
//    endfunction
//endclass
 
//class test extends uvm_test;
//    `uvm_component_utils(test)
//    env e;
//    function new(input string inst = "TEST", uvm_component c);
//        super.new(inst, c);
//    endfunction
//    virtual function void build_phase(uvm_phase phase);
//        super.build_phase(phase);
//        e = env::type_id::create("ENV",this);
//    endfunction
//    virtual task run_phase(uvm_phase phase);
//        #100;
//        global_stop_request();
//    endtask
//endclass
 
//module tb;
//    test t;
//    initial begin
//        t = new("TEST", null);
//        run_test();
//    end
//endmodule
 