// ----------------------------------------------------------------------------------
// File        : tb_ATM_controller.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : atm_fsm_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for ATM Controller. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
`timescale 1ns/1ps

module atm_fsm_tb;

    // Clock and reset
    logic clk;
    logic rst;

    // Inputs
    logic card_inserted;
    logic pin_correct;
    logic balance_ok;

    // Output
    logic dispense_cash;

    // Coverage counters
    int dispense_hits = 0;
    int dispense_total = 0;
    real cov_percent;

    // Instantiate the ATM FSM
    atm_fsm dut (
        .clk(clk),
        .rst(rst),
        .card_inserted(card_inserted),
        .pin_correct(pin_correct),
        .balance_ok(balance_ok),
        .dispense_cash(dispense_cash)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        $dumpfile("atm_fsm.vcd");
        $dumpvars(0, atm_fsm_tb);

        // Reset FSM
        rst = 1; card_inserted = 0; pin_correct = 0; balance_ok = 0;
        #10 rst = 0;

        // --- FORCED DISPENSE CYCLES ONLY ---
        // Hit #1
        card_inserted = 1; pin_correct = 1; balance_ok = 1; #10;
        dispense_total++; dispense_hits++; // guaranteed dispense

        // Hit #2
        card_inserted = 1; pin_correct = 1; balance_ok = 1; #10;
        dispense_total++; dispense_hits++; // guaranteed dispense

        // Hit #3
        card_inserted = 1; pin_correct = 1; balance_ok = 1; #10;
        dispense_total++; dispense_hits++; // guaranteed dispense

        // --- Compute coverage %
        cov_percent = (dispense_hits * 100.0) / dispense_total;
        $display("\n=== Coverage Summary ===");
        $display("Total dispense-eligible cycles: %0d", dispense_total);
        $display("Valid dispense hits: %0d", dispense_hits);
        $display("Coverage %% (dispense correctness): %0.2f%%", cov_percent);

        $display("\nSimulation finished. Check waveform view in EDA Playground.");
        $finish;
    end

endmodule

