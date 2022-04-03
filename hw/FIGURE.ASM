; Programa figura, hw 3

title Figura

.model small
.stack 100h

CR	EQU	13
LF	EQU	10

.data
	fig	DB CR
		DB "		        ____", CR, LF
		DB "                   .---'-    \", CR, LF
		DB "      .-----------/           \", CR, LF
		DB "     /           (         ^  |   __", CR, LF
		DB "&   (             \        O  /  / .'", CR, LF
		DB "'._/(              '-'  (.   (_.' /", CR, LF
		DB "     \                    \     ./", CR, LF
		DB "      |    |       |    |/ '._.'", CR, LF
		DB "       )   @).____\|  @ |", CR, LF
		DB "   .  /    /       (    | mrf", CR, LF
		DB "  \|, '_:::\  . ..  '_:::\ ..\).", CR, LF,'$'
.code
	MAIN PROC
		MOV AX, @data
		MOV DS, AX

		MOV DX, OFFSET fig
		MOV AH, 9
		INT 21H

		MOV AH, 4CH
		INT 21H
	MAIN ENDP
END MAIN