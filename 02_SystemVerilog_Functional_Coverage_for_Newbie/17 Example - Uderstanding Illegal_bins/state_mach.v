<<<<<<< HEAD
module state_mach(
input rst,clk,
input din,
output logic dout
);
 
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
  
reg [1:0] state, next_state;  
 
/////////////Reset Logic
always_ff@(posedge clk)
begin
if(rst == 1'b1)
state <= s0;
else
state <= next_state;
end
 
///////////////Next state Decoder Logic
always_comb
begin
  case(state)
s0: begin
if(din == 1'b1)
next_state = s1;
else
next_state = s0;
end
 
s1: begin
if(din == 1'b1)
next_state = s2;
else
next_state = s1;
end
  
s2: begin
if(din == 1'b1)
next_state = s0;
else
next_state = s2;
end  
 
default : next_state = s0;
endcase
end
 
///////////////Output Logic
 
always_comb
begin
case(state)
s0: dout = 1'b0;
s1: dout = 1'b0;
s2: dout = 1'b1;  
default : dout = 1'b0;
endcase
end
 
 
 
=======
module state_mach(
input rst,clk,
input din,
output logic dout
);
 
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;
  
reg [1:0] state, next_state;  
 
/////////////Reset Logic
always_ff@(posedge clk)
begin
if(rst == 1'b1)
state <= s0;
else
state <= next_state;
end
 
///////////////Next state Decoder Logic
always_comb
begin
  case(state)
s0: begin
if(din == 1'b1)
next_state = s1;
else
next_state = s0;
end
 
s1: begin
if(din == 1'b1)
next_state = s2;
else
next_state = s1;
end
  
s2: begin
if(din == 1'b1)
next_state = s0;
else
next_state = s2;
end  
 
default : next_state = s0;
endcase
end
 
///////////////Output Logic
 
always_comb
begin
case(state)
s0: dout = 1'b0;
s1: dout = 1'b0;
s2: dout = 1'b1;  
default : dout = 1'b0;
endcase
end
 
 
 
>>>>>>> origin/main
endmodule