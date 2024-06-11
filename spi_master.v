module spi_master #(
parameter register_width = 8
)(
input 										clk_i			,		//clock from pll port c0
input 										spi_clk_i	,		//clock from pll out of phase port c1
input 										rstn_i		,		//reset signal
input 										r_w_i			,		//read/write command 1 to read 0 to write
input 										request_i 	,		//command to start data transfer request
input 	reg[6-1:0]						addr_i		,		//address of register in the spi 
input 	reg[register_width-1:0]		data_w		,		//data to write to spi

output	reg								ack_o			,   	//done reading/writing	ack
output 	reg[register_width-1:0]		data_r_o		,		//data read rom spi

// SPI side
input 										miso_i		,		//master in slave out 
output 										mosi_o		,		//master out slave in 
output 	reg								cs_n			,		//chip select to slave
output 										sclk_o		,		//clock signal to slave clk sclk
output 	reg 								spi_oe_o	
);


reg [5-1:0]	counter;			

logic bit_to_transfer;

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) cs_n <= 'd1; else
		if (counter == 16) cs_n <= 'd1; else
			if (request_i) cs_n <= 'd0; else
				cs_n <= 'd1;	

always @(posedge clk_i or negedge rstn_i)
	if(!rstn_i) counter <= 'd0; else
		if (counter == 16) counter <= 'b0; else
			if(request_i) counter <= counter + 1;
			

always @(posedge clk_i or negedge rstn_i)
	if(~rstn_i) bit_to_transfer <= 'b0; else
		if (request_i) begin
			if (counter < 9) begin
				case (counter)
					0:		bit_to_transfer <= r_w_i;
					1: 	bit_to_transfer <= 0;
					default: 
						bit_to_transfer <= addr_i[(7-counter)];
				endcase
			end 
				else if (counter > 8 && ~r_w_i) begin
					bit_to_transfer <= data_w[16 - counter];
			end
		end

always @(posedge clk_i or negedge rstn_i)
	if(~rstn_i) data_r_o <= 'b0000_0000; else
		if (request_i) begin
			if(r_w_i) begin
				if (counter > 8) begin
					data_r_o[16 - counter] <= miso_i;
				end
			end
		end
		
always @(posedge clk_i or negedge rstn_i)	
	if(~rstn_i) ack_o <= 'b0; else
		if (counter == 16) ack_o <= 'b1; else
			ack_o <= 'b0;


assign sclk_o = cs_n | spi_clk_i;
assign mosi_o = bit_to_transfer;
assign spi_oe_o = ~cs_n & (~r_w_i | counter < 9  );

endmodule 