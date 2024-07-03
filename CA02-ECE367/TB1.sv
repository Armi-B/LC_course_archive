`timescale 1ns/1ns

module CA2Q1TB();
    logic aa=1,bb=0,cc=1,dd=0,s1=1,s2=0;
    wire w;
    MUX4to1 UUT(aa,bb,cc,dd,s1, s2,w);
    initial begin
           #57 s1=0;
           #57 s1=1;
           #57 dd=~dd;
           #57 cc=~cc;
           #57 s1=0;
           #57 s1=1;
           #57 $stop;
    end
endmodule
