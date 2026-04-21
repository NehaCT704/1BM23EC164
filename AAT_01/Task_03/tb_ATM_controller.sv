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
    logic clk, rst;
    logic card_inserted, pin_correct, balance_ok;
    logic dispense_cash;

    atm_fsm dut (
        .clk(clk), .rst(rst),
        .card_inserted(card_inserted),
        .pin_correct(pin_correct),
        .balance_ok(balance_ok),
        .dispense_cash(dispense_cash)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    covergroup atm_cg @(posedge clk);
        cp_card    : coverpoint card_inserted;
        cp_pin     : coverpoint pin_correct;
        cp_bal     : coverpoint balance_ok;
        cp_dispense: coverpoint dispense_cash;
        cx_inputs  : cross cp_card, cp_pin, cp_bal;
    endgroup

    atm_cg cg_inst = new();

    task run_txn(input logic card, pin, bal, input string label);
        @(negedge clk);
        card_inserted = card;
        pin_correct   = pin;
        balance_ok    = bal;
        repeat(4) @(posedge clk);
        $display("[%0t] %s | dispense_cash=%b", $time, label, dispense_cash);
        card_inserted = 0; pin_correct = 0; balance_ok = 0;
        @(posedge clk);
    endtask

    initial begin
        $dumpfile("atm_fsm.vcd");
        $dumpvars(0, atm_fsm_tb);

        rst = 1; card_inserted = 0; pin_correct = 0; balance_ok = 0;
        #12 rst = 0;

        // Happy path
        run_txn(1, 1, 1, "HAPPY PATH");
        // Wrong PIN
        run_txn(1, 0, 1, "NEG: wrong PIN");
        // No card
        run_txn(0, 1, 1, "NEG: no card");
        // Insufficient balance
        run_txn(1, 1, 0, "NEG: no balance");
        // All zero
        run_txn(0, 0, 0, "NEG: all zero");
        // Wrong pin, no balance
        run_txn(1, 0, 0, "NEG: wrong pin no bal");
        // No card, no pin
        run_txn(0, 0, 1, "NEG: no card no pin");
        // No card, no balance
        run_txn(0, 1, 0, "NEG: no card no bal");

        // Reset mid-transaction
        @(negedge clk);
        card_inserted = 1; pin_correct = 1; balance_ok = 1;
        @(posedge clk);
        rst = 1;
        @(posedge clk);
        rst = 0;
        card_inserted = 0; pin_correct = 0; balance_ok = 0;
        repeat(2) @(posedge clk);
        $display("[%0t] RESET MID-TXN: dispense=%b", $time, dispense_cash);

        // Post-reset happy path
        run_txn(1, 1, 1, "POST-RESET happy path");

        $display("\n=== Functional Coverage: %0.2f%% ===", cg_inst.get_coverage());
        $display("cp_card    : %0.2f%%", cg_inst.cp_card.get_coverage());
        $display("cp_pin     : %0.2f%%", cg_inst.cp_pin.get_coverage());
        $display("cp_bal     : %0.2f%%", cg_inst.cp_bal.get_coverage());
        $display("cp_dispense: %0.2f%%", cg_inst.cp_dispense.get_coverage());
        $display("cx_inputs  : %0.2f%%", cg_inst.cx_inputs.get_coverage());

        $finish;
    end
endmodule
