module acceleration_to_7seg_tb;

localparam CLK_PER = 1us;

logic clk, rst_n, ack, enable;
logic [8-1:0] 		rd_data;
logic [48 - 1 : 0] 	seg7;

wire [10-1:0] datax;
wire [10-1:0] datay;

acceleration_to_7seg
acceleration_to_7seg_inst(
	.clk_i		(clk		),
	.rst_ni		(rst_n		),
	.data_i		(rd_data	),
	.enable_i	(enable		),
	.seg7x6_o	(seg7		),
	.datax		(datax		),
	.datay		(datay		)
);




initial begin
    clk = 0;
    forever #(CLK_PER/2) clk = !clk;
end

    
initial begin
    #3us;
    rst_n = 0;
    #3.2us;
    rst_n = 1;
    repeat(2) @(posedge clk);
    @(posedge clk);
	enable <= 'b1;
	rd_data <= 8'b0000_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0000; //data x2
	@(posedge clk);
	rd_data <= 8'b0001_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0001; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000; //data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
    @(posedge clk);
	rd_data <= 8'b0000_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0001; //data x2
	@(posedge clk);
	rd_data <= 8'b0001_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0001; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000;//data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
	@(posedge clk);
	rd_data <= 8'b1100_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data x2
	@(posedge clk);
	rd_data <= 8'b0001_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0001; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000; //data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
	@(posedge clk);
	rd_data <= 8'b0000_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data x2
	@(posedge clk);
	rd_data <= 8'b0001_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000; //data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
	@(posedge clk);
	rd_data <= 8'b0000_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0010; //data x2
	@(posedge clk);
	rd_data <= 8'b1001_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000; //data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
	@(posedge clk);
	rd_data <= 8'b1100_0000; //data x1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data x2
	@(posedge clk);
	rd_data <= 8'b1101_0000; //data y1
	@(posedge clk);
	rd_data <= 8'b0000_0011; //data y2
	@(posedge clk);
	rd_data <= 8'b0010_0000; //data z1
	@(posedge clk);
	rd_data <= 8'b0011_0000; //data z2
    $stop;
end

endmodule
