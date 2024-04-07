module counter_7seg#(
parameter TIME_TO_STAY 	= 1,
parameter FREQ 			= 1
)(
input 					clk_i		,
input 					rst_ni		,
input 					en_i		,
output wire [7 - 1:0] 	seg7_o
);

localparam integer PERIODS_TO_COUNT = FREQ * TIME_TO_STAY;
wire enable;
reg [4 - 1:0] digit;

counter #(.TIME_TO_COUNT(PERIODS_TO_COUNT))  i_counter(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_o    	(enable 			),
.en_i			(en_i				)
);

digit_changer 		i_digit_changer(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_i    	(enable 			),
.digit			(digit				)
);

digit_to_7seg i_digit_to_7seg(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_i    	(enable 			),
.digit_i		(digit				),
.seg7_o			(seg7_o				)
);




endmodule