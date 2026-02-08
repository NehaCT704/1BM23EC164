// ----------------------------------------------------------------------------------
// File        : tb_arbiter.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-08
// Module      : tb_arbiter
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Arbiter. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_arbiter;

    logic clk;
    logic rst;
    logic [3:0] req;
    logic [3:0] gnt;

    // DUT
    arbiter dut (
        .clk(clk),
        .rst(rst),
        .req(req),
        .gnt(gnt)
    );

    // Clock
    always #5 clk = ~clk;

    // COVERAGE
    covergroup arbiter_cg @(posedge clk);
        coverpoint req {
            bins r0 = {4'b0001};
            bins r1 = {4'b0010};
            bins r2 = {4'b0100};
            bins r3 = {4'b1000};
            bins multi = {[4'b0011:4'b1111]};
        }

        coverpoint gnt {
            bins g0 = {4'b0001};
            bins g1 = {4'b0010};
            bins g2 = {4'b0100};
            bins g3 = {4'b1000};
            bins idle = {4'b0000};
        }
    endgroup

    arbiter_cg cg;

    // Stimulus
    initial begin
        clk = 0;
        rst = 1;
        req = 0;
        cg = new();

        #10 rst = 0;

        #10 req = 4'b0001;
        #10 req = 4'b0010;
        #10 req = 4'b0100;
        #10 req = 4'b1000;
        #10 req = 4'b1010;
        #10 req = 4'b0000;

        #20;
        $display("\n==============================");
        $display(" FUNCTIONAL COVERAGE REPORT ");
        $display("==============================");
        $display("Coverage = %0.2f %%", cg.get_coverage());
        $display("==============================\n");

        $finish;
    end

    // Assertion
    assert property (@(posedge clk) $onehot0(gnt))
        else $error("Protocol Violation: Multiple Grants!");

    // Dump
    initial begin
        $dumpfile("arbiter.vcd");
        $dumpvars(0, tb_arbiter);
    end

endmodule
