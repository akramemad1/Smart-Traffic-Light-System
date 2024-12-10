module Traffic_light_controller(
input s1_xL, s2_xL, s1_xR, s2_xR, s1_yU, s2_yU, s1_yD, s2_yD, clk, reset,
output reg Xlg,Xrg, Xly,Xry, Xlr,Xrr, Yug,Ydg, Yuy,Ydy, Yur,Ydr
	);
localparam s0=0,s1=1,s2=2,
			s3=3,s4=4,s5=5,s6=6,
			short_wait_time = 5, // 5 time units
			long_wait_time = 15; // 15 time units
		wire	X_empty  = ~s1_xL | ~s1_xR;
		wire	Y_empty  =~s1_yU | ~s1_yD;
		wire	car_at_X = s1_xL | s1_xR;
		wire	car_at_Y = s1_yU | s1_yD;
		wire	jam_at_X = s2_xL | s2_xR;
		wire	jam_at_Y =s2_yU | s2_yD;
reg [2:0] current_state, next_state;
reg [3:0] counter; 
always@(posedge clk, posedge reset)begin
	if(reset)begin
		current_state <= s6; //all red if reset is pressed
		counter <= 0;
		end
	else if(counter == 0)begin
		current_state <= next_state;
		case (next_state)
			s0:counter <= short_wait_time;
			s1:counter <= short_wait_time;
			s2:counter <= long_wait_time;
			s3:counter <= short_wait_time;
			s4:counter <= short_wait_time;
			s5:counter <= long_wait_time;
			s6:counter <= short_wait_time;
		endcase
	end
	else begin
		counter <= counter - 1;
	end
end		

always@(*)begin
 next_state = current_state;
	case(current_state)
		s0: if(Y_empty)
			next_state = s0;
		else
			next_state = s1; // car at y
		s1: if(jam_at_Y)
			next_state = s2; //longer time case
		else 
			next_state= s3; //normal time case
		s2:if(car_at_X)
			next_state = s4;
		else 
			next_state = s3;
		s3: if(X_empty)
			next_state = s3;
		else 
			next_state = s4;
		s4:if(jam_at_X)
			next_state = s5;
		else next_state = s0;
		s5: if(car_at_Y)
			next_state = s1;
		else 
			next_state = s0;
		default: next_state = s0; // X is main direction
	endcase
end

always@(*)begin
	Xlg = 0;
	Xrg = 0;
	Xly = 0;
	Xry = 0;
	Xlr = 0;
	Xrr = 0;
 	Yug = 0;
 	Ydg = 0;
 	Yuy = 0;
 	Ydy = 0;
 	Yur = 0;
	Ydr = 0;
	case(current_state)
		s0,s5: begin
			Xlg = 1;
			Yur = 1;
			Xrg = 1;
			Ydr = 1;
		end
		s1:begin
			Xly = 1;
			Yur = 1;
			Xry = 1;
			Ydr = 1;
		end
		s2,s3:begin
		Yug = 1;
		Xlr = 1;
		Ydg = 1;
		Xrr = 1;
	end
	s4:begin
		Yuy = 1;
		Xlr = 1;
		Ydy = 1;
		Xrr = 1;
	end
	s6: begin
		Xlr = 1;
		Yur = 1;
		Xrr = 1;
		Ydr = 1;
	end
	default: begin
	Xlg = 0;
	Xrg = 0;
	Xly = 0;
	Xry = 0;
	Xlr = 0;
	Xrr = 0;
 	Yug = 0;
 	Ydg = 0;
 	Yuy = 0;
 	Ydy = 0;
 	Yur = 0;
	Ydr = 0;
 end
	endcase
end

endmodule