`timescale 1ns/1ns

module MUX16to1(input [0:15]A, input [0:3]S, output w);
      wire [0:3]j;
      genvar i;
      generate
          for(i=0; i<4; i=i+1) begin: muxgates
              MUX4to1 xx(A[4*i],A[4*i+1],A[4*i+2],A[4*i+3],S[0],S[1],j[i]);
          end
      endgenerate
      MUX4to1 UUT(j[0],j[1],j[2],j[3],S[2],S[3],w);
endmodule
