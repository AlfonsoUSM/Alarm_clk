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
    logic [19:0] edit_time, next_edit;
    logic secs_clk;
    logic secs;
    
    assign current_time = clock_time;
 
    always_ff @ (posedge clk) begin
        if ( reset == 1'b1)
            edit_time[19:0] <= 20'd0;
        else begin
            edit_time[19:0] <= next_edit[19:0];
        end
    end
    
    always_ff @ (negedge clk) begin
        clock_time[19:0] <= next_time[19:0];   
    end
    
    // normal clock increment logic       
    always_comb begin
        if (secs == 1'b1) begin
            if ( edit_time[3:0] == 4'd9 ) begin                     // time == xx:xx:x9
                if ( edit_time[6:4] == 3'd5 ) begin                 // time == xx:xx:59
                    if ( edit_time[10:7] == 4'd9 ) begin            // time == xx:x9:59
                        if ( edit_time[13:11] == 3'd5 ) begin       // time == xx:59:59 
                            if ( edit_time[19:14] == {2'd2, 4'd3} ) // time == 23:59:59
                                next_time[19:0] = 20'd0;
                            else begin                             
                                if (edit_time[17:14] == 4'd9 )      // time == x9:59:59
                                    next_time[19:0] = {edit_time[19:18] + 2'd1, 18'd0};
                                else
                                    next_time[19:0] = {edit_time[19:18], edit_time[17:14] + 4'd1, 14'd0};
                            end
                        end
                        else
                            next_time[19:0] = {edit_time[19:14], edit_time[13:11] + 3'd1, 11'd0};
                    end
                    else
                        next_time[19:0] = {edit_time[19:11], edit_time[10:7] + 4'd1, 7'd0};
                end
                else
                    next_time[19:0] = {edit_time[19:7], edit_time[6:4] + 3'd1, 4'd0};
            end
            else
                next_time[19:0] = {edit_time[19:4], edit_time[3:0] + 4'd1};
        end
        else
            next_time[19:0] = edit_time[19:0];
    end
   
    // edit buttons logic
    always_comb begin    
        if ( edit_btns[1] == 1'b1 ) begin
            // Edit alarm hour
            if ( clock_time[19:14] == {2'd2, 4'd3} )                     // hour == 23
                next_edit[19:14] = 6'd0;
            else begin
                if ( clock_time[17:14] == 4'd9 )                         // hour == x9
                    next_edit[19:14] = {clock_time[19:18] + 2'd1, 4'd0};
                else
                    next_edit[19:14] = {clock_time[19:18], clock_time[17:14] + 4'd1};
            end
        end
        else
            next_edit[19:14] = clock_time[19:14];
        if ( edit_btns[0] == 1'b1 ) begin
            // Edit alarm minute                     
            if ( clock_time[13:7] == {3'd5, 4'd9} )                  // minutes == 59
                next_edit[13:7] = 7'b0;
            else begin
                if ( clock_time[10:7] == 4'd9 )                      // minutes == x9
                    next_edit[13:7] = {clock_time[13:11] + 3'd1, 4'd0};
                else
                    next_edit[13:7] = {clock_time[13:11], clock_time[10:7] + 4'd1};
            end
        end
        else
            next_edit[13:7] = clock_time[13:7];
        next_edit[6:0] = clock_time[6:0];
    end
    
//    always_ff @ (posedge edit_btns[1]) begin
//        // Edit alarm hour
//        if ( edit_time[19:14] == {2'd2, 4'd3} )                     // hour == 23
//            next_edit[19:14] <= 6'd0;
//        else begin
//            if ( edit_time[17:14] == 4'd9 )                         // hour == x9
//                next_edit[19:14] <= {clock_time[19:18] + 2'd1, 4'd0};
//            else
//                next_edit[19:14] <= {clock_time[19:18], clock_time[17:14] + 4'd1};
//        end
//    end
    
//    always_ff @ (posedge edit_btns[0]) begin
//        // Edit alarm minute                     // minutes edit signal
//        if ( edit_time[13:7] == {3'd5, 4'd9} )                  // minutes == 59
//            next_edit[13:7] <= 7'b0;
//        else begin
//            if ( edit_time[10:7] == 4'd9 )                      // minutes == x9
//                next_edit[13:7] <= {clock_time[13:11] + 3'd1, 4'd0};
//            else
//                next_edit[13:7] <= {clock_time[13:11], clock_time[10:7] + 4'd1};
//        end
//    end
    
    clock_divider #(.d (100000000)) seconds_clk(
        .clk_in(clk),
        .reset(reset),
        .clk_out(secs_clk)
    );
    
    posedge_detector instance_name (
        .clk(clk),             // 1 bit INPUT : clock
        .reset(reset),           // 1 bit INPUT : reset
        .in_signal(secs_clk),       // 1 bit INPUT : input signal
        .signal_edges(secs)     // 1 bit OUTPUT : signal posedges 
    );
        
endmodule
