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
        .current_time()     // 20 bits OUTPUT : clock time in 24h format
    );
*/
////////////////////////////////////////////

module watch(
    input clk,                      // clock                           
    input reset,                    // reset                           
    input [1:0] edit_btns,          // hours (msb) and minutes (lsb) edit buttons (edges)
    output [19:0] current_time      // clock time in 24h format     
    );
    
    logic [19:0] clock_time, next_time;
    logic [25:0] counter, next_counter;
    logic secs_clk, next_sec;
    
    assign current_time = clock_time;
    
    always_ff @ (posedge clk) begin    
        if ( reset == 1'b1 ) begin
            counter[25:0] <= 26'd0;
            secs_clk <= 1'b0;
        end
        else begin
            counter[25:0] <= next_counter[25:0];
            secs_clk <= next_sec;
        end
    end
    
    always_comb begin
        if ( counter[25:0] == 26'd50_000_000 - 1 ) begin
            if ( secs_clk == 1'b1 )
                next_sec = 1'b0;
            else
                next_sec = 1'b1;
            next_counter[25:0] = 26'd0;
        end
        else
            next_counter[25:0] = counter[25:0] + 1;
            next_sec = secs_clk;
    end
    
    always_ff @ (posedge secs_clk) begin
        if ( reset == 1'b1)
            clock_time[19:0] <= 20'd0;
        else
            clock_time[19:0] <= next_time;   
    end
    
    always_comb begin
        if ( clock_time[3:0] == 4'd9 ) begin
            if ( clock_time[6:4] == 3'd5 ) begin
                if ( clock_time[10:7] == 4'd9 ) begin
                    if ( clock_time[13:11] == 3'd5 ) begin
                        if ( clock_time[17:14] == 4'd9 ) begin
                            if ( clock_time[19:18] == 2'd2 )
                                next_time = 20'd0;
                            else
                                next_time = {clock_time[19:18] + 1, 18'd0};
                        end
                        else
                            next_time = {clock_time[19:18], clock_time[17:14] + 1, 14'd0};
                    end
                    else
                        next_time = {clock_time[19:14], clock_time[13:11] + 1, 11'd0};
                end
                else
                    next_time = {clock_time[19:11], clock_time[10:7] + 1, 7'd0};
            end
            else
                next_time = {clock_time[19:7], clock_time[6:4] + 1, 4'd0};
        end
        else
            next_time = {clock_time[19:4], clock_time[3:0] + 1};
    end
    
endmodule
