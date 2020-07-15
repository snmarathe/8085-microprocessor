module program_counter (
	input clk, rst, 
	input increment, 	//increments program counter contents by 1
	input set, 		//set is the enable for loading new value into the program counter
	input[15:0] addr,		//address of the next instruction
	output reg[15:0] addr_out	//output of program counter
);

	always @ (posedge clk)
	begin
		if (rst) addr_out <= 16'd0;	//resets addr_out if rst == 1

		else if (set) addr_out <= addr;	//if set is high, new value is loaded

		else if (increment) addr_out <= addr_out + 1'b1;	//if increment is high, addr_out is incremented

		else addr_out <= addr_out;
	end
endmodule
