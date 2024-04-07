module counter#(
parameter TIME_TO_COUNT = 50
)(
input 						clk_i,
input 						rst_ni,
input 						en_i,
output wire 				enable_o
);

localparam WIDTH = $clog2(TIME_TO_COUNT);

reg [WIDTH - 1:0] count;

always @(posedge clk_i or negedge rst_ni) 
	if(~rst_ni) count <= 'd0; else
		if((count == TIME_TO_COUNT) && en_i) count <= 'd0; else
			 if(en_i) count <= count + 1;

assign enable_o = count == TIME_TO_COUNT;

endmodule