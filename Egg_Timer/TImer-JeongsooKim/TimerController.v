
`define RESET    3'b000
`define SETSEC   3'b001
`define SETMIN	 3'b010
`define RUN      3'b011
`define STOP     3'b100
`define TIMESUP  3'b101

module TimerController(CLOCK_50, SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
	input CLOCK_50;
	input[9:0] SW;
	input[3:0] KEY;
 	output[9:0] LEDR; 
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;	

	wire reset;
	assign reset = ~KEY[0];
	wire set;
	TossleFlipFlop tran1(1, reset, ~KEY[1], set);
	wire run_stop;
	TossleFlipFlop tran2(run_stop_en, reset, ~KEY[2], run_stop);
	wire timesup;
	
	wire [3:0] unit_sec;
	wire [3:0] tens_sec;
	wire [3:0] unit_min;
	wire [3:0] tens_min;

	reg set_sec;
	reg set_min;
	reg lightON;
	reg runTime;
	reg stopTime;
	reg set_en;
	reg run_stop_en;
	reg [31:0] cnt;
	
	reg[2:0] state;
		
	always @(posedge CLOCK_50) begin
		if (reset == 1'b1) begin
			state <= `RESET;							
			set_sec <= 1'b0;
			set_min <= 1'b0;
			runTime <= 1'b0;
			stopTime <= 1'b0;
			lightON <= 1'b0;
			run_stop_en <= 0;
		end
		else begin		
			case(state)
				`RESET: begin
					if(set == 1'b1) begin
						set_sec <= 1'b1;
						state <= `SETSEC;
					end
				end
				`SETSEC: begin
							if(set == 1'b0) begin
								set_sec <= 1'b0;
								set_min <= 1'b1;
								state <= `SETMIN;
							end
				end
				
				`SETMIN: begin
							if(set == 1'b1) begin
								set_min <= 1'b0;
								run_stop_en <= 1;
								state <= `STOP;
							end
			    end
				
				`RUN: begin
					if(run_stop == 1'b0) begin
							runTime <= 1'b0;
							state <= `STOP;
					end else begin
						runTime <= 1'b1;	
					end
					
					if(timesup == 1) begin
						cnt <= 25000000;
						lightON <= 1;
						state <= `TIMESUP;
					end
				end
				
				`STOP: begin
					if(run_stop == 1'b1) begin
							stopTime <= 1'b0;	
							state <= `RUN;
					end else begin
						stopTime <= 1'b1;
					end
				end
				
				`TIMESUP: begin
					cnt <= cnt - 1;
					if (cnt === 0) begin
						cnt <= 25000000;
						lightON <= ~lightON;
					end
				end		
			endcase
		end
	end
	wire run;
	assign run = runTime;
	CountDown timer(CLOCK_50, reset, set_sec, set_min, runTime, SW[3:0], SW[7:4], unit_sec, tens_sec, unit_min, tens_min, timesup);
	
	
	dec2_7seg display_sec1(unit_sec, HEX0);
	dec2_7seg display_sec2(tens_sec, HEX1);
	dec2_7seg display_sec3(unit_min, HEX2);
	dec2_7seg display_sec4(tens_min, HEX3);
	dec2_7seg display_sec5(timesup, HEX4); // Debug

	// Debugging LEDR set
	/*
	assign LEDR[2:0] = state;
	assign LEDR[5] = stopTime;
	assign LEDR[4] = runTostop[0];
	assign LEDR[3] = secTomin[0];
	assign LEDR[9:6] = {set_sec, set_min, runTime, runTostop[1]};
	*/
	assign LEDR = (lightON == 1'b1) ? 10'b1111111111 : 10'b0000000000; 
	
endmodule
