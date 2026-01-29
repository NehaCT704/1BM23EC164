// ---------------------------------------------------------------------------------
// File        : tb_and_gate.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : tb_and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for and_gate.Randomizes inputs and uses a 
//               covergroup to measureinput combination coverage.
// ---------------------------------------------------------------------------------
module tb_and_gate;
logic a,b,y;
andgate dut(.*); // Connect by name

// Covergroup defines what we want to measure
covergroup cg_and;
  cp_a : coverpoint a;
  cp_b : coverpoint b;
  cross_ab : cross cp_a,cp_b;
endgroup

cg_and cg = new();

initial begin
  $dumpfile("andgate.vcd");   // dump file
  $dumpvars(0, tb);           // dump all vars under tb

  repeat(20) begin
    a = $urandom();
    b = $urandom();
    #5;
    cg.sample();
  end
  $display("Final Coverage = %0.2f %%", cg.get_inst_coverage());
end
endmodule
