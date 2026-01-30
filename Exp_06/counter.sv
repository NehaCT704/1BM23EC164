// ----------------------------------------------------------------------------------
// File        : counter.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Counter designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module counter (
    input  logic       clk,
    input  logic       rst,
    output logic [3:0] count
);

    always_ff @(posedge clk) begin
        if (rst)
            count <= 4'd0;
        else
            count <= count + 1'b1;
    end

endmodule
