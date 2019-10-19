`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 16.10.2019 09:26:22
// Design Name: Button Debouncer
// Module Name: debouncer
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
    debouncer #(.N(11)) instance_name (  // 2^(N-1) / clock_freq = debounce time
        .clk(),             // 1 bit INPUT : clock
        .reset(),           // 1 bit INPUT : reset
        .in_btn(),          // 1 bit INPUT : in signal
        .out_btn()          // 1 bit OUTPUT : debounced signal
    );
*/
////////////////////////////////////////////

module debouncer #(parameter N = 11)(
    input clk,
    input reset,
    input in_btn,
    output out_btn
    );

	reg [N-1 : 0] count, next_count;	                       // timing regs
	reg DFF1, DFF2, DFF3;            						   // input sinchronizers flip-flops regs
	reg out, next_out;                                         // output flip-flop regs
	wire count_flag;										   // counter flag wire
	wire in_edge;                                              // edge flag wire
	
//// ------------------------------------------------------

////contenious assignment for counter control
	assign in_edge = (DFF1  ^ DFF2);		// input edge detector (XOR) 
	assign count_flag = count[N-1];			//debounce time flag, counter's msb is equal to 1
	assign out_btn = out;

//// Synchronizer

	always_ff @ ( posedge clk ) begin
    	if(reset ==  1'b1) begin
        	DFF1 <= 1'b0;
        	DFF2 <= 1'b0;
        	DFF3 <= 1'b0;
        end
    	else begin
    		DFF1 <= in_btn;
    		DFF2 <= DFF1;
    		DFF3 <= DFF2;
    	end
    end
		
//// Counter
	
    always_comb begin                           
        case ( { in_edge , count_flag } )               
            2'b00:                                      // constant input, increase counter
                next_count = count + 1;
            2'b01:                                      // debounce time elapsed
                next_count = count;
            default:                                    // edge detected, restart counter
                next_count = { {(N - 1){1'b0}}, 1'b1 };
        endcase
    end
		
    always_ff @ ( posedge clk ) begin            
        if (reset == 1'b1)
		    count <= { N {1'b0} };
        else
            count <= next_count;
    end
       
//// Output signal

    always_comb begin
        if ( count_flag == 1'b1 )                       // debounce time elased, update output
            next_out = DFF3;
        else                                            // hold output
            next_out = out;
    end

    always_ff @ ( posedge clk ) begin
        if ( reset == 1'b1 )
            out <= 1'b0;
        else
            out <= next_out;
    end
		
endmodule