;PRUEBA DE OTROS TIPOS DE SALTOS COMO JE, JG Y JL
;EXISTEN EQUIVALENTES EN SALTOS COMO JG ES EQUIVALENTE A JNS O JL ES EQUIVALENTE A JS

.model small
.data 
	;variables 
	
	num1 DB ?
	num2 DB ?
	
	num_igual DB 'LOS NUMEROS SON IGUALES $'
	num1_mayor DB 'EL PRIMER NUMERO ES MAYOR $'
	num2_mayor DB 'EL SEGUNDO NUMERO ES MAYOR $'
	
.stack ; puede tener un tamaño
.code
programa:
	;inicializar
	MOV AX, @data	;toma direccion de segmento de datos
	MOV DS, AX		;inicializa donde empieza en memoria el segmento de datos
	
	;LECTURA DE DOS NUMEROS
	MOV AH, 1H
	INT 21H
	SUB AL, 30H
	MOV num1, AL
	MOV AH, 1H
	INT 21H
	SUB AL, 30H
	MOV num2, AL
	
	CMP num1, AL
	JE iguales
	JG PRIMERO
	JL segundo
	
	iguales:
	MOV DX, OFFSET num_igual
    MOV AH, 09H
    INT 21H
	JMP TERMINAR
	
	primero:
	MOV DX, OFFSET num1_mayor
    MOV AH, 09H
    INT 21H
	JMP TERMINAR
	
	segundo:
	MOV DX, OFFSET num2_mayor
    MOV AH, 09H
    INT 21H
	JMP TERMINAR	
	
	TERMINAR:
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa