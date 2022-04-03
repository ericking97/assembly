Title Programa 3 (practica.asm) 
; Calculadora con 4 operaciones: Suma, Resta, Multiplicacion y Division
; De dos numeros enternos

; Segmento de MP
.model small  
.stack 100h  

; Constantes
Blanco_azul = 1Fh 
SaludoLoc = 0400h 

; Segmento de datos
.data 

bienvenida 	db "Bienvenida a la calculadora",0dh,0ah,0dh,0ah,0
opciones 	db "Lista de opciones:",0dh,0ah,
		"- Suma: s",0dh,0ah,
		"- Resta: r",0dh,0ah,
		"- Multiplicacion: m",0dh,0ah,
		"- Division: d",0dh,0ah,
		"- Salida: q",0dh,0ah,
		"- Limpiar Pantalla: c",0dh,0ah,0
msg_input	db "Ingresa 2 numeros",0dh,0ah,0
msg_suma 	db "Resultado de suma es: ",0
msg_resta 	db "Resultado de resta es: ",0
msg_mult 	db "Resultado de la multiplicacion es: ",0
msg_div 	db "Resultado de la division es: ",0
msg_despedida 	db "Hasta Luego!",0

; usuario db 50 dup(0) 
; pressAnyKey db 0dh,0ah,0dh,0ah,"Oprime cualquier tecla...",0

.code 
	extrn Clrscr:proc,Crlf:proc,Readint:proc,Writeint:proc,Writestring:proc 				
	
	; Solicita dos numeros y los almacena en bx y cx
	input proc
		mov dx, offset msg_input
		call Writestring

		call Readint 
		mov bx, ax
		call Crlf
		
		call Readint
		mov cx, ax
		call Crlf
		
		ret
	input endp
	
	; Limpia la pantalla
	limpia proc
		call Clrscr
		ret
	limpia endp
	
	; Suma los numeros contenidos en bx y cx
	suma proc
		call input	

		mov dx, offset msg_suma
		call Writestring
			
		add cx, bx
		
		mov bx, 10
		mov ax, cx
		call Writeint
		call Crlf
		ret
	suma endp
	
	; Resta los numeros contenidos en bx y cx
	resta proc
		call input

		mov dx, offset msg_resta
		call Writestring

		sub bx, cx
		
		mov ax, bx
		mov bx, 10
		call Writeint
		call Crlf
		ret
	resta endp

	; Multiplica los numeros contenidos en bx y cx
	mult proc
		call input

		mov dx, offset msg_mult
		call Writestring
		
		mov ax, bx
		mul cx

		mov bx, 10
		call Writeint
		call Crlf
		ret	
	mult endp

	; Divide los numeros contenidos en bx y cx
	division proc
		call input

		mov dx, offset msg_div
		call Writestring
		
		mov dx, 0
		mov ax, bx
		div cx

		mov bx, 10
		call Writeint
		call Crlf
		ret
	division endp
				 
	main proc
		inicio:
			; Volviendo accesible el segmento de datos
			mov ax,@data  
			mov ds,ax 
			
			; Imprime el mensaje de bienvenida
			mov dx, offset bienvenida
			call Writestring
	
			; Imprime la lista de opciones
			mov dx, offset opciones
			call Writestring
		
			; Lectura de seleccion
			mov ah,00h
			int 16h	
			
			cmp al,'s'
			je sumar
			
			cmp al,'r'
			je restar

			cmp al,'m'
			je multiplicar

			cmp al,'d'
			je dividir
				
			cmp al,'q'
			je final		
			
			cmp al,'c'
			je limpiar
			
			jmp inicio
		sumar:
			call suma
			jmp inicio
		restar:
			call resta
			jmp inicio
		multiplicar:
			call mult
			jmp inicio
		dividir:
			call division
			jmp inicio
		limpiar:
			call limpia
			jmp inicio
		final: 
			call Clrscr
			mov dx, offset msg_despedida
			call Writestring
						
			mov ax, 4c00h
			int 21h
	main endp    
end main
