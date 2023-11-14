module p_enc (
  input [4:0] pin, ////datain
  output reg [1:0] eout  ///encoded value
);
  
always_comb
  begin
    casez(pin)
      4'b0001: eout = 00;
      4'b001?: eout = 01;
      4'b01??: eout = 10;
      4'b1???: eout = 11;
      default: eout = 00;
    endcase
  end
  
endmodule