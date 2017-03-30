module ClockDivider (
	inclk0,
	reset,
	c0,
	count_check,
	count_count);
	//locked);
	parameter count_reset = 0;
	parameter count_limit = 12499999;
	input inclk0;
	input reset;
	output reg c0 = 0;
	output reg [31:0] count_count = 0;
	output reg [31:0] count_check = 0;
	//input locked; // clock is paused when locked is 1
	
    reg [31:0] count_100hz = 0;
	always @(posedge inclk0) begin
		if(reset) begin
			count_100hz <= count_reset;
		end	else if(count_100hz < count_limit) begin
			count_100hz <= count_100hz + 1;
		end else begin
			count_100hz <= count_reset;
			c0 <= ~c0;
			if(c0) begin
				count_check <= count_check + 1;
			end
		end
		count_count <= count_100hz;
	end

  // Implement this yourself
  // Slow down the clock to ensure the cycle is long enough for all operations to execute
  // If you don't, you might get weird errors

endmodule
