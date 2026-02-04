// ----------------------------------------------------------------------------------
// File        : tb_fsm.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : tb_fsm
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for FSM. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_fsm;

  bit clk = 0;
  always #5 clk = ~clk;

  logic rst, in;
  logic out;

  // DUT
  fsm101 dut (
    .clk (clk),
    .rst (rst),
    .in  (in),
    .out (out)
  );

  // Coverage group (WHITE-BOX)
  covergroup cg_fsm @(posedge clk);
    cp_state : coverpoint dut.state;
  endgroup

  cg_fsm cg = new();

  // ---------------- WAVEFORM DUMP ----------------
  initial begin
    $dumpfile("fsm_tb.vcd");
    $dumpvars(0, tb_fsm);
    $dumpvars(0, tb_fsm.dut);   // dump internal state
  end

  // ---------------- STIMULUS ----------------
  initial begin
    rst = 1;
    in  = 0;
    repeat (2) @(posedge clk);

    rst = 0;

    // Drive FSM through all states
    in = 1; @(posedge clk);  // S0 → S1
    in = 1; @(posedge clk);  // S1 → S2
    in = 0; @(posedge clk);  // S2 → S0

    // Coverage result
    $display("FSM State Coverage = %0.2f%%",
             cg.get_inst_coverage());

    $finish;
  end

endmodule
