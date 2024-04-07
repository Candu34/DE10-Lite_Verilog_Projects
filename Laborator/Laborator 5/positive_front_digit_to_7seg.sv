module positive_front_digit_to_7seg(
input 								clk_i,
input 								rst_ni,
input 	reg 	[4 - 1:0] 		digit_i,
output 	reg	[8 - 1:0] 		seg7_o
);

always @(posedge clk_i or negedge rst_ni) begin
	case (digit_i)
		4'b0000: seg7_o <= ~8'b0011_1111; 	//0
		4'b0001: seg7_o <= ~8'b0000_0110; 	//1
		4'b0010: seg7_o <= ~8'b0101_1011; 	//2
		4'b0011: seg7_o <= ~8'b0100_1111; 	//3
		4'b0100: seg7_o <= ~8'b0110_0110; 	//4
		4'b0101: seg7_o <= ~8'b0110_1101; 	//5
		4'b0110: seg7_o <= ~8'b1111_1101; 	//6
		4'b0111: seg7_o <= ~8'b0000_0111; 	//7
		4'b1000: seg7_o <= ~8'b0111_1111; 	//8
		4'b1001: seg7_o <= ~8'b0110_1111; 	//9
	endcase
end



endmodule