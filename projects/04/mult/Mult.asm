// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// initialize R2 to 0
@0
D = A
@R2
M = D

// if operand 1 == 0, jump to end
@R0
D = M
@END
D;JEQ

// if operand 2 == 0, jump to end
@R1
D = M
@END
D;JEQ

@operand1Mask
M = 1

(OPERAND_1_LOOP)
	@R0
	D = M
	@operand1Mask
	D = D & M
	@INCREMENT_OPERAND_1
	D;JEQ

	@operand2Mask
	M = 1
	@operand1Mask
	D = M
	@stepResult
	M = D

	(OPERAND_2_LOOP)
		@R1
		D = M
		@operand2Mask
		D = D & M
		@INCREMENT_OPERAND_2
		D;JEQ

		// if we've reached here, both R0 & operand1Mask and R1 & operand2Mask are 1
		@stepResult
		D = M
		@R2
		M = M + D

		(INCREMENT_OPERAND_2)
			@operand2Mask
			D = M
			D = D + M
			M = D

			// if all remaining bits are 0, skip them
			@R1
			D = M - D
			@INCREMENT_OPERAND_1
			D;JLT

			@stepResult
			D = M
			D = D + M
			M = D
			// loop (OPERAND_2_LOOP) while operand2Mask <= 2^14
			@operand2Mask
			D = M
			@16384 // 2^14
			D = D - A
			@OPERAND_2_LOOP
			D;JLT

	(INCREMENT_OPERAND_1)
		@operand1Mask
		D = M
		D = D + M
		M = D
		// loop (OPERAND_1_LOOP) while operand1Mask <= 2^14
		@operand1Mask
		D = M
		@16384 // 2^14
		D = D - A
		@OPERAND_1_LOOP
		D;JLT

(END)
	@END
	0;JMP
