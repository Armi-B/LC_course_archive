`timescale 1ns/1ns

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

