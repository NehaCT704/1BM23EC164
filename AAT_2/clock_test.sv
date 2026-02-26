// ----------------------------------------------------------------------------------
// File        : clock_test.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-26
// Module      : clock_test
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Digital Clock test designed to verify functional coverage and to  
//               assign assertion.
// ----------------------------------------------------------------------------------
program clock_test(clock_if.TB intf);

// FUNCTIONAL COVERAGE (sample only when reset inactive)
covergroup cg @(posedge intf.clk iff !intf.reset);

    option.per_instance = 1;

    // VALUE COVERAGE
    sec_val : coverpoint intf.seconds {
        bins values[] = {[0:59]};
    }

    min_val : coverpoint intf.minutes {
        bins values[] = {[0:59]};
    }

    // TRANSITION COVERAGE
    sec_roll : coverpoint intf.seconds {
        bins rollover = (59 => 0);
    }

    min_roll : coverpoint intf.minutes {
        bins rollover = (59 => 0);
    }

    // CROSS COVERAGE
    cross sec_val, min_val;

endgroup
cg cov;

// ASSERTIONS
assert property (@(posedge intf.clk)
                 disable iff (intf.reset)
                 intf.seconds <= 59);

assert property (@(posedge intf.clk)
                 disable iff (intf.reset)
                 intf.minutes <= 59);

// STIMULUS 

initial begin

    // create coverage object
    cov = new();

    // run multiple reset cycles to improve code coverage
    repeat (5) begin

        // apply reset
        intf.reset = 1;
        repeat(5) @(posedge intf.clk);

        // release reset
        intf.reset = 0;
        repeat(5) @(posedge intf.clk);

        // run one full clock cycle (60 × 60 states)
        repeat (3600) @(posedge intf.clk);
    end
    $display("Coverage completed");
    $finish;
end
endprogram
