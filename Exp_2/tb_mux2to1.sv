// ----------------------------------------------------------------------------------
// File        : tb_mux2to1.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : tb_mux2to1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for multiplexer. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------

class Transaction;
    rand bit [7:0] a, b;
    rand bit       sel;
endclass


module tb_mux2to1;
    // DUT signals
    logic [7:0] a, b, y;
    logic       sel;

    // DUT instantiation
    mux2to1 dut (.*);

    // Coverage
    covergroup cg_mux;
        cp_sel : coverpoint sel;   // Cover sel = 0 and sel = 1
    endgroup

    cg_mux cg = new();
    Transaction tr = new();

    // Test process
    initial begin
        // Waveform dump
        $dumpfile("mux_wave.vcd");
        $dumpvars(0, tb);

        repeat (20) begin
            // Random stimulus
            tr.randomize();
            a   = tr.a;
            b   = tr.b;
            sel = tr.sel;

            #5;

            // Sample coverage
            cg.sample();

            // Self-check
            if (y !== (sel ? b : a)) begin
                $error("Mismatch! a=%0h b=%0h sel=%0b y=%0h",
                        a, b, sel, y);
            end
        end

        // Coverage report
        $display("Coverage = %0.2f %%", cg.get_inst_coverage());

        $finish;
    end
endmodule
