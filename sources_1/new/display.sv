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
    
    logic led0_mux;
    logic out_led0, led_AM_PM;
    logic [7:0] alarm_leds;
    
    assign leds[7:0] = { alarm_leds[7:1], out_led0 };
    
    always_comb begin
        if ( led0_mux == 1'b1 )
            out_led0 = alarm_leds[0];
        else
            out_led0 = led_AM_PM;  
    end
    
    mode12_24 mode12_24_instance (
        .clk(clk),                      // 1 bit INPUT : clock
        .reset(reset),                  // 1 bit INPUT : reset
        .mod12_24(mod12_24),            // 1 bit INPUT : 12h AM/PM or 24h mode
        .in_disp_time(disp_time),       // 17 bits INPUT : time to display in 24h format
        .led0(led_AM_PM),               // 1 bit OUTPUT : led0 (AM/PM)
        .out_disp_time(out_disp_time)   // 17 bits OUTPUT : time to display in setted format
    );
    
     display_ctrl disp_ctrl_instance (
        .clk(clk),                      // 1 bit INPUT : clock
        .reset(reset),                  // 1 bit INPUT : reset
        .disp_time(out_disp_time),      // 17 bits INPUT : time to be displayed
        .seg7s(seg7s)                   // 16 bits OUTPUT : 7 SEGMENTS
    );   
    
    led_alarm leds_instance (
        .clk(clk),                      // 1 bit INPUT : clock
        .reset(reset),                  // 1 bit INPUT : reset
        .alarm(alarm),                  // 1 bit INPUT : alarm trigger
        .led0_mux(led0_mux),            // 1 bit OUTPUT : led0 multiplexer control
        .leds(alarm_leds)               // 8 bits OUTPUT : leds (alarm)
    );        
    
endmodule
