`timescale 1ns/1ns

module TB_res7_48input();
	logic [47:0]aa = 48'd1;
	wire [2:0]rr ;
	residue7_48bit UUT(aa, rr);
	initial begin
		#1207 aa = 48'd2;
		#1207 aa = 48'd7;
		#1207 aa = 48'd5;
		#1207 $stop;
	end
endmodule
