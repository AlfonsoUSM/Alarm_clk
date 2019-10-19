`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes 
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: clock_mode
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
    clock_mode instance_name (
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
*/
////////////////////////////////////////////

module clock_mode(
    input clk,
    input reset,
    input mode,
    input [1:0] in_edit_btns,
    input [16:0] current_time,
    input [16:0] alarm_time,
    output [1:0] clock_edit_btns,
    output [1:0] alarm_edit_btns,
    output [16:0] display_time
    );
endmodule
