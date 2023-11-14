`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2023 00:25:14
// Design Name: 
// Module Name: ram
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


module ram(
input clk,wr,
input [7:0] din,
output reg [7:0] dout,
input [3:0] addr
);
 
reg [7:0] mem [15:0];
integer i = 0;
 
initial begin
for(i = 0; i < 16; i = i + 1) begin
mem[i] = 0;
end
 
end
 
always@(posedge clk)
begin
if(wr == 1'b1)
mem[addr] <= din;
else
dout <= mem[addr];
end
endmodule