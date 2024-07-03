`timescale 1ns/1ns

module TB_res7_para();
	logic [11:0]aa = 12'd1;
	wire [2:0]rr ;
	residue7_para#12 UUT(aa, rr);
	initial begin
		#1207 aa = 12'd2;
		#1207 aa = 12'd7;
		#1207 aa = 12'd5;
		#1207 $stop;
	end
endmodule
