`timescale 1ns/1ns

module residue_7(input a2,a1,a0,b2,b1,b0, output r2,r1,r0);
	wire [3:0] S ;
	wire [2:0] T ;
	wire [2:0] A ;
	wire [2:0] B ;
	wire [2:0] R ;
	assign A = {a2,a1,a0};
	assign B = {b2,b1,b0};
	assign#(123,108) S = A + B;
	assign#(108,108) T = S[2:0] + {2'b00, S[3]};
	assign#(27,23)  R = (&T) ? 3'b000 : T ;
	assign r2 = R[2];
	assign r1 = R[1];
	assign r0 = R[0];
endmodule
