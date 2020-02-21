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
        .edit_btns(),       // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (edges)
        .alarm_time()       // 20 bits OUTPUT : setted alarm time
    );
*/
////////////////////////////////////////////

module alarm(
    input clk,                      // clock                          
    input reset,                    // reset                              
    input [1:0] edit_btns,          // hours (msb) and minutes (lsb) edit buttons (edges)
    output [19:0] alarm_time        // setted alarm time              
);
    
    
    logic [12:0] a_time, next_time;                 // alarm time regs (only hours and minutes)
    
    assign alarm_time = { a_time , 5'b0 };          // secs always 0
    
    always_ff @( posedge clk ) begin
        if ( reset == 1'b1 ) begin
            a_time <= 13'b0;
        end
        else begin
            a_time <= next_time;
        end
    end
        
    always_comb begin
        // Edit alarm hour
        if ( edit_btns[1] == 1'b1 ) begin                           // hours edit signal
            if ( a_time[12:7] == {2'd2, 4'd3} )                     // hour == 23
                next_time[12:7] = 6'd0;
            else begin
                if ( a_time[10:7] == 4'd9 ) begin                   // hour == x9
                    next_time[12:7] = {a_time[12:11] + 1, 4'd0};
                end
                else
                    next_time[12:7] = {a_time[12:11], a_time[10:7] + 1};
            end
        end
        else
            next_time[12:7] = a_time[12:7];
        // Edit alarm minute
        if ( edit_btns[0] == 1'b1 ) begin                       // minutes edit signal
            if ( a_time[6:0] == {3'd5, 4'd9} )                  // minutes == 59
                next_time[6:0] = 7'b0;
            else begin
                if ( a_time[3:0] == 4'd9 )                      // minutes == x9
                    next_time[6:0] = {a_time[6:4] + 1, 4'd0};
                else
                    next_time[6:0] = {a_time[6:4], a_time[3:0] + 1};
            end
        end
        else
            next_time[6:0] = a_time[6:0]; 
    end
    
endmodule
