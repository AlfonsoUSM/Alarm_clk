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
        .mode(),            // 1 bit INPUT : clock (0) or alarm (1) modes
        .edit_btns(),       // 2 bits INPUT : hours and minutes edit buttons
        .alarm(),           // 1 bit OUTPUT : alarm trigger
        .disp_time()        // 20 bits OUTPUT : displayed time (alarm or clock)
    );
*/
////////////////////////////////////////////


module reloj(
    input clk,              // clock
    input reset,            // reset
    input mode,             // clock (0) or alarm (1) modes
    input [1:0] edit_btns,  // hours and minutes edit buttons
    output alarm,           // alarm trigger
    output [19:0] disp_time // displayed time (alarm or clock)
);
    
    logic [1:0] clock_btns_edges, alarm_btns_edges;
    logic [19:0] current_time, alarm_time;
    
    watch watch_instance (
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .edit_btns(clock_btns_edges),         // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (edges)
        .current_time(current_time)       // 20 bits OUTPUT : clock time in 24h format
    );
    
    clock_mode mode_instance (
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .mode(mode),            // 1 bit INPUT : alarm or clock edit modes
        .in_edit_btns(edit_btns),    // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (debounced)
        .current_time(current_time),    // 20 bits INPUT : current clock time
        .alarm_time(alarm_time),      // 20 bits INPUT : setted alarm time
        .clock_edit_btns(clock_btns_edges), // 2 bits OUTPUT : current time, hours (msb) and minutes (lsb) edit buttons (edges)
        .alarm_edit_btns(alarm_btns_edges), // 2 bits OUTPUT : alarm time, hours (msb) and minutes (lsb) edit buttons (edges)
        .display_time(disp_time),
        .alarm(alarm)              // 1 bit OUTPUT : alarm trigger 
    );
    
    alarm alarm_instance (
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .edit_btns(alarm_btns_edges),       // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (edges)
        .alarm_time(alarm_time)      // 20 bits OUTPUT : setted alarm time
    );
        
endmodule
