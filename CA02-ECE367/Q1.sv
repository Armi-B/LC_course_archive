`timescale 1ns/1ns
module MUX4to1(input a,b,c,d, input s1, s2, output w);
      wire y, x;
      assign#(19,24) y = s1?a:b;
      assign#(19,24) x = s1?c:d;
      assign#(19,24) w = s2? y:x;
endmodule

