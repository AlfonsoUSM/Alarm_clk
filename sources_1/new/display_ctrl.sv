`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: 
// Module Name: display_ctrl
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
    display_ctrl instance_name (
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .disp_time(),       // 20 bits INPUT : time to be displayed
        .seg7s()            // 16 bits OUTPUT : 7 SEGMENTS
    );
*/
////////////////////////////////////////////

module display_ctrl(
    input clk,                    // clock
    input reset,                  // reset
    input [19:0] disp_time,       // time to be displayed
    output [15:0] seg7s           // 7 SEGMENTS
);
    
    logic [1:0][3:0] hours, minutes, seconds;
    logic [5:0] anode, next_anode;
    logic [6:0] cathodes;           // without DP, active low
    logic DP;
    logic [3:0] digit;
    logic sec_clk;
    
    assign seg7s[15:0] = { cathodes[6:0], DP , anode[5:0], 2'b11 };
    assign hours[1] = {2'b00, disp_time[19:18]};
    assign hours[0] = {disp_time[17:14]};
    assign minutes[1] = {1'b0, disp_time[13:11]};
    assign minutes[0] = disp_time[10:7];
    assign seconds[1] = {1'b0, disp_time[6:4]};
    assign seconds[0] = disp_time[3:0];
    
    always_ff @( posedge sec_clk ) begin
        if ( reset == 1'b1 )   
            anode[5:0] <= 6'b111110;
        else
            anode[5:0] <= next_anode[5:0];
    end
    
    always_comb begin
        next_anode[5:0] = {anode[4:0], anode[5]};
        case ( anode[5:0] )           // actives the right anode and chooses the correspondant digit
            6'b111110: begin
                digit = seconds[0];
                DP = 1'b1;
            end
            6'b111101: begin
                digit = seconds[1];
                DP = 1'b1;
            end 
            6'b111011: begin
                digit = minutes[0];
                DP = 1'b0;
            end
            6'b110111: begin
                digit = minutes[1];
                DP = 1'b1;
            end
            6'b101111: begin
                digit = hours[0];
                DP = 1'b1;
            end
            6'b011111: begin
                digit = hours[1];
                DP = 1'b1;
            end
            default: begin
                digit = 4'b1111;
                DP = 1'b0;
            end
        endcase
    end    
    
    segment7 bcd_to_7seg(
        .bcd(digit[3:0]),
        .seg(cathodes[6:0])
    );
    
    clock_divider #(.d (10000)) seg7freq ( 
        .clk_in(clk),
        .reset(reset),
        .clk_out(sec_clk)
    );
endmodule
