/*
`define RESET    3'b0
`define SETSEC   3'b001
`define SETMIN	 3'b010
`define RUN      3'b011
`define STOP     3'b100
`define TIMESUP  3'b101
*/
module TimerController(CLOCK_50, SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3);
	input CLOCK_50;
	input[9:0] SW;
	input[3:0] KEY;
 	output[9:0] LEDR; 
	output[6:0] HEX0;
	output[6:0] HEX1;
	output[6:0] HEX2;
	output[6:0] HEX3;	
	
	parameter RESET = 3'b000;
	parameter SETSEC = 3'b001;
	parameter SETMIN = 3'b010; 
	parameter RUN = 3'b011; 
	parameter STOP = 3'b100; 
	parameter TIMESUP = 3'b101;
	
	/*
	wire reset; 
	//assign reset = ~KEY[0];
	Debouncer db0(CLOCK_50, KEY[0], reset);
    wire set;
	 //assign set = ~KEY[1];
	 Debouncer db1(CLOCK_50, KEY[1], set);
    wire run_stop;
	 //assign run_stop = ~KEY[2];
	Debouncer db2(CLOCK_50, KEY[2], run_stop);
    wire run;
    assign run = (state == `RUN);
    wire timesup;
	*/
	
	/*
	 * After I re-read the description, I assume that our initial state should be set-second state
	 */
	wire reset;
	assign reset = ~KEY[0];
	/*
	wire key0 = KEY[0];
	wire key1 = KEY[1];
	wire key2 = KEY[2];
	*/
	wire secTomin;
	assign secTomin = ((~reset) & (~KEY[1]));
	wire runTostop;
	assign runTostop = ((~reset) & (~KEY[2]));
	wire timesup;
	
	assign LEDR[5] = reset;
	assign LEDR[3] = secTomin;
	assign LEDR[4] = runTostop;
	
	
	
	wire [3:0] unit_sec;
	wire [3:0] tens_sec;
	wire [3:0] unit_min;
	wire [3:0] tens_min;

	// Permission values
	reg set_sec;
	reg set_min;
	reg lightON;
	reg runTime;
	reg stopTime;
	
	//reg[2:0] state = RESET;
	reg[2:0] state = 3'b000;
	
	

	//reg [3:0] count;
	
	//always @(negedge reset or negedge CLOCK_50) begin
	always @(posedge CLOCK_50) begin
		if (reset == 1'b1) begin
			state <= SETSEC;		
			set_sec <= 1'b0;
			set_min <= 1'b0;
			runTime <= 1'b0;
			stopTime <= 1'b0;
			lightON <= 1'b0;
			
			/*
			set_sec <= 1'b1;
			set_min <= 1'b1;
			runTime <= 1'b1;
			stopTime <= 1'b1;
			lightON <= 1'b1;
			*/
		end 
		
		//else begin
			case(state)
			
			SETSEC: begin
				if(secTomin == 1'b1) begin
					if(set_sec == 1'b1) begin
						set_sec <= 1'b0;
						state <= SETMIN;
					end
					if(set_sec == 1'b0) begin
						set_sec <= 1'b1;
					end 
				end
			end
			
			SETMIN: begin
				if(secTomin == 1'b1) begin
					if(set_min == 1'b1) begin
						set_min <= 1'b0;
						state <= RUN;
					end
					if(set_min == 1'b0) begin
						set_min <= 1'b1;
					end 
				end
			end
			/*
			default : begin
				state <= RESET;
			end
			*/
			endcase
		//end
			
		/*	
			RUN: begin
				if(runTostop) begin
					if(runTime == 1'b0) begin
						runTime <= 1'b1;
					end
					else if(runTime == 1'b1) begin
						state <= STOP;
						runTime <= 1'b0;
					end
				end
				
				else if(timesup) begin
					state <= TIMESUP;
				end
				
			end
			
			STOP: begin
				if(runTostop) begin
					if(stopTime == 1'b0) begin
						stopTime <= 1'b1;
					end
					else if(stopTime == 1'b1) begin
						state <= RUN;
						stopTime <= 1'b0;
					end
				end
			end
			
			TIMESUP: begin
				lightON <= 1'b1;
			end	
			
			endcase
		end
		*/
	end
	/*
	CountDown timer(CLOCK_50, reset, set_sec, set_min, run, SW[3:0], SW[7:4], unit_sec, tens_sec, unit_min, tens_min, timesup);
	*/
	
	dec2_7seg display_sec1(unit_sec, HEX0);
	dec2_7seg display_sec2(tens_sec, HEX1);
	dec2_7seg display_sec3(unit_min, HEX2);
	dec2_7seg display_sec4(tens_min, HEX3);
	
	/*
	//assign LEDR = (ZERO_check == 1'b1) ? 10'b1111111111 : 10'b0000000000;*/
	//assign LEDR[2:0] = 3'b000;
	assign LEDR[2:0] = state;
	assign LEDR[9:6] = {set_sec, set_min, runTime, stopTime};

	//assign LEDR[9:6] = count;
	
endmodule
