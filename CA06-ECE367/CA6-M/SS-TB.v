`timescale 1ns/1ns
module SS_TB(); 

  reg clk = 0;
  reg start = 0;
  wire rst = 0;
  wire memRdy = 1;
  wire memWrite, memRead, done, swp;
  wire [7:0] addrBus;
  wire [15:0] inBus;
  wire [15:0] outBus;
  wire [3:0] ps;

  SS UTT(outBus , clk, start, memRdy, memRead, memWrite, done, addrBus, inBus, ps, swp, co1, co2);
  RegFile UUT ( clk, inBus, memRead, memWrite, addrBus, outBus);

  initial repeat(1000) # 13 clk = ~clk;
    initial begin
            #43 start = 1'b1;
            #43 start = 1'b0;
            #7000 $stop;
    end

endmodule


