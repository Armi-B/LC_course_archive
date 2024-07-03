`timescale 1ns/1ns

module MSSD_TB2();
    reg clk= 0;
    reg serIn = 1;
    reg reset = 0;
    wire error, outvalid, p0, p1, p2, p3;
    wire [1:0] d;
    MSSD UUT(reset, serIn, clk, p0, p1, p2, p3, error, outvalid, d);
    initial repeat(1000) # 13 clk = ~clk;
    initial begin
            #43 serIn = 1'b0;
            #159 serIn = 1'b1;
            #26 serIn = 1'b0;
            #26 serIn = 1'b1;
            #26 serIn = 1'b0;
            #26 serIn = 1'b1;
            #26 serIn = 1'b0;
            #26 serIn = 1'b1;
            #26 serIn = 1'b0;
            #26 serIn = 1'b1;
            #26 serIn = 1'b0;
            #19 serIn = 1'b1;
            #20 serIn = 1'b0;
            #10 reset = 1'b1;
            #200 $stop;
    end
endmodule


