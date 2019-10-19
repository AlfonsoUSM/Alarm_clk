`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: watch
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
    watch instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .edit_btns(),       // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (edges)
        .current_time()     // 17 bits OUTPUT : clock time in 24h format
    );
*/
////////////////////////////////////////////

module watch(
    input clk,                      // clock                           
    input reset,                    // reset                           
    input [1:0] edit_btns,          // hours (msb) and minutes (lsb) edit buttons (edges)
    output [16:0] current_time      // clock time in 24h format     
    );
endmodule
