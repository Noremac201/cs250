;R0 - string to be put
;R1 - Temporary Variable
;R6 - Location of Guessed String
.orig x3000

	jsr Length 
Main jsr Output
	LEA R0, CharAsk
	jsr Put
	jsr Get
	jsr NewLine
	jsr Check
	jsr	CheckWin 
	br Main

Output LEA R0, Prompt
	LEA R6, GuessedWord
	STI R7, JSRStorage 
	jsr Put
	AND R0, R0, #0
	ADD R0, R6, #0
	jsr Put
	jsr NewLine
	LDI R7, JSRStorage
	ret

Check AND R2, R2, #0 ;Counting Variable
	LEA R6, WordToGuess
CheckLoop	LDR R3, R6, #0	 
	BRz EndCheck 
	AND R1, R1, #0
	ADD R1, R0, #0
	NOT R1, R1
	ADD R1, R1, #1
	ADD R1, R3, R1
	BRnp NotMatch 
	LEA R4, GuessedWord ;if it does match
	ADD R4, R2, R4 
	STR R0,R4,#0
	STI R0,GuessedWord
	LDI R5, CorrectStorage
	ADD R5, R5, #1 
	STI R5,CorrectStorage
NotMatch ADD R2, R2, #1 ;increment counter 
	ADD R6, R6, #1
	BRnzp CheckLoop
EndCheck	ret

;R0 holds ADDress of string to be Put
Put	ldi r1, DSR
	brzp Put
	ldr r2, r0, #0	;load string element into R2	
	brz EndPut  	;if string is done, return
	sti r2, DDR
	ADD r0, r0, #1
	br Put
EndPut	ret	


;R0 will hold value read from keyboard
Get	ldi r1, KBSR
	brzp Get
	ldi r0, KBDR
	sti r0, DDR
	ret

;prints new line 
NewLine	ldi r5, DSR
	brzp NewLine
	ld r6, NewChar
	sti r6, DDR
	ret


LENGTH 	AND R3, R3, #0
		LEA R0, WordToGuess
LLoop 	LDR R1, R0, #0		
		BRZ endLength
		ADD R3, R3, #1 ;increment string length counter
		ADD R0, R0, #1 ;iterate thru string.
		BR LLoop
ENDLength STI R3, GuessedStorage
		ret

CheckWin	LDI R5, CorrectStorage
	LDI R4, GuessedStorage
	NOT R4, R4
	ADD R4, R4, #1
	ADD R5, R4, R5
	brnp notwin
Win	LEA R0, Prompt
	jsr Put
	LEA R0, GuessedWord
	jsr Put
	jsr NewLine	
	LEA R0, WinStr
	jsr Put
	HALT
notwin ret
	


;program data
	
WordToGuess .stringz "queue"
GuessedWord .stringz "_____"
CorrectStorage .fill x4000
GuessedStorage .fill x4001
JSRStorage .fill x4002
Prompt .stringz "Word = "
CharAsk	.stringz "Enter>"
WinStr	.stringz "You win!"

DSR	.fill xFE04
DDR	.fill xFE06
KBSR	.fill xFE00
KBDR	.fill xFE02
NewChar .fill x0A
.end
