// ----------------------------------------------------------------------------------
// File        : Dual_Port_RAM.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : dual_port_ram
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Dual Port RAM designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module dual_port_ram #(
  parameter ADDR_WIDTH = 8,
  parameter DATA_WIDTH = 8
)(
  input  logic                     clk,

  // Port A : Write
  input  logic                     we_a,
  input  logic [ADDR_WIDTH-1:0]    addr_a,
  input  logic [DATA_WIDTH-1:0]    wdata_a,

  // Port B : Read
  input  logic [ADDR_WIDTH-1:0]    addr_b,
  output logic [DATA_WIDTH-1:0]    rdata_b
);

  logic [DATA_WIDTH-1:0] mem [0:(1<<ADDR_WIDTH)-1];

  // Write port
  always_ff @(posedge clk) begin
    if (we_a)
      mem[addr_a] <= wdata_a;
  end

  // Read port
  always_ff @(posedge clk) begin
    rdata_b <= mem[addr_b];
  end

endmodule
