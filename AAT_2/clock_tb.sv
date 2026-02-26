// ----------------------------------------------------------------------------------
// File        : Clock_tb.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-26
// Module      : clock_tb
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Digital Clock tb designed to generate clock and display the 
//               waveform
//               
// ----------------------------------------------------------------------------------
module clock_tb;
clock_if intf();

// DUT instantiation
digital_clock dut (
    .clk(intf.clk),
    .reset(intf.reset),
    .seconds(intf.seconds),
    .minutes(intf.minutes)
);

// clock generation (10 time unit period)
initial begin
    intf.clk = 0;
    forever #5 intf.clk = ~intf.clk;
end
initial begin
    $dumpfile("clock_wave.vcd");   // name of VCD file
    $dumpvars(0, clock_tb);        // dump all signals in testbench hierarchy
end

// connect program block
clock_test test(intf);

endmodule
