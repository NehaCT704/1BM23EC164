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
