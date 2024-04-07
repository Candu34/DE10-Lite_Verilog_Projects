module digit_changer(
input 						clk_i,
input 						rst_ni,
input 						enable_i,
output reg [4 - 1:0] 		digit
);


    always @(posedge clk_i or negedge rst_ni) 
        if (~rst_ni) digit <= 'd0; else 
            if (digit == 10) digit <= 'd0; else
				if (enable_i) digit <= digit + 1; 

endmodule