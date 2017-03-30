module CountDown(clk, reset, set_sec, set_min, run, unit_in, tens_in, unit_sec, tens_sec, unit_min, tens_min, timesup);
	input reset; 
	input clk; 
    input set_sec;
    input set_min;
	input run; 
    input [3:0] unit_in;
    input [3:0] tens_in;

	output reg [3:0] unit_sec;
	output reg [3:0] tens_sec;
	output reg [3:0] unit_min;
	output reg [3:0] tens_min;
    output reg timesup;

    reg [31:0] one_sec_cnt;

    //always @(posedge reset or posedge clk or posedge set_sec or posedge set_min) begin
	 always @(posedge reset or posedge clk) begin
        if (reset) begin
            unit_sec <= 0;
            tens_sec <= 0;
            unit_min <= 0;
            tens_min <= 0;
            one_sec_cnt <= 50000000;
            timesup <= 0;
        end else if (set_sec) begin
            unit_sec <= unit_in;
            tens_sec <= tens_in;
        end else if (set_min) begin
            unit_min <= unit_in;
            tens_min <= tens_in;
        end else if (run) begin
            if ({tens_min, unit_min, tens_sec, unit_sec} == 0) begin
                timesup <= 1;
            end else begin
                one_sec_cnt <= one_sec_cnt - 1;
                if (one_sec_cnt == 0) begin
                    one_sec_cnt <= 50000000;
                    if (unit_sec == 0) begin
                        unit_sec <= 9;
                        if (tens_sec == 0) begin
                            tens_sec <= 5;
                            if (unit_min == 0) begin
                                unit_min <= 9;
                                tens_min <= tens_min - 1;
                            end else begin
                                unit_min <= unit_min - 1;
                            end
                        end else begin
                            tens_sec <= tens_sec - 1;
                        end
                    end else begin
                        unit_sec <= unit_sec - 1;
                    end
                    if ({tens_min, unit_min, tens_sec, unit_sec} == 0) begin
                        timesup <= 1;
                    end
                end
            end
        end
    end
endmodule	
