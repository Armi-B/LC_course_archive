`timescale 1ns/1ns

module Selection_Sort(input clk, incp1, incp2, inz, ldp2, sadp1, sadp2, sdd1, sdd2, ldd1, ldd2, swpd1, input [15:0] data_in, output [15:0] data_out, output [7:0] address, output swp, co1, co2);
    wire [7:0] ns_p1, ns_p2;
    reg [7:0] ps_p1, ps_p2;
    wire [15:0] ns_d1, ns_d2;
    reg [15:0] ps_d1, ps_d2;
    wire [7:0] p1_next, p2_next;

    always@(posedge clk) begin
        ps_d1<=ns_d1;
        ps_d2<=ns_d2;
        ps_p1<=ns_p1;
        ps_p2<=ns_p2;
    end

    assign {co1 , p1_next} =  ps_p1 + 8'd1;
    assign {co2 , p2_next} =  ps_p2 + 8'd1;
    assign ns_p1 = inz ? 8'd0 : incp1 ? p1_next : ps_p1;
    assign ns_p2 = ldp2 ? p1_next : incp2 ? p2_next : ps_p2;
    assign ns_d1 = ldd1 ? data_in : swpd1 ? ps_d2 : ps_d1;
    assign ns_d2 = ldd2 ? data_in : ps_d2;
    assign swp = (ps_d1 > ps_d2) ? 1'b1 : 1'b0;
    assign data_out = sdd1 ? ps_d1 : sdd2 ? ps_d2 : 16'd0;
    assign address = sadp1 ? ps_p1 : sadp2 ? ps_p2 : 16'd0;

endmodule