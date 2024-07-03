`timescale 1ns/1ns

module TB_res7_para_rand();
	logic [47:0]aa = 48'd1;
	wire [2:0]rr ;
	residue7_para#48 UUT(aa, rr);
	initial repeat(2) #1500 aa = ~aa;
	initial begin
		#4207 aa = $random();
		#1207 aa = $random();
		#1207 aa = $random();
		#1207 $stop;
	end
endmodule
