`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// University: UTFSM (IPD432 Advanced Digital Systems Design 2019-2)
// Engineer: Alfonso Cortes
// 
// Create Date: 17.10.2019 13:03:56
// Design Name: 
// Module Name: simu_debounce
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


module simu_debounce();

    logic CLK;
    logic RESET;
    logic in_BTN;
    logic out_BTN;
    
    
    initial begin
        CLK = 1'b1;
        RESET = 1'b0;
        in_BTN = 1'b0;
        #2;
        RESET = 1'b1;
        #2;
        RESET = 1'b0;
        #4;
    end
    
    always #1 CLK = ~ CLK;
    
    always 
		begin
			#10 in_BTN = 1'b1;
			
			#2 in_BTN = 1'b0;		
			
			#2 in_BTN = 1'b1;	
			
			#4 in_BTN = 1'b0;				
			
			#2 in_BTN = 1'b1;

			#6 in_BTN = 1'b0;
			
			#2 in_BTN = 1'b1;		
			
			#8 in_BTN = 1'b0;

			#2 in_BTN = 1'b1;
			
			#10 in_BTN = 1'b0;		
			
			#2 in_BTN = 1'b1;

			#12 in_BTN = 1'b0;
			
			#2 in_BTN = 1'b1;		
			
			#14 in_BTN = 1'b0;
			
			#2 in_BTN = 1'b1;
			
			#16 in_BTN = 1'b0;		
			
			#2 in_BTN = 1'b1;
			
			#18 in_BTN = 1'b0;
			
			#14 in_BTN = 1'b1;

			#2 in_BTN = 1'b0;
			
			#16 in_BTN = 1'b1;
			
			#16 in_BTN = 1'b0;

		end
    
    debouncer #(.N(4)) debounce_instance (  // 2^(N-1) / clock_freq = debounce time
        .clk(CLK),             // 1 bit INPUT : clock
        .reset(RESET),           // 1 bit INPUT : reset
        .in_btn(in_BTN),          // 1 bit INPUT : in signal
        .out_btn(out_BTN)          // 1 bit OUTPUT : debounced signal
    );
    
endmodule
