.model small
.data 
	;variables 
	num1 DB ?
	num2 DB ?
	num3 DB ?
	
	espacio DB 20h
	linejmp DB 0ah
	
.stack ; puede tener un tamaño
.code
programa:
	;inicializar
	MOV AX, @data	;toma direccion de segmento de datos
	MOV DS, AX		;inicializa donde empieza en memoria el segmento de datos
	
	;ingreso de variable num1
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;convertir al valor real
	SUB AL, 30H
	;Guardarlo en la variable
	MOV num1, AL
	
	mov DL, espacio
	MOV AH, 2h
	int 21h 
	mov DL, linejmp
	MOV AH, 2h
	int 21h 
	
	;ingreso de variable num2
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;convertir al valor real
	SUB AL, 30H
	;Guardarlo en la variable
	MOV num2, AL
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	mov DL, linejmp
	MOV AH, 2h
	int 21h 
	
	;Ingreso de variable num3
	;Leer desde el teclado un caracter
	MOV AH, 01H
	INT 21H
	;convertir al valor real
	SUB AL, 48d
	;guardarlo en la variable
	MOV num3, AL
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	mov DL, linejmp
	MOV AH, 2h
	int 21h 
	
	;Sumar ambos numeros num1 + num2
	;guardar resultado en AL
	XOR AX, AX
	MOV	AL, num1	;asignamos para empezar a operar
	ADD AL, num2	;"resultado" puesto en AL
	ADD AL, 30h		;convertimos resultado a numero binario
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado 
	INT 21H
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	mov DL, linejmp
	MOV AH, 2h
	int 21h 	
	
	;sumar num1 - num3
	;guardar el resultado en num3
	XOR AX, AX
	MOV	AL, num1	;asignamos para empezar a operar
	SUB AL, num3	;quitamos a AL (num1) el valor de num3
	ADD AL, 30h		;convertimos resultado a numero binario
	
	;impresion de resultado
	MOV AH, 02h
	MOV DL, AL
	INT 21h
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	mov DL, linejmp
	MOV AH, 2h
	int 21h 
	
	;sumar los 3 numeros
	XOR AX, AX
	MOV AL, num1	;asignamos para empezar a operar
	ADD	AL, num2	;Añadimos a AL (num1) el valor de num3 
	ADD AL, num3 	;Añadimos luego a AL (num1+num2) el valor de num3
	ADD AL, 30h
	
	;impresion de resultado
	MOV AH, 02h
	MOV DL, AL
	INT 21h	
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	mov DL, linejmp
	MOV AH, 2h
	int 21h 
	
	;num1 + 2*num2 + num3 (al no poder multiplicar se estara sumando de forma repetida num2)
	XOR AX, AX
	MOV AL, num1
	ADD AL, num2
	ADD AL, num2
	Add AL, num3
	ADD AL, 30h
	
	;impresion de resultado
	MOV AH, 02h
	MOV DL, AL
	INT 21h	
	
	
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa