module Shifter(in, out);

parameter BIT_WIDTH = 32;
parameter SHIFT_BITS = 2;

input [BIT_WIDTH-1:0] in;
output [BIT_WIDTH-1:0] out;

assign out = in << SHIFT_BITS;

endmodule
