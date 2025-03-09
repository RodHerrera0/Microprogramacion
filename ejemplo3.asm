.model small
.data 
	;variables 
	NUM1 DB ?
	NUM2 DB ?
	
	espacio DB 20h	;espacio
	linejmp DB 0AH	;salto de linea

.stack ; puede tener un tamaño
.code
programa:
	;inicializar
	MOV AX, @data	;toma direccion de segmento de datos
	MOV DS, AX		;inicializa donde empieza en memoria el segmento de datos
	
	;ingreso de variable (DECENA DEL PRIMER NUMERO)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	SUB AL, 30H
	;multimplicar por 10 para el valor de la decena
	MOV BL, 0AH
	MUL BL
	MOV BL, AL
	
	;ingreso del variable (UNIDAD DEL PRIMER DIGITO)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H	
	SUB AL, 30H
	
	
	;unimos los valores
	;QUEDA GUARDADO EL NUMERO COMPLETO INGRESADO POR EL USUARIO
	ADD AL, BL
	
	MOV NUM1, AL
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, NUM1		;imprimir el resultado  
	INT 21H
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	
	;ingreso de variable (DECENA DEL PRIMER NUMERO)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	SUB AL, 30H
	;multimplicar por 10 para el valor de la decena
	MOV BL, 0AH
	MUL BL
	MOV BL, AL
	
	;ingreso del variable (UNIDAD DEL PRIMER DIGITO)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H	
	SUB AL, 30H
	
	
	;unimos los valores
	;QUEDA GUARDADO EL NUMERO COMPLETO INGRESADO POR EL USUARIO
	ADD AL, BL
	
	MOV NUM2, AL
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, NUM2		;imprimir el resultado  
	INT 21H
	
	mov DL, linejmp
	MOV AH, 2h
	int 21h
	
	;SUMAR NUM1 + NUM2
	MOV AL, NUM1
	ADD AL, NUM2	;el resultado de la suma queda el AL
	;IMPRIMIR EL RESULTADO
	;DIVIDIMOS DENTRO DE 10 PARA ENCONTRAR PRIEMRO LAS DECENAS
	MOV CL, 0AH	;asignamos el valor de 10 (0AH) para dividir 
	XOR AH, AH	;limpiar AH dado que se utilizo y quedo valor en el registro 
	DIV CL
	MOV CL, AH
	ADD AL, 30H
	ADD CL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado
	INT 21H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, CL		;imprimir el resultado
	INT 21H
	
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa