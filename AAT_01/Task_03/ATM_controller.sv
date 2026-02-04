// ----------------------------------------------------------------------------------
// File        : ATM_controller.sv
// Author      : Neha C T / 1BM23EC164
// Created     : 2026-02-04
// Module      : atm_fsm
// Project     : SystemVerilog and Verification (23EC6PE2SV),
//               Faculty: Prof. Ajaykumar Devarapalli
//
// Description : ATM Controller designed demonstrate basic 
//               functional coverage.
// ----------------------------------------------------------------------------------
module atm_fsm (
    input  logic clk,
    input  logic rst,
    input  logic card_inserted,
    input  logic pin_correct,
    input  logic balance_ok,
    output logic dispense_cash
);

    // Define states
    typedef enum logic [1:0] {
        IDLE       = 2'b00,
        CHECK_PIN  = 2'b01,
        CHECK_BAL  = 2'b10,
        DISPENSE   = 2'b11
    } state_t;

    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        // Default values
        next_state     = state;
        dispense_cash  = 0;

        case (state)
            IDLE: begin
                if (card_inserted)
                    next_state = CHECK_PIN;
            end

            CHECK_PIN: begin
                if (pin_correct)
                    next_state = CHECK_BAL;
                else
                    next_state = IDLE; // wrong PIN returns to IDLE
            end

            CHECK_BAL: begin
                if (balance_ok)
                    next_state = DISPENSE;
                else
                    next_state = IDLE; // insufficient balance returns to IDLE
            end

            DISPENSE: begin
                dispense_cash = 1;
                next_state = IDLE; // After dispensing, return to IDLE
            end
        endcase
    end

    // --- Assertions ---
    // 1. Cash is dispensed ONLY if pin_correct AND balance_ok
    //    (i.e., if dispense_cash is high, pin_correct and balance_ok must have been high)
    assert_dispense_condition: assert property (
        @(posedge clk)
        (dispense_cash) |-> (pin_correct && balance_ok)
    );

    // 2. Machine returns to IDLE after dispensing
    assert_return_idle: assert property (
        @(posedge clk)
        (state == DISPENSE) |=> (next_state == IDLE)
    );

endmodule
