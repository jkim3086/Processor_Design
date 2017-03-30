module EXLatch (clk, reset,
				pcIncrementedIn, aluResultIn, condRegResultIn, regData2In, regWriteNoIn,
				wrMemIn, wrRegIn, dstRegMuxSelIn,
				pcIncrementedOut, aluResultOut, condRegResultOut, regData2Out, regWriteNoOut,
				wrMemOut, wrRegOut, dstRegMuxSelOut);
				
				
	parameter DATA_BIT_WIDTH = 32;
	parameter RESET_VALUE = 0;
	parameter Mux4bit = 2;
	
	input clk, reset;
	input[DATA_BIT_WIDTH - 1: 0] pcIncrementedIn;
	input[DATA_BIT_WIDTH - 1:0] aluResultIn;
	input[DATA_BIT_WIDTH - 1:0] condRegResultIn;
	input[DATA_BIT_WIDTH - 1:0] regData2In;
	input [3:0] regWriteNoIn;	
	
	input wrMemIn;
    input wrRegIn;
    input [1:0] dstRegMuxSelIn;
	
	output reg [DATA_BIT_WIDTH - 1: 0] pcIncrementedOut;
	output reg [DATA_BIT_WIDTH - 1:0] aluResultOut;
	output reg [DATA_BIT_WIDTH - 1:0] condRegResultOut; 
	output reg [DATA_BIT_WIDTH - 1:0] regData2Out; 
	output reg [3:0] regWriteNoOut;	
	
	output reg wrMemOut;
    output reg wrRegOut;
    output reg [1:0] dstRegMuxSelOut;

	always @ (posedge clk) begin
	
		if(reset) begin
			pcIncrementedOut <= RESET_VALUE;
			aluResultOut <= RESET_VALUE;
			condRegResultOut <= RESET_VALUE;
			regData2Out <= RESET_VALUE;
			regWriteNoOut <= RESET_VALUE;			
			wrMemOut <= RESET_VALUE;
			wrRegOut <= RESET_VALUE;
			dstRegMuxSelOut <= RESET_VALUE;
		end 
		else begin
			pcIncrementedOut <= pcIncrementedIn;
			aluResultOut <= aluResultIn;
			condRegResultOut <= condRegResultIn;
			regData2Out <= regData2In;
			regWriteNoOut <= regWriteNoIn;			
			wrMemOut <= wrMemIn;
			wrRegOut <= wrRegIn;
			dstRegMuxSelOut <= dstRegMuxSelIn;
		end
	end

endmodule
