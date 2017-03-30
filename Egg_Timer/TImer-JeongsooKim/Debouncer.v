module Debouncer(clk, pb, dpb);
input clk;
input pb;
output dpb;

reg ff_out1;
always @(posedge clk) begin
	ff_out1 <= pb;
end
reg ff_out2;
always @(posedge clk) begin
	ff_out2 <= ff_out1;
end

//FlipFlop ff1(clk, reset, pb, ff_out1);
//FlipFlop ff2(clk, reset, ff_out1, ff_out2);

assign dpb = ~(ff_out1 ~^ ff_out2 & ff_out1);
//reg [15:0] PB_cnt;
//always @(posedge clk)
//if(dpb == ff_out2)
//    PB_cnt <= 0;
//else
//begin
//    PB_cnt <= PB_cnt + 1'b1;  
//    if(PB_cnt == 16'hffff) dpb <= ~dpb;  
//end
endmodule
