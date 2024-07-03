`timescale 1ns/1ns

module CA2Q3TB();
    logic [0:15]AA=16'b1111000011110000;
    logic [0:3]SS=4'b1111;
    wire  w;
    MUX16to1 UUT(AA,SS,w);
    initial begin
           #113 SS=4'b1110;
           #113 SS=4'b1100;
           #113 AA=16'b0000111100001111;
           #113 SS=4'b1101;
           #113 AA=16'b1010101010101010;
           #113 SS=4'b1001;
           #113 SS=4'b0001;
           #211 $stop;
    end
endmodule
