;
;	Cameron Moberg
;	CS 250 Section 1
;

.orig x3000
Main	jsr PutMap 
		;jsr Get	

		;ld r5, quit 
		;not r5, r5
		;add r5, r5, #1
		;add r5, r5, r0
		;brz Quit

		;jsr Update
	
		;br Main
EXIT	Halt	

;prints map to the screen, char icon + at X,Y position
PutMap		LD R1, MapRows
			LEA R0, TheMap	
MapLoop		LDI R3, DSR
			BRZP MapLoop	
			LDR R4, R0, #0
			BRz MoveRow
			STI R4, DDR
			ADD R0, R0, #1
			BR mapLoop
MoveRow		jsr NewLine
			ADD R1, R1, #-1
			brz MapExit
			Add R0, R0, #2	
			br MapLoop
MapExit		HALT	



;r0 will hold value read from keyboard
Get	ldi r1, KBSR
	brzp Get
	ldi r0, KBDR
	ret

;updates X and Y position based on the input action
Update  
	ret


;prints new line 
NewLine	ldi r5, DSR
	brzp NewLine
	ld r6, NewChar
	sti r6, DDR
	ret


;program data

SAVE1	.fill x0	;use these (and make more if you need them) save 
SAVE2	.fill x0	;locations for saving the state of the program
SAVE3	.fill x0	;when using subroutines
SAVE4	.fill x0	

DSR	.fill xFE04
DDR	.fill xFE06
KBSR	.fill xFE00
KBDR	.fill xFE02

NewChar	.fill x0A

CharSym	.fill x2B 	; '+' , the symbol representing the char on the map

X	.fill 8  	; X-position of char on map
Y	.fill 18	; Y-position of char on map

UP	.fill x69 	; 'i'
DOWN	.fill x6D 	; 'm'
LEFT	.fill x6A	; 'j'
RIGHT	.fill x6C	; 'l'
QUIT	.fill x71	; 'q'

MapRows	.fill 24  
MapCols .fill 72  

;TheMap		.stringz "┌──────────────────────────────────────────────────────────────────────┐"
;			.stringz "│   |_____[ ]_______|         | |        ___________                   │"                        
;			.stringz "│                             / |       |           |                  │"     
;			.stringz "│                             | |       |           |                  │"   
;j			.stringz "│  ______[  ]__________       / |       |______[ ]__|                  │"
;j			.stringz "│  |                   |                                   ______      │"
;			.stringz "│  |       ____________|                 _____            |      |     │"
;			.stringz "│  |       |                            /     |          _|_     |     │"
;			.stringz "│  |_______|               ___[ ]___    |                        |     │"
;			.stringz "│                          |        |   |     |          ___     |     │"
;		.stringz "│                          |        |   |     /            |     |     │"
;		.stringz "│                          |________|   |    /             |_____|     │"
;		.stringz "│                                       |___/                          │"                           
;		.stringz "│   _____[ ]____                                                       │"
;		.stringz "│   |           |                                                      │"
;		.stringz "│   |           |       ___[ ]___     ____[ ]_____    ___[  ]________  │"
;		.stringz "│   |___________|       |        |    |           |   |              | │"
;		.stringz "│                       |________|    |___________|   |______________| │"
;		.stringz "│                                                                      │"
;		.stringz "│                                                                      │"
;		.stringz "│                                                                      │"
;		.stringz "│                                                                      │"
;		.stringz "│                                                                      │"
;		.stringz "└──────────────────────────────────────────────────────────────────────┘"

TheMap	.stringz "_______________________________________________________________________|"
	.stringz "    |_____[ ]_______|         | |        ___________                   |"                        
	.stringz "                              / |       |           |                  |"     
	.stringz "                              | |       |           |                  |"   
	.stringz "   ______[  ]__________       / |       |______[ ]__|                  |"
	.stringz "   |                   |                                   ______      |"
	.stringz "   |       ____________|                 _____            |      |     |"
	.stringz "   |       |                            /     |          _|_     |     |"
	.stringz "   |_______|               ___[ ]___    |                        |     |"
	.stringz "                           |        |   |     |          ___     |     |"
	.stringz "                           |        |   |     /            |     |     |"
	.stringz "                           |________|   |    /             |_____|     |"
	.stringz "                                        |___/                          |"                           
	.stringz "    _____[ ]____                                                       |"
	.stringz "    |           |                                                      |"
	.stringz "    |           |       ___[ ]___     ____[ ]_____    ___[  ]________  |"
	.stringz "    |___________|       |        |    |           |   |              | |"
	.stringz "                        |________|    |___________|   |______________| |"
	.stringz "                                                                       |"
	.stringz "                                                                       |"
	.stringz "                                                                       |"
	.stringz "                                                                       |"
	.stringz "                                                                       |"
	.stringz "_______________________________________________________________________|"

.end
