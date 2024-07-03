`timescale 1ns/1ns

module SS(input [15:0] outBus ,input clk, start, memRdy, output memRead, memWrite, done, output [7:0] addrBus, output [15:0] inBus, output [3:0] ps, output swp, co1, co2);
   
    wire incp1, incp2, inz, ldp2, sadp1, sadp2, sdd1, sdd2, ldd1, ldd2, swpd1;
    SS_controler UUT(clk, start, co1, co2, swp, memRdy, incp1, incp2, inz, ldp2, sadp1, sadp2, sdd1, sdd2, ldd1, ldd2, swpd1, memRead, memWrite, done, ps);
    Selection_Sort UTT(clk, incp1, incp2, inz, ldp2, sadp1, sadp2, sdd1, sdd2, ldd1, ldd2, swpd1, outBus, inBus, addrBus, swp, co1, co2);

endmodule



module SS_controler(input clk, start, co1, co2, swp, memRdy, output incp1, incp2, inz, ldp2, sadp1, sadp2, sdd1, sdd2, ldd1, ldd2, swpd1, read_mem, write_mem, done, output reg [3:0]ps);
    reg [3:0] ns;
    //reg [3:0] ps;

    always@(ps, start, co1, co2, swp, memRdy) begin
        ns=4'd0;
            case(ps)
                0: ns = start ? ps + 4'd1 : ps;
                1: ns = start ? ps : ps + 4'd1;
                2: ns = memRdy ? ps + 4'd1 : ps;
                3: ns = memRdy ? ps + 4'd1 : ps;
                4: ns = swp ? ps + 4'd1 : 4'd7;
                5: ns = memRdy ? ps + 4'd1 : ps;
                6: ns = memRdy ? ps + 4'd1 : ps;
                7: ns = co2 ? ps + 4'd1 : 4'd3;
                8: ns = co1 ?  4'd0 : 4'd2;
                default: ns = 4'd0;
            endcase
    end

    always@(posedge clk) begin

        ps<=ns;
    end

    assign done = (ps==4'd0) ? 1'b1 : 1'b0;
    assign inz = (ps==4'd1) ? 1'b1 : 1'b0;
    assign ldp2 = (ps==4'd2) ? 1'b1 : 1'b0;
    assign sadp1 = (ps==4'd2 || ps==4'd6) ? 1'b1 : 1'b0;
    assign ldd1 = (ps==4'd2) ? 1'b1 : 1'b0;
    assign read_mem = (ps==4'd2 || ps==4'd3) ? 1'b1 : 1'b0;
    assign ldd2 = (ps==4'd3) ? 1'b1 : 1'b0;
    assign sadp2 = (ps==4'd3 || ps==4'd5) ? 1'b1 : 1'b0;
    assign write_mem = (ps==4'd5 || ps==4'd6) ? 1'b1 : 1'b0;
    assign sdd1 = (ps==4'd5) ? 1'b1 : 1'b0;
    assign sdd2 = (ps==4'd6) ? 1'b1 : 1'b0;
    assign swpd1 = (ps==4'd6) ? 1'b1 : 1'b0;
    assign incp2 = (ps==4'd7) ? 1'b1 : 1'b0;
    assign incp1 = (ps==4'd8) ? 1'b1 : 1'b0;

endmodule


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