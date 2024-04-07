`timescale 1ns/1ns

module testbench;

reg  				clk           		; //clock
reg  				rstn          		; //asynchronous reset, active low
localparam 			TIME_TO_STAY = 3	;
localparam 			FREQ = 1			;
wire [8-1:0] 		seg7   				; //output 
wire enable = 1;
//generating clock


initial begin
	clk <= 1'b0;
forever
	#5 clk <= ~clk;
end

initial begin

//generating reset
rstn <= 1'b1;
repeat(2)@(posedge clk);
rstn <= 1'b0;
@(posedge clk);
rstn <= 1'b1;
repeat(200)@(posedge clk);
$stop;

end

counter_7seg #(.TIME_TO_STAY(TIME_TO_STAY), .FREQ(FREQ))  i_counter_7seg(
.clk_i    			(clk  			),
.rst_ni   			(rstn 			),
.en_i				(enable			),
.seg7_o    			(seg7 			)
);
endmodule //testbench