include macros2.lib
.model small
.data 
	;variables
	op DB ?	;variable para que se seleccione opcion del menu
	num1 DB ?	;numero 1 para trabajo de ejrcicios
	num2 DB ?	;numero 2 para trabajo de ejrcicios
	result DB ?	;variable para almcacenar resultado de ejrcicios
	
	msgMENU DB 'INGRESE UN NUMERO 1 - 4 O 5 PARA FINALIZAR $'	;Mensaje para menu
	msgOP1 DB 'Ejercicio 1: Multiplicacion con suma sucesiva $'	;Opcion de ejercicio 1
	msgOP2 DB 'Ejercicio 2: Division con resta sucesiva $'	;Opcion de ejercicio 2
	msgOP3 DB 'Impresion de factores de un numero $'	;Opcion de ejercicio 3
	msgOP4 DB 'Impresion de serie de fibonacci $'	;Opcion de ejercicio 4
	msgOP5 DB 'Finalizando programa $'	;Opcion de ejercicio 5
    NO DB 'ERROR, NUMERO INVALIDO $'
	
	;--Para ejercicio1:
	msg1 DB 'Igrese el primer numero $'
	msg2 DB 'Igrese el segundo numero $'
	msg3 DB 'El resultado es: $'

	
	LnJmp DB 0Ah	;salto de linea 
	
.stack ; puede tener un tamaño
.386
.code
programa:
	;inicializar
	MOV AX, @data	;toma direccion de segmento de datos
	MOV DS, AX		;inicializa donde empieza en memoria el segmento de datos
	
	MENU:
	call Salto	;Salto de Linea
	
	MOV DX, OFFSET msgMENU	;Mensaje de menu  
    MOV AH, 09H            
    INT 21H  

	call Salto	;Salto de Linea
	
    ; Leer opción ingresada
    MOV AH, 01H
    INT 21H
    SUB AL, 30H  ; Convertir ASCII a número
	MOV op, AL
	
	; Validar si la entrada es un número válido (1-5)
    CMP op, 1
    JL INVALIDO
    CMP op, 5
    JG INVALIDO

    ; Evaluar opción seleccionada
    CMP op, 1
    JE OPCION1
    CMP op, 2
    JE OPCION2
    CMP op, 3
    JE OPCION3
    CMP op, 4
    JE OPCION4
    CMP op, 5
    JE OPCION5

	
	INVALIDO:
	call Salto	;Salto de Linea
    MOV DX, OFFSET NO	; Mensaje de error
    MOV AH, 09H            
    INT 21H 
	call Salto	;Salto de Linea
    JMP MENU 
	
	OPCION1:	;Opcion 1: Multiplciacion repetida
	call Salto	;Salto de Linea	
	Multiplicacion num1, num2, resultado
	JMP MENU
	OPCION2:	;Opcion 2: Division repetida
	call Salto	;Salto de Linea	
	Division num1, num2, resultado
	JMP MENU
	OPCION3:	;Opcion 3:	Muestra de factores
	call Salto	;Salto de Linea	
	Factores num1, resultado
	JMP MENU
	OPCION4:	;Opcion 4: Serie de Fibonacci
	call Salto	;Salto de Linea	
	Fibonacci num1, resultado
	JMP MENU
	OPCION5:	;Opcion 5: Finalizacion del programa
	call Salto	;Salto de Linea	
	JMP Fin
	
	Fin:
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
	Salto:
	mov DL, LnJmp	;salto de linea
	MOV AH, 02H
	int 21h
	ret
	
END programa
	