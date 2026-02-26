// ----------------------------------------------------------------------------------
// File        : Digital_Clock.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-26
// Module      : digital_clock
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Digital Clock designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module digital_clock (
    input  logic clk,
    input  logic reset,           // synchronous active-high reset
    output logic [5:0] seconds,
    output logic [5:0] minutes
);

always_ff @(posedge clk) begin
    if (reset) begin
        seconds <= 0;
        minutes <= 0;
    end
    else begin
        if (seconds == 6'd59) begin
            seconds <= 0;
            if (minutes == 6'd59)
                minutes <= 0;
            else
                minutes <= minutes + 1;
        end
        else begin
            seconds <= seconds + 1;
        end
    end
end
endmodule
