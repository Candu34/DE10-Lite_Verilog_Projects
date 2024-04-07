module circle_changer(
input 							clk_i,					//clock signal
input 							rst_ni,					//asynchronus reset
input 							enable_i,				//enable signal
output reg [3 - 1:0] 		row_index_o,			//index of selected 7 seg unit
output reg 						column_index_o			//index of upper or lower part of 7 seg
);


always @(posedge clk_i or negedge rst_ni) 
 if (~rst_ni) begin										//asynchronus reset
	row_index_o <= 'd0;
	column_index_o <= 'd0;
end else 
	if(enable_i) begin
		if(row_index_o == 5 && ~column_index_o) column_index_o <= 'd1; else  			//reach the end of the upper line
			if(row_index_o == 0 && column_index_o) column_index_o <= 'd0; else			//reach the end of the buttom line
				if(~column_index_o) row_index_o <= row_index_o + 1; else						//set the direction for line
					if(column_index_o) row_index_o <= row_index_o - 1;							//set the direction for line
	end

endmodule