// ----------------------------------------------------------------------------------
// File        : tb_counter.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : tb_counter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Counter. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_counter;

    logic clk = 0;
    logic rst;
    logic [3:0] count;

    counter dut (.*);

    always #5 clk = ~clk;

    covergroup cg_count @(posedge clk);
        cp_val : coverpoint count {
            bins zero = {0};
            bins max  = {15};
            bins roll = (15 => 0);
        }
    endgroup

    cg_count cg = new();

    initial begin
        $dumpfile("counter.vcd");
        $dumpvars(0, tb);

        rst = 1;
        #20 rst = 0;

        repeat (40) @(posedge clk);

        $display("Counter Coverage : %0.2f %%", cg.get_inst_coverage());

        $finish;
    end

endmodule
