`timescale 1ns/1ns

module residue7_48bit(input [47:0]A, output [2:0]R);
	wire C[4:0][47:0];
	genvar i, j, k;
	generate
		for(k=0; k<48; k=k+1) begin:out
		    assign C[4][k] = A[k];
		end
		for(i=4; i>0; i=i-1) begin:rows
			for(j=0; j<2*i; j=j+1) begin:residues
			    residue_7 xx(C[i][47-j*6],C[i][46-j*6],C[i][45-j*6],C[i][44-j*6],C[i][43-j*6],C[i][42-j*6],C[i-1][47-j*3],C[i-1][46-j*3],C[i-1][45-j*3]);
			end
		end
	endgenerate
	assign R[2] = C[0][47];
	assign R[1] = C[0][46];
	assign R[0] = C[0][45];
endmodule
