// ----------------------------------------------------------------------------------
// File        : tb_priority_enc.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : tb_priority_enc
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Priority Encoder. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_priority_enc;
    logic [3:0] in;
    logic [1:0] out;
    logic valid;

    priority_enc dut(.*);

    covergroup cg_enc;
        cp_in : coverpoint in {
            bins b0 = {1};   // 0001
            bins b1 = {2};   // 0010
            bins b2 = {4};   // 0100
            bins b3 = {8};   // 1000
            bins others = default;
        }
    endgroup

    cg_enc cg = new();

    initial begin
        $dumpfile("priorityenc.vcd"); // waveform file
      $dumpvars(0, tb);             // dump all tb + dut signals

        repeat (50) begin
            in = $urandom_range(0,15);
            #5;
            cg.sample();
        end
        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
    end
endmodule
