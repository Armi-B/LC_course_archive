`timescale 1ns/1ns

module SHO4b(input [0:3]A, input s1, s2, output [0:3]SHO);
      genvar i;
      generate
          for(i=0; i<4; i=i+1) begin: muxgates
              MUX4to1 xx(A[i],A[(i+1)%4],A[(i+2)%4],A[(i+3)%4],s1,s2,SHO[i]);
          end
      endgenerate
endmodule

