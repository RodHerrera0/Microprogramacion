.model small
.data 
	;variables 
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
	
	
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa