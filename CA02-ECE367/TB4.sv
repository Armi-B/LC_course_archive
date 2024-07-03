`timescale 1ns/1ns

module CA2Q4TB();
    logic [0:15]AA =16'b1010010110100101;
    logic [0:3]SS =4'b1111;
    wire  [0:15]SSHO;
    SHO16b UUT(AA,SS,SSHO);
    initial begin
           #113 SS=4'b0111;
           #113 SS=4'b1111;
           #113 AA=16'b0000111100001111;
           #113 SS=4'b1011;
           #113 AA=16'b1111000011110000;
           #113 SS=4'b1001;
           #73 SS=4'b1000;
           #73 $stop;
    end
endmodule
