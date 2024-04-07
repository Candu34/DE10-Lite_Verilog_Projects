module negative_front_counter(
input 						clk_i,
input 						rst_ni,
input 						front_i,
output reg [4 - 1:0] 		front_count_o
);

    always @(posedge clk_i or negedge rst_ni) 
        if (~rst_ni) front_count_o <= 'd0; else 
            if (front_count_o == 10) front_count_o <= 'd0; else
				if (front_i) front_count_o <= front_count_o + 1; 


endmodule
