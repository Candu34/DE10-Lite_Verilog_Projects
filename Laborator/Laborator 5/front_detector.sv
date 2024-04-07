module front_detector(
input 				clk_i,					//clock signal
input 				rst_ni,					//asynchronus reset signal
input 				button_input,			//signal from button 
output reg			possitive_front_o,	//set active for 1 clock period if detects possitive front
output reg			negative_front_o		//set active for 1 clock period if detects negative front
);

reg q;	//dff output

always @(posedge clk_i or negedge rst_ni)  // dff
	if (~rst_ni) q <= 1'b0; else
		q <= button_input;
		
		
always @(posedge clk_i or negedge rst_ni) 
	if (~rst_ni) possitive_front_o <= 1'b0; else
		if(~button_input && q) possitive_front_o <= 1; else
			possitive_front_o <= 0;
		
always @(posedge clk_i or negedge rst_ni) 
	if (~rst_ni) negative_front_o <= 1'b0; else
		if(button_input && ~q) negative_front_o <= 1; else
			negative_front_o <= 0;
		
//assign possitive_front_o = ~button_input & q;		//active if the input of dff is 0 and output is 1 (positive front)
//assign negative_front_o = button_input & ~q;		//active if the input of dff is 1 and output is 0 (negative front)


endmodule