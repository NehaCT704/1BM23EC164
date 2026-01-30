// ----------------------------------------------------------------------------------
// File        : fifo.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : fifo
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : FIFO designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module fifo (
    input  logic        clk,
    input  logic        wr,
    input  logic        rd,
    input  logic [7:0]  din,
    output logic        full,
    output logic        empty
);

    logic [7:0] mem [15:0];   // storage (not functionally used yet)
    logic [4:0] cnt = 0;      // can count up to 16

    assign full  = (cnt == 5'd16);
    assign empty = (cnt == 5'd0);

    always_ff @(posedge clk) begin
        if (wr && !full)
            cnt <= cnt + 1'b1;
        if (rd && !empty)
            cnt <= cnt - 1'b1;
    end

endmodule
