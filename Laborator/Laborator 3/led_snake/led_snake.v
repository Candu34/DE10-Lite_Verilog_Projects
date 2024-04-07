module led_snake#(
parameter TIME_TO_STAY 	= 1,
parameter FREQ 			= 1,
parameter NO_LEDS		= 8
)(
input 		clk_i		,
input 		rst_ni		,
input 		en_i		,
output wire [NO_LEDS - 1:0] led_array_o
);

localparam integer PERIODS_TO_COUNT = FREQ * TIME_TO_STAY;
wire enable;

counter #(.TIME_TO_COUNT(PERIODS_TO_COUNT))  i_counter(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_o    	(enable 			),
.en_i			(en_i				)
);

led_changer #(.NO_LEDS(NO_LEDS))  i_led_changer(
.clk_i    		(clk_i  			),
.rst_ni   		(rst_ni 			),
.enable_i    	(enable 			),
.led_array_o	(led_array_o		)
);


endmodule