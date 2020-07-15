module _16_bit_reg (
	input[7:0] _8_bit_in,			//8 bit input
	input clk, 
	input rst, 
	input set_high, 
	input set_low,	//set high and set low decide which half of the 16 bit register would hold the 8 bit input
	output reg[15:0] out			
);

	always @ (posedge clk)
	begin
		if (rst) out <= 16'd0;		//reset the register if rst == 1

		else if (set_high) begin	//upper half of the register stores the input
			out[15:8] <= _8_bit_in;
			out[7:0] <= out[7:0];	//lower half is unchanged
		end
		
		else if (set_low) begin		//lower half of the register stores the input
			out[7:0] <= _8_bit_in;
			out[15:8] <= out[15:8];	//upper half is unchanged
		end
	end
endmodule
