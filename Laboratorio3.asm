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
	
	;IMPRIMIR EL RESULTADO DE LA SUMA
	; DIVIDIMOS DENTRO DE 100 PARA ENCONTRAR PRIMERO LAS CENTENAS
    MOV CL, 64H    ; asignamos el valor de 100 (64H) para dividir
    XOR AH, AH     ; limpiar AH dado que se utilizó y quedó valor en el registro
    DIV CL         ; AX / 100 -> AL = cociente (centenas), AH = residuo

    MOV CH, AH     ; guardamos el residuo en CH
    ADD AL, 30H    ; convertir centenas a ASCII

    ; Impresión de centenas
    MOV AH, 02H
    MOV DL, AL
    INT 21H

    ; DIVIDIMOS EL RESIDUO DENTRO DE 10 PARA OBTENER DECENAS Y UNIDADES
    MOV AL, CH     ; recuperar el residuo de la primera división
    MOV CL, 0AH    ; asignamos el valor de 10 (0AH) para dividir
    XOR AH, AH     ; limpiar AH antes de la división
    DIV CL         ; AL / 10 -> AL = decenas, AH = unidades

    MOV CH, AH     ; guardamos unidades en CH
    ADD AL, 30H    ; convertir decenas a ASCII

    ; Impresión de decenas
    MOV AH, 02H
    MOV DL, AL
    INT 21H

    ADD CH, 30H    ; convertir unidades a ASCII

    ; Impresión de unidades
    MOV AH, 02H
    MOV DL, CH
    INT 21H
	
	
	mov DL, linejmp
	MOV AH, 2h
	int 21h
	
	;Multipliacion X*Y
	XOR AX, AX
	MOV AL, NUM1
	MOV BL, NUM2
	MUL BL
	
	;IMPRIMIR EL RESULTADO DE LA MULTIPLICACION
	; DIVIDIMOS DENTRO DE 100 PARA ENCONTRAR PRIMERO LAS CENTENAS
    MOV CL, 64H    ; asignamos el valor de 100 (64H) para dividir
    XOR AH, AH     ; limpiar AH dado que se utilizó y quedó valor en el registro
    DIV CL         ; AX / 100 -> AL = cociente (centenas), AH = residuo

    MOV CH, AH     ; guardamos el residuo en CH
    ADD AL, 30H    ; convertir centenas a ASCII

    ; Impresión de centenas
    MOV AH, 02H
    MOV DL, AL
    INT 21H

    ; DIVIDIMOS EL RESIDUO DENTRO DE 10 PARA OBTENER DECENAS Y UNIDADES
    MOV AL, CH     ; recuperar el residuo de la primera división
    MOV CL, 0AH    ; asignamos el valor de 10 (0AH) para dividir
    XOR AH, AH     ; limpiar AH antes de la división
    DIV CL         ; AL / 10 -> AL = decenas, AH = unidades

    MOV CH, AH     ; guardamos unidades en CH
    ADD AL, 30H    ; convertir decenas a ASCII

    ; Impresión de decenas
    MOV AH, 02H
    MOV DL, AL
    INT 21H

    ADD CH, 30H    ; convertir unidades a ASCII

    ; Impresión de unidades
    MOV AH, 02H
    MOV DL, CH
    INT 21H
	
	;finalizar
	MOV AH, 4CH		;parametro para finalizar el programa
	INT 21H			;ejecuta la interrupcion de finalizar
	
END programa