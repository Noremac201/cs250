;
;	Cameron Moberg
;	CS 250 Section 1
;

.orig x3000
Main	jsr PutMap 
		jsr Get	

		ld r5, quit 
		not r5, r5
		add r5, r5, #1
		add r5, r5, r0
		brz EXIT 
		jsr Updatexy
		jsr Update
	
		br Main
EXIT	Halt	

;prints map to the screen, char icon + at X,Y position
PutMap		LD R1, MapCols
			LD R2, MapRows
			LEA R0, TheMap	
			STI R7, Save1
MapLoop		jsr put
			ADD R0, R0, R1
			ADD R0, R0, #1 ;R0 + 73
MoveRow		jsr NewLine
			ADD R2, R2, #-1
			BRz MapExit
			BR mapLoop
MapExit		LDI R7, Save1	
			ret

Put STI R0, SAVE2
PutL LDI R3, DSR
	BRZP PUTl
	LDR R4, R0, #0
	BRZ ENDPUT
	STI R4, DDR
	ADD R0, R0, #1
	Br putl
endput LDI R0, Save2
	ret

;prints map to the screen, char icon + at X,Y position
;PutMap		LD R1, MapRows
;   		LEA R0, TheMap	
;   		STI R7, Save1
;MapLoop		LDI R3, DSR
;   		BRZP MapLoop	
;   		LDR R4, R0, #0
;   		BRz MoveRow
;   		STI R4, DDR
;   		ADD R0, R0, #1
;   		BR mapLoop
;MoveRow		jsr NewLine
;   		ADD R1, R1, #-1
;   		brz MapExit
;   		Add R0, R0, #1	
;   		br MapLoop
;MapExit		LDI R7, Save1	
;   		ret



;r0 will hold value read from keyboard
Get	ldi r1, KBSR
	brzp Get
	ldi r0, KBDR
	ret

;updates x and y
UpdateXY LD R3, X
		 LD R4, Y

		 LD R2, UP 
		 Not R2, R2
		 ADD R2, R2, #1
		 ADD R2, R0, R2
		 BRz incY

		 LD R2, Down  
		 Not R2, R2
		 ADD R2, R2, #1
		 ADD R2, R0, R2
		 BRz decY

		 LD R2, Right  
		 Not R2, R2
		 ADD R2, R2, #1
		 ADD R2, R0, R2
		 BRz incX

		 LD R2, Left  
		 Not R2, R2
		 ADD R2, R2, #1
		 ADD R2, R0, R2
		 BRz decX
		 br endupdatexy     ;returns if none match
incX  ADD R3, R3, #1    
	  ST R3, X
		br endupdatexy     ;returns if none match
	
decX  ADD R3, R3, #-1
	  ST R3, X
		br endupdatexy     
incY  ADD R4, R4, #-1 ;higher the y, lower it is
	  ST R4, Y
		br endupdatexy    
decY  ADD R4, R4, #1  
	  ST R4, Y
		br endupdatexy     ;returns if none match
endupdatexy ret

;updates X and Y position based on the input action
Update 	LEA R0, TheMap   
		LEA R6, CurrentLoc
		LDI R5, CurrentChar
		STR R5, R6, #0
		
	   	LD R1, X
	   	LD R2, Y
		ADD R2, R2, #0
		BRz AddX
		LD R3, MapCols
YLoop	ADD R0, R0, R3	
		ADD R0, R0, #1
		ADD R2, R2, #-1
		brp Yloop
Addx	ADD R0, R1, R0   ;x coord
		
		LDR R5, R0, #0	
		LDR R4, R0, #0
		STR R0, R4, #0   ;saves char and location
		STI R5, CurrentChar

	   	LD R6, CharSym
		STR R6, R0, #0   ;stores + at the location
		
	ret


;prints new line 
NewLine	ldi r5, DSR
	brzp NewLine
	ld r6, NewChar
	sti r6, DDR
	ret


;program data

SAVE1	.fill x4000	;use these (and make more if you need them) save 
SAVE2	.fill x4001	;locations for saving the state of the program
SAVE3	.fill x0	;when using subroutines
SAVE4	.fill x0	
CurrentLoc .fill x4002
CurrentChar .fill x4003

DSR	.fill xFE04
DDR	.fill xFE06
KBSR	.fill xFE00
KBDR	.fill xFE02

NewChar	.fill x0A

CharSym	.fill x2B 	; '+' , the symbol representing the char on the map

X	.fill 15 	; X-position of char on map
Y	.fill 10 	; Y-position of char on map

UP	.fill x77 	; 'w'
DOWN	.fill x73 	; 's'
LEFT	.fill x61	; 'a'
RIGHT	.fill x64	; 'd'

QUIT	.fill x71	; 'q'

MapRows	.fill 24  
MapCols .fill 72  


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
