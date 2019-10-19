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
        .edit_btns(),       // 2 bits INPUT : hours (msb) and minutes (lsb) edit buttons (edges)
        .current_time(),    // 17 bits INPUT : clock time for comparison
        .alarm_time(),      // 17 bits OUTPUT : setted alarm time
        .alarm()            // 1 bit OUTPUT : alarm trigger
    );
*/
////////////////////////////////////////////

module alarm(
    input clk,                      // clock                          
    input reset,                    // reset                          
    input mode,                     // clock (0) or alarm (1) modes (alarm trigger enable)      
    input [1:0] edit_btns,          // hours (msb) and minutes (lsb) edit buttons (edges)
    input [16:0] current_time,      // clock time for comparison    
    output [16:0] alarm_time,       // setted alarm time           
    output alarm                    // alarm trigger                 
    );
    
    
    logic [10:0] a_time, next_time;                 // alarm time regs (only hours and minutes)
    logic alarm_trigger, next_trigger;
    
    assign alarm_time = { a_time , 6'b0 };          // secs always 0
    assign alarm = alarm_trigger;
    
    always_ff @( posedge clk ) begin
        if ( reset == 1'b1 ) begin
            alarm_trigger <= 1'b0;
            a_time <= 11'b0;
        end
        else begin
            alarm_trigger <= next_trigger;
            a_time <= next_time;
        end
    end
        
    always_comb begin
        // Edit alarm time
        if ( edit_btns[1] == 1'b1 )                             // hours edit signal
            next_time[10:6] = ( (a_time[10:6] + 1) % 60 );
        else
            next_time[10:6] = a_time[10:6];
        if ( edit_btns[0] == 1'b1 )                             // minutes edit signal
            next_time[5:0] = ( (a_time[5:0] +1) % 60 );
        else
            next_time[5:0] = a_time[5:0];
        // Alarm trigger
        if ( alarm_time == current_time && mode == 1'b0 )       // trigger only on clock mode
            next_trigger = 1'b1;
        else
            next_trigger = 1'b0;        
    end
    
endmodule
