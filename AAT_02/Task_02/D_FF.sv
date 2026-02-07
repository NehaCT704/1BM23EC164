// ----------------------------------------------------------------------------------
// File        : D_FF.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-07
// Module      : D_FF
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : D Flip FLop designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module D_FF(D_inter.RTL1 rtl1);
always@(posedge rtl1.clk, posedge rtl1.reset)
begin
if(rtl1.reset)
rtl1.q<=0;
else if(rtl1.set)
rtl1.q<=1;
else
rtl1.q<=rtl1.d;
end
endmodule
