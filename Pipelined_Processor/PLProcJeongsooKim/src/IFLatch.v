module IFLatch (clk, reset, flush, stall, 
				pcIncrementedIn, instIn, 
				pcIncrementedOut, instOut);

	parameter DATA_BIT_WIDTH = 32;
	parameter RESET_VALUE = 0;
	
	input clk;
	input reset;
	input flush;
	input stall;
	input[DATA_BIT_WIDTH - 1: 0] pcIncrementedIn;
	input[DATA_BIT_WIDTH - 1: 0] instIn;
	
	output reg [DATA_BIT_WIDTH - 1: 0] pcIncrementedOut;
	output reg [DATA_BIT_WIDTH - 1: 0] instOut;

	always @ (posedge clk) begin
	
        if (reset) begin
			pcIncrementedOut <= RESET_VALUE;
			instOut <= RESET_VALUE;
        end else if (stall) begin
			// For now, stall does nothing
        end else if (flush) begin
			pcIncrementedOut <= RESET_VALUE;
			instOut <= RESET_VALUE;
		end else begin
			pcIncrementedOut <= pcIncrementedIn;
			instOut <= instIn;
		end
	end

endmodule
