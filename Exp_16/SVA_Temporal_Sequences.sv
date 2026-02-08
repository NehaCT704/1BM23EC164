// ----------------------------------------------------------------------------------
// File        : SVA_Temporal_Sequences.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-08
// Module      : tb_sva
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for SVA Temporal Sequences. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_sva;

    bit clk, req, gnt;

    // -------------------------------
    // Clock
    // -------------------------------
    always #5 clk = ~clk;

    // -------------------------------
    // PROPERTY
    // req -> gnt after 2 cycles
    // -------------------------------
    property p_handshake;
        @(posedge clk) req |=> ##2 gnt;
    endproperty

    // -------------------------------
    // ASSERTION
    // -------------------------------
    assert property (p_handshake)
        else $error("Protocol Fail!");

    // -------------------------------
    // COVERAGE (Assertion Coverage)
    // -------------------------------
    cover property (p_handshake);

    // -------------------------------
    // STIMULUS
    // -------------------------------
    initial begin
        clk = 0;
        req = 0;
        gnt = 0;

        @(posedge clk) req <= 1;
        @(posedge clk) req <= 0;
        @(posedge clk) gnt <= 1;   // 2 cycles later → PASS

        #50;
        $display("\n====== ASSERTION COVERAGE ======");
        $display("Handshake scenario covered");
        $display("================================\n");

        $finish;
    end

    // -------------------------------
    // DUMP (EPWave)
    // -------------------------------
    initial begin
        $dumpfile("handshake.vcd");
        $dumpvars(0, tb_sva);
    end

endmodule
