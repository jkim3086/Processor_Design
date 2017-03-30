module MEMLatch (clk, reset,
				wrRegDataIn, regWriteNoIn,
				wrRegIn,
				wrRegDataOut, regWriteNoOut,
				wrRegOut);
				
				
	parameter DATA_BIT_WIDTH = 32;
	parameter RESET_VALUE = 0;
	parameter Mux4bit = 2;
	
	input clk, reset;
	input[DATA_BIT_WIDTH - 1: 0] wrRegDataIn;
	input [3:0] regWriteNoIn;	
    input wrRegIn;
	
	output reg [DATA_BIT_WIDTH - 1: 0] wrRegDataOut;
	output reg [3:0] regWriteNoOut;	
    output reg wrRegOut;

	always @ (posedge clk) begin
	
		if(reset) begin
			wrRegDataOut <= RESET_VALUE;
			regWriteNoOut <= RESET_VALUE;						
			wrRegOut <= RESET_VALUE;
		end
		else begin
			wrRegDataOut <= wrRegDataIn;
			regWriteNoOut <= regWriteNoIn;						
			wrRegOut <= wrRegIn;
		end
	end

endmodule