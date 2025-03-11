;CLASE 11-03-2025
;SALTOS Y ETIQUETAS
;ejercicio 2 del laboratorio, hacer ciclos

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
	
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado almacenado en AL
	INT 21H
	
	
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
	
	MOV CL, NUM1		;NUM1 ES CONTADOR
	MOV DL, NUM2		;SUMA PARA TENER LA MULTIPLICACION
	multiplicar:
	ADD DL, NUM2
	SUB CL, 01H
	CMP CL, 00			;COMPARA PARA SABER SI HA LLEGADO A 0
	JE IMPRIMIR
	
	
	;IMPRESION DE RESULTADOS
	IMPRIMIR:
	MOV AH, 02H
	ADD DL, 30H  
	INT 21H
	
	;finalizar el programa de forma final
	FINALIZAR:
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa