`timescale 1ns/1ns

module residue2_7(input a2,a1,a0,b2,b1,b0, output r2,r1,r0);
	wire [5:0] A ;
	wire [2:0] R ;
	assign A = {a2,a1,a0,b2,b1,b0};
	assign#258 R = A%7;
	assign r2 = R[2];
	assign r1 = R[1];
	assign r0 = R[0];
endmodule
