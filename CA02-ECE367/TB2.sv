`timescale 1ns/1ns

module CA2Q2TB();
    logic [0:3]AA=4'b1010;
    logic s1=1,s2=0;
    wire  [0:4]SHO;
    SHO4b UUT(AA,s1,s2,SHO);
    initial begin
           #73 s1=0;
           #113 s1=1;
           #113 AA=4'b1000;
           #113 s2=1;
           #113 AA=4'b1100;
           #113 s1=0;
           #73 s1=1;
           #73 $stop;
    end
endmodule
