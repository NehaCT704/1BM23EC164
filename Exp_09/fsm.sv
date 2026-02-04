// ----------------------------------------------------------------------------------
// File        : fsm.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : fsm
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : FSM designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module fsm101 (
  input  logic clk,
  input  logic rst,
  input  logic in,
  output logic out
);

  typedef enum logic [1:0] {S0, S1, S2} state_t;
  state_t state, next;

  // State register
  always_ff @(posedge clk) begin
    if (rst)
      state <= S0;
    else
      state <= next;
  end

  // Next-state logic (example)
  always_comb begin
    next = state;
    out  = 0;

    case (state)
      S0: if (in) next = S1;
      S1: if (in) next = S2;
      S2: begin
            out = 1;
            if (!in) next = S0;
          end
    endcase
  end

endmodule
