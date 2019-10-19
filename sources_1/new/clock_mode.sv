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
        .in_edit_btns(),    // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (debounced)
        .current_time(),    // 17 bits INPUT : current clock time
        .alarm_time(),      // 17 bits INPUT : setted alarm time
        .clock_edit_btns(), // 2 bits OUTPUT : current time, hours and minutes edit buttons (edges)
        .alarm_edit_btns(), // 2 bits OUTPUT : alarm time, hours and minutes edit buttons (edges)
        .display_time()     // 17 bits OUTPUT : time to be desplayed
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
    
    logic [1:0] edit_btns_edges;
    logic [1:0] clock_btns, alarm_btns;
    logic [16:0] display;
    
    assign clock_edit_btns = clock_btns;
    assign alarm_edit_btns = alarm_btns;
    assign display_time = display; 
    
    always_comb begin
        if ( mode == 1'b0 ) begin           // clock mode 
            clock_btns = edit_btns_edges;
            alarm_btns = 2'b0;
            display = current_time;
        end
        else begin                              // Set alarm mode
            clock_btns = 2'b0;
            alarm_btns = edit_btns_edges;
            display = alarm_time;
        end
    end
    
    posedge_detector #(.N(11)) posedge_detector_left ( // 2^(N-1)/clock_freq = hold time for continuous pressing 
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .in_signal(in_edit_btns[1]),       // 1 bit INPUT : input signal
        .signal_edges(edit_btns_edges[1])     // 1 bit OUTPUT : signal posedges 
    );

    posedge_detector #(.N(11)) posedge_detector_right ( // 2^(N-1)/clock_freq = hold time for continuous pressing 
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .in_signal(in_edit_btns[0]),       // 1 bit INPUT : input signal
        .signal_edges(edit_btns_edges[0])     // 1 bit OUTPUT : signal posedges 
    );
            
endmodule
