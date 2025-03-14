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
	MOV NUM1, AL
	
	mov DL, espacio
	MOV AH, 2h
	int 21h
	
	;ingreso de variable (DECENA DEL PRIMER NUMERO)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	SUB AL, 30H
	MOV NUM2, AL
	
	mov DL, linejmp
	MOV AH, 2h
	int 21h
	
	MOV CL, NUM1		;NUM1 ES CONTADOR
	MOV DL, 0H		;SUMA PARA TENER LA MULTIPLICACION
	
	multiplicar:
	ADD DL, NUM2
	SUB CL, 01H
	CMP CL, 00			;COMPARA PARA SABER SI HA LLEGADO A 0
	JE IMPRIMIR1
	JNE multiplicar
	
	;IMPRESION DE RESULTADO DE LA MULTIPLICACION
	IMPRIMIR1:
	MOV AH, 02H
	ADD DL, 30H  
	INT 21H
	
	mov DL, linejmp
	MOV AH, 2h
	int 21h
	
	MOV CL, NUM2 		;NUM2 ES CONTADOR
	MOV DL, NUM1		;NUM1 ES EL DIVIDENDO
	
	divir:
	SUB DL, NUM2
	SUB CL, 01H
	CMP CL, 0H
	JE IMPRIMIRD
	JNE divir

	
	;IMPRESION DE RESULTADOS DE LA DIVISION
	IMPRIMIRD:
	MOV AH, 02H
	ADD DL, 30H  
	INT 21H
		
	
	;finalizar el programa de forma final
	FINALIZAR:
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa