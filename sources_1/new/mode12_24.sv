`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
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
        .reset(),           // 1 bit INPUT : reset
        .mod12_24(),        // 1 bit INPUT : 12h AM/PM or 24h mode
        .in_disp_time(),    // 20 bits INPUT : time to display in 24h format
        .led0(),            // 1 bit OUTPUT : led0 (AM/PM)
        .out_disp_time()    // 20 bits OUTPUT : time to display in setted format
    );
*/
////////////////////////////////////////////

module mode12_24(
    input reset,                    // reset
    input mod12_24,                 // 12h AM/PM or 24h mode
    input [19:0] in_disp_time,      // time to display in 24h format
    output led0,                    // led0 (AM/PM)
    output [19:0] out_disp_time     // time to display in setted format
);
    
    logic [5:0] hour12_24;
    logic pm;
    assign out_disp_time[19:0] = {hour12_24[5:0] , in_disp_time[13:0]};
    assign led0 = pm;
    
    always_comb begin
        if (mod12_24 == 1'b1) begin
            case (in_disp_time[19:14])
                {2'd2, 4'd3}: begin
                    hour12_24[5:0] = {2'd1, 4'd1};
                    pm = 1'd1;
                end
                {2'd2, 4'd2}: begin
                    hour12_24[5:0] = {2'd1, 4'd0};
                    pm = 1'd1;
                end
                {2'd2, 4'd1}: begin
                    hour12_24[5:0] = {2'd0, 4'd9};
                    pm = 1'd1;
                end
                {2'd2, 4'd0}: begin
                    hour12_24[5:0] = {2'd0, 4'd8};
                    pm = 1'd1;
                end
                {2'd1, 4'd9}: begin
                    hour12_24[5:0] = {2'd0, 4'd7};
                    pm = 1'd1;
                end
                {2'd1, 4'd8}: begin
                    hour12_24[5:0] = {2'd0, 4'd6};
                    pm = 1'd1;
                end
                {2'd1, 4'd7}: begin
                    hour12_24[5:0] = {2'd0, 4'd5};
                    pm = 1'd1;
                end
                {2'd1, 4'd6}: begin
                    hour12_24[5:0] = {2'd0, 4'd4};
                    pm = 1'd1;
                end
                {2'd1, 4'd5}: begin
                    hour12_24[5:0] = {2'd0, 4'd3};
                    pm = 1'd1;
                end
                {2'd1, 4'd4}: begin
                    hour12_24[5:0] = {2'd0, 4'd2};
                    pm = 1'd1;
                end
                {2'd1, 4'd3}: begin
                    hour12_24[5:0] = {2'd0, 4'd1};
                    pm = 1'd1;
                end
                default: begin
                    hour12_24[5:0] = in_disp_time[19:14];
                    pm = 1'b0;
                 end
            endcase
        end
        else begin
            hour12_24[5:0] = in_disp_time[19:14];
            pm = 1'b0;
        end
    end 
    
endmodule
