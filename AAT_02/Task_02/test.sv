// ----------------------------------------------------------------------------------
// File        : test.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-07
// Module      : tb_mux2to1
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for D Flip Flop. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module test(D_inter.test1 t1);
initial
begin
t1.reset=0;t1.set=0;
t1.d=0;
#10
t1.reset=1;t1.set=1;
t1.d=0;
#10
t1.reset=0;
t1.d=0;
#10
t1.d=1;t1.set=0;
#10
t1.d=0;
#10
t1.d=1;
#10
t1.d=0;
#100
$finish;
end 
endmodule
