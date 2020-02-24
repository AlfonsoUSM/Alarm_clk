`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: led_alarm
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

////////    Instance template   /////////////
/* 
    led_alarm instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .alarm(),           // 1 bit INPUT : alarm trigger
        .led0_mux(),        // 1 bit OUTPUT : LED 0 multiplexer control
        .leds()             // 8 bits OUTPUT : LEDs (alarm)
    );
*/
////////////////////////////////////////////

module led_alarm(
    input clk,               // clock
    input reset,             // reset
    input alarm,             // alarm trigger
    output led0_mux,         // LED 0 multiplexer control
    output [7:0] leds        // LEDs (alarm)
    );
    
    logic state, next_state;
    logic[5:0] counter;
    logic[7:0] out, shift;
    logic div_clk;
    
    assign leds[7:0] = out;
    assign led0_mux = state;
    
    always_ff @ (posedge clk) begin
        if (reset == 1'b1)
            state <= 1'b0;
        else
            state <= next_state;    
    end
    
    always_ff @ (posedge div_clk) begin
        if (state == 1'b0) begin
            shift[7:0] <= 8'b00000001;
            counter[5:0] <= 6'b0;
        end
        else
            shift[7:0] <= {shift[6:0], shift[7]};
            counter[5:0] <= counter[5:0] + 6'd1;
    end
    
    always_comb begin
        if (alarm == 1'b1)
            next_state = 1'b1;
        else begin
            if (counter == 6'd63)
                next_state = 1'b0;
            else
                next_state = state;
        end   
        if (state == 1'b1)
            out[7:0] = shift[7:0];
        else
            out[7:0] = 8'b0;
    end
    
    clock_divider #(.d (10000000)) instance_name(
        .clk_in(clk),
        .reset(reset),
        .clk_out(div_clk)
    );
        
endmodule
