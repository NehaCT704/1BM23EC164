// ------------------------------------------------------------------------------------------
// File        : tb_alu.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-01-29
// Module      : tb_alu
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : Simple testbench for Arithmetic Logic unit. Randomizes inputs and uses a 
//               covergroup to measure input combination coverage..
// ------------------------------------------------------------------------------------------
module tb_alu;
    logic [7:0] a, b, y;
    opcode_e op;

    alu dut(.*);

    covergroup cg_alu;
        cp_op : coverpoint op;
    endgroup

    cg_alu cg = new();

    initial begin
        $dumpfile("alu.vcd");   // waveform file
        $dumpvars(0, tb);       // dump tb + dut signals

        repeat (50) begin
            a  = $urandom();
            b  = $urandom();
            op = opcode_e'($urandom_range(0,3));
            #5;
            cg.sample();
        end
        $display("Coverage : %0.2f %%", cg.get_inst_coverage());
    end
endmodule
