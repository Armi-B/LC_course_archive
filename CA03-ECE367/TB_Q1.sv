`timescale 1ns/1ns

module TB_res7();
	logic [2:0]A = 3'b001;
	logic [2:0]B = 3'b000;
	wire [2:0]R;
	residue_7 UUT(A[2],A[1],A[0],B[2],B[1],B[0],R[2],R[1],R[0]);
	initial begin
		#307 A = 48'd3;
		#307 A = 48'd4;
		#307 A = 48'd7;
		#307 $stop;
	end
endmodule
