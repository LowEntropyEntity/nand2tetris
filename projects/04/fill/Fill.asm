// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(RESET_SCREEN_POSITION)
@SCREEN
D = A
@screenPosition
M = D

(LOOP)
	@KBD
	D = M
	@SET_BLACK
	D;JGT

	@0
	D = A
	@color
	M = D
	@COLOR
	0;JMP

	(SET_BLACK)
	@0
	D = !A
	@color
	M = D

	(COLOR)
	@color
	D = M
	@screenPosition
	A = M // move the the address pointed at by screenPosition
	M = D // set the address to the right color

	@screenPosition
	M = M + 1
	D = M
	@8192 // words in screen (256 rows x 512 columns / 16 bits per word)
	D = D - A
	@SCREEN
	D = D - A
	@RESET_SCREEN_POSITION
	D;JGE

	@LOOP
	0;JMP