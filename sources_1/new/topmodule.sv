`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 15.10.2019 19:51:38
// Design Name: 
// Module Name: topmodule
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


module topmodule();

    debouncer #(.N(11)) debounce_right ( 
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .in_btn(),          // 1 bit INPUT : in signal
        .out_btn()          // 1 bit OUTPUT : debounced signal
    );
    
    debouncer #(.N(11)) debounce_left (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .in_btn(),          // 1 bit INPUT : in signal
        .out_btn()          // 1 bit OUTPUT : debounced signal
    );

    reloj instance_reloj (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mode(),            // 1 bit INPUT : alarm or clock modes
        .edit_btns(),       // 2 bits INPUT : hours and minutes edit buttons
        .alarm(),           // 1 bit OUTPUT : alarm trigger
        .disp_time()        // 17 bits OUTPUT : displayed time (alarm or clock)
    );

    display instance_display (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .mod12_24(),        // 1 bit INPUT : display mode, 12h AM/PM or 24h
        .alarm(),           // 1 bit INPUT : alarm trigger
        .disp_time(),       // 17 bits INPUT : diplayed time
        .seg7s(),           // 16 bits OUTPUT : 7 SEGMENTS 
        .leds()             // 8 bits OUTPUT : LEDS
    );
endmodule
