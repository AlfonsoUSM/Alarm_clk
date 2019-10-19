`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: alarm
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
    alarm instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mode(),            // 1 bit INPUT : time or alarm edit modes
        .edit_btns(),       // 2 bits INPUT : hours and minutes edit buttons
        .current_time(),    // 17 bits INPUT : clock time for comparison
        .alarm_time(),      // 17 bits OUTPUT : setted alarm time
        .alarm              // 1 bit OUTPUT : alarm trigger
    );
*/
////////////////////////////////////////////

module alarm(
    input clk,                      // clock                          
    input reset,                    // reset                          
    input mode,                     // time or alarm edit modes       
    input [1:0] edit_btns,          // hours and minutes edit buttons
    input [16:0] current_time,      // clock time for comparison    
    output [16:0] alarm_time,       // setted alarm time           
    output alarm                    // alarm trigger                 
    );
endmodule
