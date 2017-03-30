module IDLatch (clk, reset, flush, stall,
				pcIncrementedIn, regData1In, regData2In, immvalIn, regWriteNoIn, opcodeIn,
				allowBrIn, brBaseMuxSelIn, alu2MuxSelIn, aluOpIn, cmpOpIn, wrMemIn, wrRegIn, dstRegMuxSelIn,
				pcIncrementedOut, regData1Out, regData2Out, immvalOut, regWriteNoOut, opcodeOut,
				allowBrOut, brBaseMuxSelOut, alu2MuxSelOut, aluOpOut, cmpOpOut, wrMemOut, wrRegOut, dstRegMuxSelOut);
				
				
	parameter DATA_BIT_WIDTH = 32;
	parameter RESET_VALUE = 0;
	parameter Mux4bit = 2;
	
	input clk, reset, flush, stall;
	input[DATA_BIT_WIDTH - 1: 0] pcIncrementedIn;
	input[DATA_BIT_WIDTH - 1:0] regData1In, regData2In;
	input[DATA_BIT_WIDTH - 1:0] immvalIn;
	input [3:0] regWriteNoIn;
	input [3:0] opcodeIn;
	
	input allowBrIn;
	input brBaseMuxSelIn;
	input [Mux4bit-1:0] alu2MuxSelIn;
	input [3:0] aluOpIn;
    input [3:0] cmpOpIn;
	input wrMemIn;
    input wrRegIn;
    input [1:0] dstRegMuxSelIn;
		
	output reg [DATA_BIT_WIDTH - 1: 0] pcIncrementedOut;
	output reg [DATA_BIT_WIDTH - 1:0] regData1Out, regData2Out;
	output reg [DATA_BIT_WIDTH - 1:0] immvalOut;
	output reg [3:0] regWriteNoOut;
	output reg [3:0] opcodeOut;
	
	output reg allowBrOut;
	output reg brBaseMuxSelOut;
	output reg [Mux4bit-1:0] alu2MuxSelOut;
	output reg [3:0] aluOpOut;
    output reg [3:0] cmpOpOut;
	output reg wrMemOut;
    output reg wrRegOut;
    output reg [1:0] dstRegMuxSelOut;

	always @ (posedge clk) begin
	
		if(reset || flush) begin
			pcIncrementedOut <= RESET_VALUE;
			regData1Out <= RESET_VALUE;
			regData2Out <= RESET_VALUE;
			immvalOut <= RESET_VALUE;
			regWriteNoOut <= RESET_VALUE;
			allowBrOut <= RESET_VALUE; 
			brBaseMuxSelOut <= RESET_VALUE;
			alu2MuxSelOut <= RESET_VALUE;
			aluOpOut <= RESET_VALUE;
			cmpOpOut <= RESET_VALUE;
			wrMemOut <= RESET_VALUE;
			wrRegOut <= RESET_VALUE;
			dstRegMuxSelOut <= RESET_VALUE;
			opcodeOut <= RESET_VALUE;
		end 
		else if(stall) begin
			// For now, stall does nothing
		end
		else begin
			pcIncrementedOut <= pcIncrementedIn;
			regData1Out <= regData1In;
			regData2Out <= regData2In;
			immvalOut <= immvalIn;
			regWriteNoOut <= regWriteNoIn;
			allowBrOut <= allowBrIn;
			brBaseMuxSelOut <= brBaseMuxSelIn;
			alu2MuxSelOut <= alu2MuxSelIn;
			aluOpOut <= aluOpIn;
			cmpOpOut <= cmpOpIn;
			wrMemOut <= wrMemIn;
			wrRegOut <= wrRegIn;
			dstRegMuxSelOut <= dstRegMuxSelIn;
			opcodeOut <= opcodeIn;
		end
	end

endmodule
