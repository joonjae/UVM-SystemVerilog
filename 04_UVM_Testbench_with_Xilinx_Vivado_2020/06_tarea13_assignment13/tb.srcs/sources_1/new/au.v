`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.02.2023 00:56:12
// Design Name: 
// Module Name: au
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

module au
(
  input [1:0] mode,
  input [3:0] a,b,
  output reg [7:0] y
);
  
  always@(*)
    begin
      case(mode)
        2'b00: y = a + b;
        2'b01: y = a - b;
        2'b10: y = a * b;
        2'b11: y = a / b;
      endcase
    end
endmodule  