`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
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


module topmodule(
    input CLK100MHZ,
    input CPU_RESETN,
    input [1:0]SW,
    input BTNL, BTNR,
    output CA, CB, CC, CD, CE, CF, CG, DP,
    output [7:0]AN,
    output [7:0]LED
);
    
    logic debouced_left, debounced_right;
    logic [19:0] disp_time;
    logic alarm_trigger;
    logic [15:0] seg7output;
    
    assign { CA, CB, CC, CD, CE, CF, CG, DP } =  seg7output[15:8];
    assign AN[7:0] = seg7output[7:0];

    debouncer #(.N(11)) debounce_right (// 2^(N-1) / clock_freq = debounce time
        .clk(CLK100MHZ),                 // 1 bit INPUT : clock
        .reset(~CPU_RESETN),            // 1 bit INPUT : reset
        .in_btn(BTNR),                  // 1 bit INPUT : in signal
        .out_btn(debounced_right)       // 1 bit OUTPUT : debounced signal
    );
    
    debouncer #(.N(11)) debounce_left ( // 2^(N-1) / clock_freq = debounce time
        .clk(CLK100MHZ),                 // 1 bit INPUT : clock
        .reset(~CPU_RESETN),            // 1 bit INPUT : reset
        .in_btn(BTNL),                  // 1 bit INPUT : in signal
        .out_btn(debouced_left)         // 1 bit OUTPUT : debounced signal
    );

    reloj reloj_instance (
        .clk(CLK100MHZ),                 // 1 bit INPUT : clock
        .reset(~CPU_RESETN),            // 1 bit INPUT : reset
        .mode(SW[1]),                   // 1 bit INPUT : clock (0) or alarm (1) modes
        .edit_btns({debouced_left, debounced_right}),       // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (debounced)
        .alarm(alarm_trigger),          // 1s bit OUTPUT : alarm trigger
        .disp_time(disp_time)           // 20 bits OUTPUT : displayed time (alarm or clock)
    );

    display display_instance (
        .clk(CLK100MHZ),                 // 1 bit INPUT : clock
        .reset(~CPU_RESETN),            // 1 bit INPUT : reset
        .mod12_24(SW[0]),               // 1 bit INPUT : display mode, 12h AM/PM or 24h
        .alarm(alarm_trigger),          // 1 bit INPUT : alarm trigger
        .disp_time(disp_time),          // 20 bits INPUT : diplayed time
        .seg7s(seg7output[15:0]),       // 16 bits OUTPUT : 7 SEGMENTS 
        .leds(LED[7:0])                 // 8 bits OUTPUT : LEDS
    );
    
endmodule
