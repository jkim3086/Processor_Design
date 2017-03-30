module BranchPrediction(clk, predict_pc, update_pc, update, reality, prediction);
    parameter INST_BIT_WIDTH = 32
    input clk;
    input update;
    input reality;
    input [INST_BIT_WIDTH-1:0] predict_pc;
    input [INST_BIT_WIDTH-1:0] update_pc;
    output prediction;

    reg [11:0] ghr;
    reg [1:0] gp_table [4095:0];

    reg [1:0] gplp_sel_table [4095:0];

    reg [9:0] lh_table [1023:0];
    reg [2:0] lp_table [1023:0];
    wire gp;
    wire lp;
    wire gplp_sel;
    assign predition = (gplp_sel) ? gp : lp;
    assign gp = gp_table[ghr];
    assign gplp_sel = gplp_sel_table[ghr][1]
    assign lp = lp_table[lh_table[update_pc[11:2]]];


    always @(posedge clk) begin
        if (update) begin
            ghr <= (ghr << 1) & reality;
            if (reality) begin
                if (gp_table[ghr] != 2'b11) begin
                    gp_table[ghr] <= gp_table[ghr] + 1;
                end
            end else begin
                if (gp_table[ghr] != 2'b00) begin
                    gp_table[ghr] <= gp_table[ghr] - 1;
                end
            end
            if (reality) begin
                if (gplp_sel_table[ghr] != 2'b11) begin
                    gplp_sel_table[ghr] <= gplp_sel_table[ghr] + 1;
                end
            end else begin
                if (gplp_sel_table[ghr] != 2'b00) begin
                    gplp_sel_table[ghr] <= gplp_sel_table[ghr] - 1;
                end
            end
        end
    end
endmodule
