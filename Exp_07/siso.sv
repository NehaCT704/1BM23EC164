// ----------------------------------------------------------------------------------
// File        : siso.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : siso
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Shift Register designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module siso (
    input  logic clk,
    input  logic rst,
    input  logic si,
    output logic so
);

    logic [3:0] q;

    assign so = q[3];

    always_ff @(posedge clk) begin
        if (rst)
            q <= 4'd0;
        else
            q <= {q[2:0], si};
    end

endmodule
