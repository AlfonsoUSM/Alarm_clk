`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes 
// 
// Create Date: 15.10.2019 19:51:38
// Design Name: 
// Module Name: reloj
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
    reloj instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mode(),            // 1 bit INPUT : alarm or clock modes
        .edit_btns(),       // 2 bits INPUT : hours and minutes edit buttons
        .alarm(),           // 1 bit OUTPUT : alarm trigger
        .disp_time()        // 17 bits OUTPUT : displayed time (alarm or clock)
    );
*/
////////////////////////////////////////////


module reloj(
    input clk,              // clock
    input reset,            // reset
    input mode,             // alarm or clock modes
    input [1:0] edit_btns,  // hours and minutes edit buttons
    output alarm,           // alarm trigger
    output [16:0] disp_time // displayed time (alarm or clock)
    );
    
    watch instance_watch (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .edit_btns,         // 2 bits INPUT : hours and minutes edit buttons
        .current_time       // 17 bits OUTPUT : clock time in 24h format
    );
    
    clock_mode instance_mode (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mode(),            // 1 bit INPUT : alarm or clock edit modes
        .in_edit_btns(),    // 2 bits INPUT : hours and minutes edit buttons
        .current_time(),    // 17 bits INPUT : current clock time
        .alarm_time(),      // 17 bits INPUT : setted alarm time
        .clock_edit_btns(), // 2 bits OUTPUT : current time, hours and minutes edit buttons 
        .alarm_edit_btns(), // 2 bits OUTPUT : alarm time, hours and minutes edit buttons
        .display_time 
    );
    
    alarm instance_alarm (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mode(),            // 1 bit INPUT : time or alarm edit modes
        .edit_btns(),       // 2 bits INPUT : hours and minutes edit buttons
        .current_time(),    // 17 bits INPUT : clock time for comparison
        .alarm_time(),      // 17 bits OUTPUT : setted alarm time
        .alarm              // 1 bit OUTPUT : alarm trigger
    );
        
endmodule
