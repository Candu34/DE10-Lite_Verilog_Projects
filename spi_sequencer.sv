module spi_sequencer(
	input              				clk_i      		,
	input              				rst_ni     		,
	output             				req_o      		,
	output  reg           			rw_no      		,
	output  reg          [5:0] 	addr_o     		,
	output  reg          [7:0] 	wr_data_o  		,
	input 	          				ack_i  	  		,
	output 								read_enable_o

);

localparam	DATA_FORMAT		= 6'h31;
localparam 	POWER_CTL 		= 6'h2D;
localparam	DATA_X0 			= 6'h32;
localparam	DATA_X1 			= 6'h33;
localparam	DATA_Y0			= 6'h34;
localparam	DATA_Y1			= 6'h35;
localparam	DATA_Z0 			= 6'h36;
localparam	DATA_Z1 			= 6'h37;


reg [4-1:0] counter;

always @(posedge clk_i or negedge rst_ni) 
    if (~rst_ni)counter <= 'd0;else
	 if (ack_i) begin
        if (counter == 5) counter <= 2; else
            counter <= counter + 1;
    end

		
always @(posedge clk_i or negedge rst_ni)
	if (~rst_ni) rw_no <= 'b0; else
		if (counter < 2) rw_no <= 'b0; else	
			rw_no <= 'b1;
			
			
always @(posedge clk_i or negedge rst_ni)
	if (~rst_ni) addr_o <= DATA_FORMAT; else 
	begin 
		case(counter)
			3'd0: addr_o <= 6'h31;
			3'd1: addr_o <= 6'h2D;
			3'd2: addr_o <= 6'h32;
			3'd3: addr_o <= 6'h33;
			3'd4: addr_o <= 6'h34;
			3'd5: addr_o <= 6'h35;
			3'd6: addr_o <= 6'h36;
			3'd7: addr_o <= 6'h37;
		endcase
	end
	
always @(posedge clk_i or negedge rst_ni)
	if (~rst_ni) wr_data_o <= 8'b0_1_0_0_0_0_00; else
		if (counter == 0) wr_data_o <= 8'b0_1_0_0_0_1_00; else
			if (counter == 1) wr_data_o <= {2'b00, 1'b0, 1'b0, 1'b1, 1'b0, 2'b00}; else
				wr_data_o <= 8'hxx;
				
				
assign read_enable_o = rw_no & ack_i;
assign req_o = 'b1;	
		
endmodule
