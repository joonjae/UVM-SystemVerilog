`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.12.2022 16:22:25
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

//////////////////////////////////////////////////////////////////////////////////
// Understanding factory usage part2 y 3
//////////////////////////////////////////////////////////////////////////////////

class employee_record;
int age;
string name;
 
function new (input string name, input int age);
this.age  = age;
this.name = name;
endfunction
 
virtual function void run();
$display("Error");
endfunction
 
endclass
 
 
class hardware extends employee_record;
 
function new(input string name,input int age);
super.new(name,age);
endfunction
 
function void run();
$display("Hardware Engg Name : %0s and Age : %0d",name,age);
endfunction
 
endclass
 
class software extends employee_record;
 
function new(input string name,input int age);
super.new(name,age);
endfunction
 
function void run();
$display("Software Engg Name : %0s and Age : %0d",name,age);
endfunction
 
endclass
 
class factory;
 
 
static function employee_record add_record (input string cat, input string name,input int age);
hardware h;
software s;
 
case(cat)
"hardware": begin
h = new(name,age);
return h;
end
 
"software": begin
s = new(name,age);
return s;
end
 
default: $stop();
endcase
endfunction
 
endclass
 
 
module tb;
 
employee_record t;
 
 
initial begin
t = factory::add_record("hardware","abc",25);
t.run();
end
 
endmodule


//////////////////////////////////////////////////////////////////////////////////
// Understanding factory usage part1
//////////////////////////////////////////////////////////////////////////////////
 
//class drv;
 
//int data1,data2;
 
//function new(input int data1, input int data2);
//this.data1 = data1;
//this.data2 = data2;
//endfunction
 
//task run();
//$display("Data1 : %0d and Data2 : %0d",this.data1,this.data2);
//endtask
 
//endclass
 
//////////////////////////
 
//class env;
 
//drv d;
 
//task run();
//d = new(12,14);
//d.run();
//endtask
 
 
//endclass
 
/////////////////////////////
 
//module tb;
//env e;
 
//initial begin
//e = new();
//e.run();
//end
//endmodule
 


//////////////////////////////////////////////////////////////////////////////////
// Polymorphism
//////////////////////////////////////////////////////////////////////////////////

//class employee_record;
//    int age;
//    string name;
     
//    function new (input string name, input int age);
//    this.age  = age;
//    this.name = name;
//    endfunction
     
//    virtual function void run();
//    $display("Error");
//    endfunction
//endclass
 
 
//class hardware extends employee_record;
//    function new(input string name,input int age);
//        super.new(name,age);
//    endfunction
     
//    function void run();
//        $display("Hardware Engg Name : %0s and Age : %0d",name,age);
//    endfunction
     
//    endclass
     
//    class software extends employee_record;
    
//    function new(input string name,input int age);
//        super.new(name,age);
//    endfunction
     
//    function void run();
//        $display("Software Engg Name : %0s and Age : %0d",name,age);
//    endfunction
//endclass
 
//module tb;
//employee_record e;
//hardware h;
//software s;
 
//initial begin
//    h = new("Jayesh", 25);
//    s = new("Dhiraj", 25);
//    e = h;
//    e.run();
//    h.run();
//    s.run();
//end
 
//endmodule



