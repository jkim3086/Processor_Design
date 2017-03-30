module FlipFlop(clk, reset, dIn, dOut);
	input clk;
	input reset;
	input dIn;
	
	output reg dOut;
	
	always @(posedge reset or posedge clk) begin
		dOut <= dIn;
		if (reset)
			dOut <= 0;
	end
endmodule

module TossleFlipFlop(en, reset, clk, out);
	input en;
	input reset;
	input clk;
	output reg out;
	always @(posedge reset or posedge clk) begin
		if (reset) begin
			out <= 0;
		end else begin
			if (en) begin
				out <= ~out;
			end
		end 
	end
endmodule