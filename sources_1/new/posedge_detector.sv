`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes 
// 
// Create Date: 19.10.2019 14:34:29
// Design Name: 
// Module Name: edge_detector
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
    posedge_detector #(.N(11)) instance_name ( // 2^(N-1)/clock_freq = hold time for continuous pressing 
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .in_signal(),       // 1 bit INPUT : input signal
        .signal_edges()     // 1 bit OUTPUT : signal posedges 
    );
*/
////////////////////////////////////////////

// After being pressed 2^(N-1)/clock_freq secs, a new posedge is generated every 2^(N-2) cycles
module posedge_detector #(parameter N = 11)( // 2^(N-1)/clock_freq = hold time for continuous pressing 
    input clk,
    input reset,
    input in_signal,
    output signal_edges
    );
    
    logic DFF1, DFF2;
    logic in_edge;
    
    assign in_edge = (DFF1 ^ DFF2) ;
    assign signal_edges = in_edge; // falta agregar 
    
    always_ff @(posedge clk) begin
        if ( reset == 1'b1) begin
            DFF1 <= 1'b0;
            DFF2 <= 1'b0;
        end
        else begin
            DFF1 <= in_signal;
            DFF2 <= DFF1;
        end
    end
    
endmodule
