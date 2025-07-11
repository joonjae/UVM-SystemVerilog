// Code your design here
 
module ram (
input clk, wr,
input [7:0] din,
output reg [7:0] dout,
input [3:0] addr
);
  
  reg [7:0] mem [15:0];  
  
  always@(posedge clk)
    begin
      if(wr)
        begin
          mem[addr] <= din;
        end
      else
        begin
          dout <= mem[addr];
        end
    end
  
  
endmodule
 
///////////////////////////////////////
 
interface ram_if;
  logic clk;
  logic wr;
  logic [7:0] din;
  logic [7:0] dout;
  logic [3:0] addr;
endinterface