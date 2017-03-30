`timescale 1ns/1ps

module SCProc_tb();

reg clk, reset;
wire [9:0] LEDR;
wire [6:0] HEX0,HEX1,HEX2,HEX3;
wire [9:0] SW;
wire [3:0] KEY;

Project2 SCProc(SW, KEY, LEDR, HEX0, HEX1, HEX2, HEX3, clk, reset);

initial begin
    $display("***************************************");
    $display ("Testing SCProc");
    $display("***************************************");

    // initialize
    clk = 0;
    reset = 1;
    @(negedge clk);
    reset = 0;

    //@(posedge next);
    // do something

    //@(posedge next);
    // do something

//#80 reset = 1;
    //@(negedge clk);
    //reset = 0;

    //@(posedge next);
    
end

always #5 clk = ~clk;

endmodule

