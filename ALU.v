module ALU(
	//ALU performs arithmetic and logical operations on 8-bit operands
	input reset,
	input[7:0] operand_1,
	input[7:0] operand_2,
	input[4:0] opcode,
	output reg[15:0] out,	//16 bit result output
	output reg[4:0] flag_reg	//5 flags indicating sign, zero, aux carry, parity, carry
	);

	always @ (*)	//ALU is a combinational unit
	begin
		case(opcode)
		ADD: begin
			out[8:0] = operand1 + operand2;	//9 bit result
			flag_reg[CARRY] = out[8];	//9th bit would indicate carry if any
			flag_reg[SIGN] = out[7];
			flag_reg[ZERO] = (out[8:0]==9'd0)?1:0;
			flag_reg[PARITY] = ^out[8:0];	//bitwise xor to indicate parity
		end

		SUBTRACT: begin
			out[8:0] = operand1 - operand2;
			 flag_reg[CARRY] = out[8];       //9th bit would indicate carry if any
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[8:0]==9'd0)?1:0;
                        flag_reg[PARITY] = ^out[8:0];   //bitwise xor to indicate parity
		end

		MULTIPLY: begin
			out[15:0] = operand1 * operand2; //16 bit result
			flag_reg[CARRY] = 1'b0;
			flag_reg[SIGN] = out[15];
			flag_reg[ZERO] = (out[15:0]==16'd0)?1:0;
			flag_reg[PARITY] = ^out;
		end

		AND: begin
			out[7:0] = operand1 & operand2;	//8 bit result, bitwise and
			flag_reg[CARRY] = 1'b0;    
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
		end

		OR: begin
			out[7:0] = operand1 | operand2; //8 bit result, bitwise or
                        flag_reg[CARRY] = 1'b0;
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

		RIGHT_SHIFT: begin
			out[7:0] = operand1 >> 1;
			flag_reg[CARRY] = operand1[0]; //carry indicates the LSB which is shifted out during right shift
			flag_reg[SIGN] = out[7];	//always 0 in this case
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

		LEFT_SHIFT: begin
			out[7:0] = operand1 << 1;
                        flag_reg[CARRY] = operand1[7]; //carry indicates the MSB which is shifted out during left shift
                        flag_reg[SIGN] = out[7];       
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

		ARITH_RIGHT_SHIFT: begin
			out[7:0] = operand1 >>> 1;
                        flag_reg[CARRY] = operand1[0]; //carry indicates the LSB which is shifted out during right shift
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

                ARITH_LEFT_SHIFT: begin
                        out[7:0] = operand1 <<< 1;
                        flag_reg[CARRY] = operand1[7]; //carry indicates the MSB which is shifted out during left shift
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
		end

		COMPLEMENT: begin
			out[7:0] = ~operand1;
			flag_reg[CARRY] = 1'b0;
			flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

		TWOS_COMPLEMENT: begin
			out[7:0] = (~operand1) + 1'b1;
                        flag_reg[CARRY] = 1'b0;
                        flag_reg[SIGN] = out[7];
                        flag_reg[ZERO] = (out[7:0]==8'd0)?1:0;
                        flag_reg[PARITY] = ^out[7:0];   //bitwise xor to indicate parity
                end

		default: begin
			out[15:0] = 16'd0;
			flags_reg[CARRY] = 1'b0;
			flags_reg[SIGN] = 1'b0;
			flags_reg[ZERO] = 1'b0;
			flags_reg[PARITY] = 1'b0;
		end
	endcase
	end
endmodule





