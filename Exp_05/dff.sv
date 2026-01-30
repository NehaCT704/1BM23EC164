// ----------------------------------------------------------------------------------
// File        : dff.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : dff
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : D flip Flop designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module dff (
    input  logic clk,
    input  logic rst,
    input  logic d,
    output logic q
);
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
