// ----------------------------------------------------------------------------------
// File        : tb_dff.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : tb_dff
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for D Flip Flop. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
class packet;
    rand bit d;
    rand bit rst;

    // Weight distribution: rst=0 → 90%, rst=1 → 10%
    constraint c1 { rst dist {0 := 90, 1 := 10}; }
endclass

module tb_dff;

    logic clk = 0;
    logic rst;
    logic d;
    logic q;

    dff dut (.*);

    // Clock generation
    always #5 clk = ~clk;

    // Covergroup sampled on clock edge
    covergroup cg @(posedge clk);
        cross_rst_d : cross rst, d;
    endgroup

    cg      c_inst = new();
    packet pkt    = new();

    initial begin
        // ---- WAVEFORM DUMP ----
        $dumpfile("dff.vcd");
        $dumpvars(0, tb);

        repeat (100) begin
            pkt.randomize();
            rst <= pkt.rst;
            d   <= pkt.d;
            @(posedge clk);
        end

        $display("Coverage : %0.2f %%", c_inst.get_inst_coverage());
        $finish;
    end

endmodule
