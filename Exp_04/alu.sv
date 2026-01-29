// ----------------------------------------------------------------------------------
// File        : alu.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Arithmetic Logic Unit designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
typedef enum bit [1:0] {ADD, SUB, AND, OR} opcode_e;

module alu (
    input  logic [7:0] a, b,
    input  opcode_e    op,
    output logic [7:0] y
);
    always_comb
        case (op)
            ADD: y = a + b;
            SUB: y = a - b;
            AND: y = a & b;
            OR : y = a | b;
        endcase
endmodule

