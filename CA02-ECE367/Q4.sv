`timescale 1ns/1ns

module SHO16b(input [0:15]A, input [0:3]S, output [0:15]SHO);
      genvar i,k;
      generate
          for(i=0; i<16; i=i+1) begin: muxgates
              wire [0:15]B;
              for(k=0;k<16;k=k+1)begin: wires
                       assign B[k]=A[(i+k)%16];
              end
              MUX16to1 xx(B,S,SHO[i]);
          end
      endgenerate
endmodule
