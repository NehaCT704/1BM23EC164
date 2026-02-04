// ----------------------------------------------------------------------------------
// File        : tb_ram.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : tb_ram
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Dual port SRAM. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
`timescale 1ns/1ps

module tb_ram;

  // --------------------------------
  // Parameters
  // --------------------------------
  parameter ADDR_WIDTH = 8;
  parameter DATA_WIDTH = 8;

  // --------------------------------
  // DUT signals
  // --------------------------------
  logic clk;
  logic we_a;
  logic [ADDR_WIDTH-1:0] addr_a;
  logic [DATA_WIDTH-1:0] wdata_a;
  logic [ADDR_WIDTH-1:0] addr_b;
  logic [DATA_WIDTH-1:0] rdata_b;

  // --------------------------------
  // DUT
  // --------------------------------
  dual_port_ram dut (
    .clk     (clk),
    .we_a    (we_a),
    .addr_a  (addr_a),
    .wdata_a (wdata_a),
    .addr_b  (addr_b),
    .rdata_b (rdata_b)
  );

  // --------------------------------
  // Clock
  // --------------------------------
  always #5 clk = ~clk;

  // --------------------------------
  // Reference model
  // --------------------------------
  bit [DATA_WIDTH-1:0] ref_mem [int];

  // --------------------------------
  // Coverage
  // --------------------------------
  covergroup ram_cg;
    coverpoint addr_a { bins addr[] = {[0:255]}; }
    coverpoint we_a   { bins READ = {0}; bins WRITE = {1}; }
    cross addr_a, we_a;
  endgroup

  ram_cg cg;

  // --------------------------------
  // Test
  // --------------------------------
  initial begin

    // Waveform dump
    $dumpfile("ram_tb.vcd");
    $dumpvars(0, tb_ram);

    clk = 0;
    we_a = 0;
    addr_a = 0;
    addr_b = 0;
    wdata_a = 0;

    cg = new();

    // ----------------------------
    // WRITE all addresses
    // ----------------------------
    for (int i = 0; i < 256; i++) begin
      addr_a  = i;
      wdata_a = $urandom_range(0,255);
      we_a    = 1;

      cg.sample();
      @(posedge clk);
      we_a = 0;

      ref_mem[i] = wdata_a;
    end

    // ----------------------------
    // READ all addresses
    // ----------------------------
    for (int i = 0; i < 256; i++) begin
      addr_a = i;      // ensures READ coverage
      addr_b = i;
      we_a   = 0;

      cg.sample();
      @(posedge clk);

      if (rdata_b === ref_mem[i])
        $display("PASS : Addr=%0d Data=%0h", i, rdata_b);
      else
        $display("FAIL : Addr=%0d Exp=%0h Got=%0h",
                 i, ref_mem[i], rdata_b);
    end

    // ----------------------------
    // Coverage result
    // ----------------------------
    $display("\n==============================");
    $display("Functional Coverage = %0.2f %%", cg.get_coverage());
    $display("==============================\n");

    $finish;
  end

endmodule
