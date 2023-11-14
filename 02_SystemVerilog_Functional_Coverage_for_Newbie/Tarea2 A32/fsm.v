module fsm(
		input rst, din,clk,
		output reg dout
	);
	parameter s0 = 0;
	parameter s1 = 1;
	parameter s2 = 2;

	reg state = s0, next_state = s0;

	//////////////rst state decoding
	always@(posedge clk)
	begin
		if(rst) 
			state <= s0;
		else
			state <= next_state;
	end

	//////////// next state decoder and output logic decoder

	always@(state,din)
	begin
		case(state)
			s0: begin
			dout = 0;
		if(din)
			next_state = s1;
		else
			next_state = s0;
	end

	s1: begin
			dout = 0;
			if(din)
			next_state = s2;
			else
			next_state = s1;
		end

	s2: begin
		if(din) begin
			next_state = s0;
			dout = 1;
			end
		else begin
			next_state = s0;
			dout = 0;
		end
	end
	default: begin
		next_state = s0;
		dout = 0;  
		end
	endcase 
	end
endmodule