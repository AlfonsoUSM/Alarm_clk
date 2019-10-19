`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 15.10.2019 19:51:38
// Design Name: 
// Module Name: display
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
    display instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mod12_24(),        // 1 bit INPUT : display mode, 12h AM/PM or 24h
        .alarm(),           // 1 bit INPUT : alarm trigger
        .disp_time(),       // 17 bits INPUT : diplayed time
        .seg7s(),           // 16 bits OUTPUT : 7 SEGMENTS 
        .leds()             // 8 bits OUTPUT : LEDS
    );
*/
////////////////////////////////////////////

module display(
    input clk,              // clock
    input reset,            // reset
    input mod12_24,         // display mode, 12h AM/PM or 24h
    input alarm,            // alarm trigger
    input [16:0] disp_time, // diplayed time
    output [15:0] seg7s,    // 7 SEGMENTS
    output [7:0] leds       // LEDS
    );
    
    mode12_24 instance_mode12_24 (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mod12_24(),        // 1 bit INPUT : 12h AM/PM or 24h mode
        .in_disp_time(),    // 17 bits INPUT : time to display in 24h format
        .led0(),            // 1 bit OUTPUT : led0 (AM/PM)
        .out_disp_time()    // 17 bits OUTPUT : time to display in setted format
    );
    
     display_ctrl instance_disp_ctrl (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .disp_time(),       // 17 bits INPUT : time to be displayed
        .deg7s              // 16 bits OUTPUT : 7 SEGMENTS
    );   
    
    led_alarm instance_leds (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .alarm(),           // 1 bit INPUT : alarm trigger
        .led0_mux(),        // 1 bit OUTPUT : led0 multiplexer control
        .leds()             // 8 bits OUTPUT : leds (alarm)
    );        
    
endmodule
