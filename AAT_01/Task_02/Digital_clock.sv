// ----------------------------------------------------------------------------------
// File        : Digital_clock.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : time_counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Digital clock designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module time_counter (
  input  logic clk,
  input  logic rst,
  output logic [5:0] sec,
  output logic [5:0] min
);

  always_ff @(posedge clk) begin
    if (rst) begin
      sec <= 0;
      min <= 0;
    end
    else begin
      if (sec == 59) begin
        sec <= 0;
        if (min == 59)
          min <= 0;
        else
          min <= min + 1;
      end
      else begin
        sec <= sec + 1;
      end
    end
  end

endmodule
