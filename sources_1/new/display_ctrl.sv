`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: display_ctrl
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
    display_ctrl instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .disp_time(),       // 17 bits INPUT : time to be displayed
        .deg7s              // 16 bits OUTPUT : 7 SEGMENTS
    );
*/
////////////////////////////////////////////

module display_ctrl(
    input clk,                    // clock
    input reset,                  // reset
    input [16:0] disp_time,       // time to be displayed
    output [15:0] seg7s           // 7 SEGMENTS
    );
endmodule
