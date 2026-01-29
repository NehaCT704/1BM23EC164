// ----------------------------------------------------------------------------------
// File        : and_gate.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : and_gate
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : 2-input AND gate used for basic functional coverage example.
// ----------------------------------------------------------------------------------
module andgate(input logic a,b,output logic y);
	assign y=a&b;
endmodule
