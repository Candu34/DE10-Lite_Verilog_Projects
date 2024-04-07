module press_relax_botton_counter(
input 						clk_i					,
input 						rst_ni				,
input 						button_i				,
output wire [7 - 1:0] 	positive_seg7_o	,
output wire [7 - 1:0] 	negative_seg7_o
);

wire pressed;
wire relaxed;
wire [4 - 1:0] pressed_digit;
wire [4 - 1:0] relaxed_digit;

front_detector i_front_detector(
.clk_i    				(clk_i  			),
.rst_ni   				(rst_ni 			),
.button_input   		(button_i 		),
.possitive_front_o	(pressed			),
.negative_front_o		(relaxed			)
);

positive_front_counter 	i_positive_front_counter(
.clk_i    			(clk_i  				),
.rst_ni   			(rst_ni 				),
.front_i    		(pressed 			),
.front_count_o		(pressed_digit		)
);

negative_front_counter 	i_negative_front_counter(
.clk_i    			(clk_i  				),
.rst_ni   			(rst_ni 				),
.front_i    		(relaxed 			),
.front_count_o		(relaxed_digit		)
);

positive_front_digit_to_7seg i_positive_front_digit_to_7seg(
.clk_i    		(clk_i  				),
.rst_ni   		(rst_ni 				),
.digit_i			(pressed_digit		),
.seg7_o			(positive_seg7_o	)
);

negative_front_digit_to_7seg i_negative_front_digit_to_7seg(
.clk_i    		(clk_i  				),
.rst_ni   		(rst_ni 				),
.digit_i			(relaxed_digit		),
.seg7_o			(negative_seg7_o	)
);



endmodule