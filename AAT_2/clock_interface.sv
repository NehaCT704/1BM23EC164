// ----------------------------------------------------------------------------------
// File        : clock_interface.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-26
// Module      : clock_if
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Digital Clock interface designed to connect design and tb.
// ----------------------------------------------------------------------------------
interface clock_if;
    logic clk;
    logic reset;
    logic [5:0] seconds;
    logic [5:0] minutes;

    modport DUT (
        input clk, reset,
        output seconds, minutes
    );

    modport TB (
        output clk, reset,
        input seconds, minutes
    );

endinterface
