module RegFile (clk, reset, rd, rs1, rs2, wrt_en, wrt_data, out1, out2);

	parameter ADDR_LEN = 4;
	parameter DATA_LEN = 32;

	input clk, reset;

	input [ADDR_LEN - 1 : 0] rd;
	input [ADDR_LEN - 1 : 0] rs1;
	input [ADDR_LEN - 1 : 0] rs2;

	input wrt_en;
    input [DATA_LEN - 1 : 0] wrt_data;
	
	output [DATA_LEN - 1 : 0] out1;
	output [DATA_LEN - 1 : 0] out2;
	
	reg [DATA_LEN - 1 : 0] data [0 : (1 << ADDR_LEN) - 1];
	
	assign out1 = data[rs1];
	assign out2 = data[rs2];

    integer i;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            for (i = 0; i < (1 << ADDR_LEN) - 1; i = i + 1) begin
                data[i] <= 0;
            end
        end else if (wrt_en) begin
			data[rd] <= wrt_data;
        end
    end

endmodule
