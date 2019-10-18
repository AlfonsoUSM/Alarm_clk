`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: mode12_24
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
    mode12_24 instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mod12_24(),        // 1 bit INPUT : 12h AM/PM or 24h mode
        .in_disp_time(),    // 17 bits INPUT : time to display in 24h format
        .led0(),            // 1 bit OUTPUT : led0 (AM/PM)
        .out_disp_time()    // 17 bits OUTPUT : time to display in setted format
    );
*/
////////////////////////////////////////////

module mode12_24(
    input clk,                      // clock
    input reset,                    // reset
    input mod12_24,                 // 12h AM/PM or 24h mode
    input [16:0] in_disp_time,      // time to display in 24h format
    output led0,                    // led0 (AM/PM)
    output [16:0] out_disp_time     // time to display in setted format
    );
endmodule
