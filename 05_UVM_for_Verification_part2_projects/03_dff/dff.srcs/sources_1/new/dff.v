`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2023 23:12:53
// Design Name: 
// Module Name: dff
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


module dff(
        input   din,
        input   rst,
        input   clk,
        output  reg dout
    );

    always @(posedge clk)begin
        if (rst) 
            dout <= 1'b0;
        else
            dout <= din; 
    end
endmodule
