`timescale 1ns/1ns

module MSSD(input reset, serIn, clk, output reg p0, p1, p2, p3, output error, outvalid, output [1:0] d);

    reg [3:0] ns;
    reg [3:0] ps = 4'd0;
    wire ld1, ld2;
    wire ci, on, done;
    wire [1:6] LD;
    wire [3:6] S0, S1;
    wire [3:9] ns_comb;
    reg [3:9] ps_comb;
    wire [1:2] ns_comb_2;
    reg [1:2] ps_comb_2;
    wire [3:9] decremented;
    wire D;

    always@(ps, serIn, done) begin
        ns=4'd0;
            case(ps)
                0: ns = serIn ? 4'd0 : ps + 4'd1;
                1: ns = ps + 4'd1;
                2: ns = ps + 4'd1;
                3: ns = ps + 4'd1;
                4: ns = ps + 4'd1;
                5: ns = ps + 4'd1;
                6: ns = ps + 4'd1;
                7: ns = ps + 4'd1;
                8: ns = done ?  4'd0 : 4'd8;
                default: ns = 4'd0;
            endcase
    end

    always@(posedge clk, posedge reset) begin
        if(reset)
            ps<= 4'd0;
        else
            ps<=ns;
    end

    assign ci = (ps == 4'd8) ? 1'b1 : 1'b0;
    assign on = (ps == 4'd8) ? 1'b1 : 1'b0;
    assign S1 = (on) ? 4'b1111 : 4'd0;
    assign ld1 = (ps==4'd1) ? 1'b1 : 1'b0;
    assign ld2 = (ps==4'd2) ? 1'b1 : 1'b0;
    assign LD = {ld1, ld2, 4'b1111};
    assign S0[3] = (ps==4'd3)? 1'b1 : 1'b0;
    assign S0[4] = (ps==4'd4)? 1'b1 : 1'b0;
    assign S0[5] = (ps==4'd5)? 1'b1 : 1'b0;
    assign S0[6] = (ps==4'd6)? 1'b1 : 1'b0;

    always@(posedge clk) begin
        ps_comb<=ns_comb;
        ps_comb_2<=ns_comb_2;
    end

    assign decremented = ci ? ps_comb - 7'd1 : ps_comb;
    assign ns_comb_2[1] = LD[1] ? serIn : ps_comb_2[1];
    assign ns_comb_2[2] = LD[2] ? serIn : ps_comb_2[2];
    assign ns_comb[3] = LD[3] ? (S0[3]&& ~S1[3]) ? serIn : (~S0[3]&& S1[3]) ? decremented[3] :ps_comb[3]:ps_comb[3];
    assign ns_comb[4] = LD[4] ? (S0[4]&& ~S1[4]) ? serIn : (~S0[4]&& S1[4]) ? decremented[4] :ps_comb[4]:ps_comb[4];
    assign ns_comb[5] = LD[5] ? (S0[5]&& ~S1[5]) ? serIn : (~S0[5]&& S1[5]) ? decremented[5] :ps_comb[5]:ps_comb[5];
    assign ns_comb[6] = LD[6] ? (S0[6]&& ~S1[6]) ? serIn : (~S0[6]&& S1[6]) ? decremented[6] :ps_comb[6]:ps_comb[6];
    assign ns_comb[7] = ~ci ? 1'b0: decremented[7];
    assign ns_comb[8] = ~ci ? 1'b0: decremented[8];
    assign ns_comb[9] = ~ci ? 1'b0: decremented[9];
    assign done = decremented==7'd0 ? 1'b1 : 1'b0;
    assign outvalid = on;
    assign d[1] = ns_comb_2[1];
    assign d[0] = ns_comb_2[2];
    assign error = (~outvalid)&&(~serIn);
    assign D = on & serIn;
    
    always@(d, D)begin
        p0 =1'b0;
        p1 =1'b0;
        p2 =1'b0;
        p3 =1'b0;
            case(d)
                2'b00: p0 = D;
                2'b01: p1 = D;
                2'b10: p2 = D;
                2'b11: p3 = D;
            endcase
    end
endmodule

