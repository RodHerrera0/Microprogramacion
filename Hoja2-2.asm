.model small
.data 
	;variables 
	X DB 34H		;X = 4
	Y DB 32h		;Y = 2
	Z DB 31H		;Z = 1
	
	espacio DB 20h	;espacio
	linejmp DB 0AH	;salto de linea
.stack ; puede tener un tamaño
.code
programa:
	;inicializar
	MOV AX, @data	;toma direccion de segmento de datos
	MOV DS, AX		;inicializa donde empieza en memoria el segmento de datos
	
	;Variables que ya estan con valor asignado
	;mostrar los numeros
	MOV DL, X
	MOV AH, 2H
	INT 21H
	
	MOV DL, espacio
	MOV AH, 2H
	INT 21H
	
	MOV DL, Y
	MOV AH, 2H
	INT 21H
	
	MOV DL, espacio
	MOV AH, 2H
	INT 21H

	MOV DL, Z
	MOV AH, 2H
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;Para leer desde teclado
	MOV AH, 1
	INT 21H
	MOV X, AL
	INT 21H
	MOV Y, AL
	INT 21H
	MOV Z, AL
	
	SUB X, 30H
	SUB Y, 30H
	SUB Z, 30H

	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;SUMA X + Y
	;guardar resultado en AL
	XOR AX, AX
	MOV	AL, X	;asignamos para empezar a operar
	ADD AL, Y	;"resultado" puesto en AL 
	ADD AL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;RESTAMOS X - Z
	XOR AX, AX
	MOV AL, X
	SUB AL, Z
	ADD AL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;MULTIPLICAMOS X * Y
	XOR AX, AX
	MOV AL, X
	MOV BL, Y
	MUL BL
	ADD AL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H

	;DIVIDIMOS X / Y
	XOR AX, AX
	MOV AL, X
	MOV BL, Y
	XOR AH, AH
	DIV BL
	ADD AL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
		
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	;X%Y
	
    MOV AL, X  
    MOV BL, Y
    XOR AH, AH    ; Limpia AH para la división
    DIV BL        ; Divide AL entre BL (resultado en AL y residuo en AH)

    ADD AH, 30h   ; Convertir el cociente a ASCII antes de imprimir (AL MUESTRA COCIENTE, AH MUESTRA RESIDUO)

    ; Mostrar resultado
    MOV DL, AH
    MOV AH, 2H
    INT 21H
	
		
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;X*Y-Z
	MOV AL, X
	MOV BL, Y
	MUL BL
	SUB AL, Z
	ADD AL, 30H

	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
		
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;Z-X*Y
	MOV AL, X
	MOV BL, Y
	MUL BL
	MOV CL, Z
	SUB CL, AL
	ADD CL, 30H

	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, CL		;imprimir el resultado 
	INT 21H
	
		
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;X+Z/Y
	XOR AX, AX
	MOV AL, Z  
    MOV BL, Y
    DIV BL        ; Divide AL entre BL (resultado en AL)
	ADD AL, X
	ADD AL, 30H
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;Z^2
	MOV AL, Z
	MOV BL, Z
	MUL BL
	ADD AL, 30H
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
		
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	;Y+Z/X
	MOV AL, Z  
    MOV BL, X
    XOR AH, AH    ; Limpia AH para la división
    DIV BL        ; Divide AL entre BL (resultado en AL)
	ADD AL, Y
	ADD AL, 30H

	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	MOV DL, linejmp
	MOV AH, 2H
	INT 21H
	
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa