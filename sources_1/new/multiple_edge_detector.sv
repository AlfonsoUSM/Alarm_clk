`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.04.2020 13:18:36
// Design Name: 
// Module Name: continuous_edge_detecter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/* ///////////// Instance template //////////////////

    multiple_edge_detector instance_name (
        .clk(),         // 1 bit Input: clock signal
        .reset(),       // 1 bit Input: CPU reset signal
        .in_signal(),   // 1 bit Input: input signal
        .out_signal()   // 1 bit Output: output pulses
    );

*/ /////////////////////////////////////////////////

// Latenci: 1 clock cicle

module multiple_edge_detector (
    input   clk,
    input   reset,
    input   in_signal,
    output  out_signal
    );
    
    localparam N = 100000000;
        
    logic FF1;
    
    always_ff @ (posedge clk) begin     // input regs
        if (reset == 1'b1) begin
            FF1 <= 1'b0;
        end
        else begin
            FF1 <= in_signal;
        end
    end
    
    logic out, next_out;
    assign out_signal = out;
    
    always_ff @ (posedge clk) begin     // output reg
        if (reset == 1'b1) begin
            out <= 0;
        end
        else begin
            out <= next_out;
        end
    end
    
    logic [1:0] increment, next_increment;
    logic [26:0] counter, next_count;
    
    always_ff @ (posedge clk) begin     // counter reg
        if (reset == 1'b1) begin
            counter <= 27'd0; 
            increment <= 2'd1;
        end
        else begin
            counter <= next_count;
            increment <= next_increment;
        end
    end
    
    enum logic {IDLE, COUNT} state, next_state;
    
    always_ff @ (posedge clk) begin     // state reg
        if (reset == 1'b1) begin
            state <= IDLE;
        end
        else begin
            state <= next_state;
        end
    end
    
    always_comb begin       // change of state logic
        next_state = state;  //default
        case (state)
            IDLE: begin
                if (FF1 == 1'b1)
                    next_state = COUNT;
            end
            COUNT: begin
                if (FF1 == 1'b0)
                    next_state = IDLE;
            end
            default: begin
            end
        endcase
    end
    
    always_comb begin       // change of output logic
        next_out = 1'b0;    // default
        next_increment = increment;
        case (state)
            IDLE: begin
                next_increment = 2'd1;
                next_count = 27'd0;
                if (FF1 == 1'b1) begin
                    next_out = 1'b1;
                end
            end
            COUNT: begin
                if (counter == (27'd100_000_000 - increment)) begin
                    next_count = 27'd0;
                    next_out = 1'b1;
                    next_increment = 2'd2;
                end
                else begin
                    next_count = counter[26:0] + increment[1:0];
                end
            end
            default: begin
            end
        endcase
    end
        
endmodule
