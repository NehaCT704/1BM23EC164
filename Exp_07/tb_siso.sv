// ----------------------------------------------------------------------------------
// File        : tb_siso.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-30
// Module      : tb_siso
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Shift Register. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ----------------------------------------------------------------------------------
module tb_siso;

    logic clk = 0;
    logic rst;
    logic si;
    logic so;

    siso dut (.*);

    always #5 clk = ~clk;

    // Reference model
    logic [3:0] q_ref = 4'd0;

    // ---------------- COVERAGE ----------------
    covergroup cg_siso @(posedge clk);
        cp_si : coverpoint si {
            bins zero = {0};
            bins one  = {1};
        }

        cp_so : coverpoint so {
            bins zero = {0};
            bins one  = {1};
        }

        cross_si_so : cross cp_si, cp_so;
    endgroup

    cg_siso cg = new();
    // ------------------------------------------

    initial begin
        $dumpfile("siso.vcd");
        $dumpvars(0, tb);

        // Reset
        rst = 1;
        si  = 0;
        #12;
        rst = 0;

        repeat (20) begin
            si = $urandom_range(0,1);
            @(posedge clk);
            #1;

            q_ref = {q_ref[2:0], si};

            if (so !== q_ref[3])
                $error("Mismatch! Expected so=%0b, Got so=%0b", q_ref[3], so);
        end

        $display("SISO Coverage = %0.2f %%", cg.get_inst_coverage());
        $finish;
    end

endmodule
