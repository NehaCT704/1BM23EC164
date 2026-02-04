// ----------------------------------------------------------------------------------
// File        : tb_fifo.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : tb_fifo
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for FIFO. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
interface fifo_if (input clk);
  logic        wr;
  logic        rd;
  logic        full;
  logic        empty;
  logic [7:0]  din;
endinterface



module tb_fifo;

  // Clock
  bit clk = 0;
  always #5 clk = ~clk;

  // Interface instance
  fifo_if vif (clk);

  // DUT instance
  fifo dut (
    .clk   (clk),
    .wr    (vif.wr),
    .rd    (vif.rd),
    .din   (vif.din),
    .full  (vif.full),
    .empty (vif.empty)
  );

  // Coverage group
  covergroup cg_fifo @(posedge clk);
    wr_full_cross : cross vif.wr, vif.full;
  endgroup

  cg_fifo cg = new();

  // ---------------- WAVEFORM DUMP ----------------
  initial begin
    $dumpfile("tb_fifo.vcd");
    $dumpvars(0, tb_fifo);
    $dumpvars(0, tb_fifo.vif);   // dump interface signals
  end

  // ---------------- TEST STIMULUS ----------------
  initial begin
    // Initialization
    vif.wr  = 0;
    vif.rd  = 0;
    vif.din = 8'h00;

    // Idle state (wr=0, full=0)
    repeat (5) @(posedge clk);

    // Fill FIFO
    vif.wr = 1;
    repeat (18) @(posedge clk);

    // Idle while FULL
    vif.wr = 0;
    repeat (5) @(posedge clk);

    // Coverage result
    $display("Coverage : %0.2f%%", cg.get_inst_coverage());

    $finish;
  end

endmodule

