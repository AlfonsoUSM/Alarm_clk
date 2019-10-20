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
        .disp_time(),       // 17 bits INPUT : time to be displayed
        .seg7s()            // 16 bits OUTPUT : 7 SEGMENTS
    );
*/
////////////////////////////////////////////

module display_ctrl(
    input clk,                    // clock
    input reset,                  // reset
    input [16:0] disp_time,       // time to be displayed
    output [15:0] seg7s           // 7 SEGMENTS
);
    
    logic [1:0][3:0] hours, minutes, seconds;
    logic [2:0] current_seg, next_seg;
    logic [5:0] segs;
    logic [7:0] anodes;
    logic [6:0] cathodes;           // without DP, active low
    logic DP;
    logic [3:0] digit;
    
    //assign seg7s[15:0] = { cathodes[6:0] , DP, anodes[7:0] };
    
    always_ff @( posedge clk ) begin
        if ( reset == 1'b1 )   
            current_seg[2:0] <= 3'b0;
        else
            current_seg[2:0] <= next_seg[2:0];
    end
    
    always_comb begin
        case ( current_seg[2:0] )           // actives the right anode and chooses the correspondant digit
            3'b000: begin
                digit = seconds[0];
                anodes[7:0] = 8'b11111110;
            end
            3'b001: begin
                digit = seconds[1];
                anodes[7:0] = 8'b11111101;
            end 
            3'b010: begin
                digit = minutes[0];
                anodes[7:0] = 8'b11111011;
            end
            3'b011: begin
                digit = minutes[1];
                anodes[7:0] = 8'b11110111;
            end
            3'b100: begin
                digit = hours[0];
                anodes[7:0] = 8'b11101111;
            end
            3'b101: begin
                digit = hours[1];
                anodes[7:0] = 8'b11011111;
            end
            default: begin
                digit = 4'b1111;
                anodes[7:0] = 8'b01111111;
            end
        endcase
        if ( current_seg[2:0] == 3'b101 )
            next_seg[2:0] = 3'b0;
        else
            next_seg[2:0] = current_seg[2:0] + 1;
    end    
    
    always_comb begin
        case (digit[3:0])
            4'd0:
                cathodes = 7'b0000001;
            4'd1:        
                cathodes = 7'b1001111;
            4'd2:       
                cathodes = 7'b0010010;
            4'd3:        
                cathodes = 7'b0000110;
            4'd4:        
                cathodes = 7'b1001100;
            4'd5:        
                cathodes = 7'b0100100;
            4'd6:        
                cathodes = 7'b0100000;
            4'd7:        
                cathodes = 7'b0001111;
            4'd8:        
                cathodes = 7'b0000000;
            4'd9:        
                cathodes = 7'b0000100;
            default :
                cathodes = 7'b1111110; // -
        endcase
    end
endmodule
