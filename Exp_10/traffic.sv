// ----------------------------------------------------------------------------------
// File        : traffic.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : traffic
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Traffic Light Controller designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
typedef enum logic [1:0] {RED, GREEN, YELLOW} light_t;

// ---------------- DESIGN ----------------
module traffic (
  input  logic  clk,
  input  logic  rst,
  output light_t color
);

  always_ff @(posedge clk) begin
    if (rst)
      color <= RED;
    else begin
      case (color)
        RED:    color <= GREEN;
        GREEN:  color <= YELLOW;
        YELLOW: color <= RED;
      endcase
    end
  end

endmodule
