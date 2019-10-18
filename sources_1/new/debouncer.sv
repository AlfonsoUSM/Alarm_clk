`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: debouncer
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
    debouncer #(.N(11)) instance_name (  // 2^ (N-1) )/ 38 MHz = debounce time
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .in_btn(),          // 1 bit INPUT : in signal
        .out_btn()          // 1 bit OUTPUT : debounced signal
    );
*/
////////////////////////////////////////////

module debouncer #(parameter N = 11)(
    input clk,
    input reset,
    input in_btn,
    output out_btn
    );


endmodule