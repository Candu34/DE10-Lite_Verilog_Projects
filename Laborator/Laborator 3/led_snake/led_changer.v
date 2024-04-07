module led_changer#(
	parameter NO_LEDS = 8
)(
input 						clk_i,
input 						rst_ni,
input 						enable_i,
output reg [NO_LEDS - 1:0] 	led_array_o
);

reg [NO_LEDS - 1:0] index;
reg order;


    always @(posedge clk_i or negedge rst_ni) 
        if (~rst_ni) begin
            index <= 'd0;
            order <= 1;
        end
        else begin
            if (index == NO_LEDS - 1) 
                order <= 0; 
            else if (index == 0) 
                order <= 1; 
                
            if (enable_i && order) 
                index <= index + 1; 
            else if (enable_i && ~order) 
                index <= index - 1;
        end

always @(posedge clk_i or negedge rst_ni)
	if(~rst_ni) led_array_o <= 'b0; else 
			led_array_o			<= 1 << index;
		


endmodule