.model small
.data 
	;variables 
	
	NUM1 DB ?
	NUM2 DB ?
	numerosiguales DB 'Los numeros son iguales $'
	priemromayor DB 'El primer numero es mayor $'
	segundomayor DB 'El segundo numero es mayor $'
	
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
	
	;COMPARACION
	MOV BL, NUM1
	CMP BL, NUM2		;COMPARA NUM1 Y NUM2
	;CMP COMPARA AMBOS NUMEROS RESTANDOLOS Y VIENDO SI EL RESULTADO ES CERO, UN NUMERO POSITIVO O NEGATIVO Y CON ESO DA LAS OPCIONES
	JE Imprimir_Numeros_Son_Iguales		;AMBOS NUMEROS SE RESTAN Y DEBE DE DAR 0
	JG Imprimir_Primero_Es_Mayor		;SI NUM1>NUM2 DADO QUE LA RESTA DA UN NUMERO POSITIVO 
	JL Imprimir_Segundo_Es_Mayor		;SI NUM1<NUM2 DADO QUE LA RESTA DA UN NUMERO NEGATIVO 
	
	;IMPRIME SI LOS NUMEROS SON IGUALES
	Imprimir_Numeros_Son_Iguales:
		XOR DX, DX
		MOV AH, 09H
		MOV DL, offset numerosiguales
		int 21H
		JMP FINALIZAR
	
	;IMPRIME SI EL PRIMER NUMERO ES MAYOR
	Imprimir_Primero_Es_Mayor:
		XOR DX, DX
		MOV AH, 09H
		MOV DL, offset priemromayor
		int 21H
		JMP FINALIZAR
	
	;IMRPIME SI EL SEGUNDO NUMERO ES MAYOR 
	Imprimir_Segundo_Es_Mayor:
		XOR DX, DX
		MOV AH, 09H
		MOV DL, offset segundomayor
		int 21H	
		JMP FINALIZAR
	
	;finalizar el programa de forma final
	FINALIZAR:
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa