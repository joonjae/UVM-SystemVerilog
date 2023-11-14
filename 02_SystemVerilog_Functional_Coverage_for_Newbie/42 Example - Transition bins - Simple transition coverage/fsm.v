<<<<<<< HEAD
module fsm(
	input clk, din,rst,
	output reg dout
);
 
	reg state = 0, next_state =0 ;
	parameter s0 =0, s1=1;
	
	always@(posedge clk)begin
		if(rst)
			state <= s0;
		else
			state <= next_state;
	end
	
	always@(state,din)begin
		case(state)
			s0: begin
				dout = 1'b0;
				if(din == 1'b1)
					next_state = s1;
				else
					next_state = s0;
			end
			s1: begin
				if(din == 1'b1)begin
					next_state = s0;
					dout = 1'b1;
				end
				else begin
					next_state = s1;
					dout = 1'b0;
				end
			end
			default: begin
				next_state <= s0;
				dout <= 1'b0;
			end
		endcase 
	end
=======
module fsm(
	input clk, din,rst,
	output reg dout
);
 
	reg state = 0, next_state =0 ;
	parameter s0 =0, s1=1;
	
	always@(posedge clk)begin
		if(rst)
			state <= s0;
		else
			state <= next_state;
	end
	
	always@(state,din)begin
		case(state)
			s0: begin
				dout = 1'b0;
				if(din == 1'b1)
					next_state = s1;
				else
					next_state = s0;
			end
			s1: begin
				if(din == 1'b1)begin
					next_state = s0;
					dout = 1'b1;
				end
				else begin
					next_state = s1;
					dout = 1'b0;
				end
			end
			default: begin
				next_state <= s0;
				dout <= 1'b0;
			end
		endcase 
	end
>>>>>>> origin/main
endmodule