`timescale 1ns/1ns

module residue7_para #(parameter s=48)(input [(s-1):0]A, output [2:0]R);
	wire C[($clog2(s/6)+1):0][(s-1):0];
	genvar i, j, k;
	generate
		for(k=0; k<s; k=k+1) begin:out
		    assign C[($clog2(s/6)+1)][k] = A[k];
		end
		for(i=($clog2(s/6)+1); i>0; i=i-1) begin:rows
			for(j=0; j<$pow(2,i); j=j+1) begin:residues
			    residue2_7 xx(C[i][(s-1)-j*6],C[i][(s-2)-j*6],C[i][s-3-j*6],C[i][s-4-j*6],C[i][s-5-j*6],C[i][s-6-j*6],C[i-1][s-1-j*3],C[i-1][s-2-j*3],C[i-1][s-3-j*3]);
			end
		end
	endgenerate
	assign R[2] = C[0][s-1];
	assign R[1] = C[0][s-2];
	assign R[0] = C[0][s-3];
endmodule
