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
