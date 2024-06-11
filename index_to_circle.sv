module index_to_circle(
input 									clk_i, 						// clock input
input 									rst_ni,						//asynchronus reset
input 	reg [3 - 1:0] 				row_index_i,				//index of one from 6 7seg leds
input 	bit				 			column_index_i,			//upper or buttom part of the led
output 	 [48 - 1:0] 			seg7_o								
);
	
localparam UPPER_CIRCLE = 8'b0110_0011;						//upper circle code
localparam LOWER_CIRCLE = 8'b0101_1100;						//bottom circle code
reg [8 - 1:0] current_circle;

always @(posedge clk_i or negedge rst_ni) begin
	case (column_index_i)										//check the current column index
		'd0: current_circle <= UPPER_CIRCLE;				//set current circle to upper
		'd1: current_circle <= LOWER_CIRCLE; 				//set current circle to bottom 
	endcase
end

always @(posedge clk_i or negedge rst_ni) begin	
	if (!rst_ni) seg7_o <= 48'b0; else
		seg7_o <= ~(current_circle << row_index_i * 8);		//selects the led depending on the index
end

endmodule