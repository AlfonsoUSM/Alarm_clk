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
endmodule
