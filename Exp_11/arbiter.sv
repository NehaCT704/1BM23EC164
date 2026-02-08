// ----------------------------------------------------------------------------------
// File        : arbiter.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-08
// Module      : arbiter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Arbiter designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module arbiter (
    input  logic        clk,
    input  logic        rst,
    input  logic [3:0]  req,
    output logic [3:0]  gnt
);

    always_ff @(posedge clk) begin
        if (rst)
            gnt <= 4'b0000;
        else if (req[0])
            gnt <= 4'b0001;
        else if (req[1])
            gnt <= 4'b0010;
        else if (req[2])
            gnt <= 4'b0100;
        else if (req[3])
            gnt <= 4'b1000;
        else
            gnt <= 4'b0000;
    end

endmodule

