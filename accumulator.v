module accumulator (
	input clk, rst,
	input set, 	//set determines whether accumulator contents are sent to the data bus
	input[7:0] alu_out,	//alu output is sent to accumulator for storage
	output reg[7:0] out
);
	reg[7:0] alu_result;	
//	assign alu_result = alu_out;
	
	always @ (posedge clk)
		if(rst) out = 8'd0;

	always @ (*) begin
		alu_result = alu_out;

		if(set) out <= alu_result;
		else out <= 8'hzz;
	end
endmodule
