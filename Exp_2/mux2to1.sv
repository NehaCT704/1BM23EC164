// ----------------------------------------------------------------------------------
// File        : mux2to1.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : mux2to1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : 2:1 multiplexer designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------

module mux2to1 (
    input  logic [7:0] a, b,
    input  logic       sel,
    output logic [7:0] y
);
    assign y = sel ? b : a;
endmodule
