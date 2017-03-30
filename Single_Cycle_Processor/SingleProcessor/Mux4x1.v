module Mux4x1(sel, in0, in1, in2, in3, out);

parameter BIT_WIDTH = 32;

input [1:0] sel;
input [BIT_WIDTH - 1 : 0] in0;
input [BIT_WIDTH - 1 : 0] in1;
input [BIT_WIDTH - 1 : 0] in2;
input [BIT_WIDTH - 1 : 0] in3;
output [BIT_WIDTH - 1 : 0] out;

assign out = (sel== 0) ? in0 : (sel == 1)? in1 : (sel == 2) ? in2 : in3;

endmodule
