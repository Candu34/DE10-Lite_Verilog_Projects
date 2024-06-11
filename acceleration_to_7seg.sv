module acceleration_to_7seg(
	input 					clk_i			,
	input 					rst_ni		,
	input [8-1:0]			data_i		,
	input 					enable_i		,
	output reg				row_index	,
	output reg[4-1:0]		column_index
);

logic  [10-1:0] datax;
logic  [10-1:0] datay;
logic  [10-1:0] dataz;
logic datax_ready;
logic datay_ready;
logic dataz_ready;
	
localparam DATA_INPUT_COUNT = 5;
logic [$clog2(DATA_INPUT_COUNT):0] cnt;


always @ (posedge clk_i or negedge rst_ni)
	if (!rst_ni) cnt <= 'b0; else
		if (cnt == DATA_INPUT_COUNT) cnt <= 'b0; else
			if (enable_i) cnt <= cnt + 1;
			
always @ (posedge clk_i or negedge rst_ni)
	if (!rst_ni) datax <= 10'b0; else
	if (enable_i) begin
		if (cnt == 0) datax[8-1:0] <=  data_i; else 
		if (cnt == 1) datax[10-1:8] <= data_i[2-1:0];
	end

always @ (posedge clk_i or negedge rst_ni)
	if (!rst_ni) datay <= 10'b0; else
	if (enable_i) begin
		if (cnt == 2) datay[8-1:0] <=  data_i; else
		if (cnt == 3) datay[10-1:8] <= data_i[2-1:0];
		end

always @ (posedge clk_i or negedge rst_ni)
	if (!rst_ni) dataz <= 10'b0; else
	if (enable_i) begin
		if (cnt == 4) dataz[8-1:0] <=  data_i; else
		if (cnt == 5) dataz[10-1:8] <= data_i;	
		end

always @(posedge clk_i or negedge rst_ni)
	if (!rst_ni) row_index <= 1'b0; else
		if (datay_ready) row_index <= datay[10-1];
		
always @(posedge clk_i or negedge rst_ni)
		if (!rst_ni) column_index <= 3'b000; else
			if(datax_ready) begin
				if((datax[10-1 : 6] + 3) < 0) column_index <= 3'b000; else
					if ((datax[10-1 : 6] + 3) > 5) column_index <= 'd5; else
						column_index <= datax[10-1:6] + 3;
			end
		

assign datax_ready = cnt == 3;
assign datay_ready = cnt == 5;



endmodule