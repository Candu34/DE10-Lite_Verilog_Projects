module runing_circle#(
parameter TIME_TO_STAY 	= 1,
parameter FREQ 			= 1
)(
input 						clk_i		,		//clock
input 						rst_ni	,		//asyncronus reset
input 						en_i		,		//enable signal
output wire [48 - 1:0] 	seg7_o			//6x7seg led
	);

localparam integer PERIODS_TO_COUNT = FREQ * TIME_TO_STAY;
wire enable;										//send enable signal from counter to circle_changer
reg [3 - 1:0] row_index;						//led index
reg  column_index;								//upper or bottom circle selecter

counter #(.TIME_TO_COUNT(PERIODS_TO_COUNT))  i_counter(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_o    	(enable 			),
.en_i				(en_i				)
);

circle_changer i_circle_changer(
.clk_i    			(clk_i  				),
.rst_ni   			(rst_ni 				),
.enable_i    		(enable 				),
.row_index_o		(row_index			),
.column_index_o	(column_index		)
);

index_to_circle i_index_to_circle(
.clk_i    			(clk_i  				),
.rst_ni   			(rst_ni 				),
.row_index_i		(row_index			),
.column_index_i	(column_index		),
.seg7_o				(seg7_o				)
);




endmodule