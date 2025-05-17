.model small
.stack
.data 
    ; mensajes
    msg_Col DB 'Ingrese el numero de columnas: $'
    msg_Fil DB 'Ingrese el numero de filas: $'
    msg_tot DB 'El numero de campos en la matriz es de: $'
    msg_in DB 'Ingrese el numero deseado $'
	msg_show DB 'Matriz llenada con exito $'
	espacio DB ' $'
	fila_bus  DB 'Ingrese direccion de fila a buscar $'
	columna_bus  DB 'Ingrese direccion de columna a buscar $'
	msg_resultado DB 'El numero encontrado es: $'

    ; variables
    num_Col DW ?
    num_Fil DW ?
    num_tot DB ?
	comparador DB 1
    matriz DB 100 dup(?)
    indice DB 0
    fila DW ?
    columna DW ?
    dir_elemento DW ?


.code

SALTO PROC
    mov ah, 02h
    mov dl, 13      ; CR
    int 21h
    mov dl, 10      ; LF
    int 21h
    ret
SALTO ENDP

Busqueda MACRO filaMac, columnaMac
	
	
	mov ax, filaMac
	mov bx, num_Fil
	mul bx
	mov dir_elemento, AX
	MOV ax, columnaMac
	add dir_elemento, ax
	
	call SALTO
	mov ah, 09h
    lea dx, msg_resultado
    int 21h
	
	Lea si, matriz
	add si, dir_elemento
		
	mov dl, [si]
	add dl, 30h
	mov ah, 02h
	int 21h
	
	
ENDM	

programa:
    mov ax, @data
    mov ds, ax

    ; === Ingreso de columnas ===
    mov ah, 09h
    lea dx, msg_Col
    int 21h

    ;Leer desde el teclado (LEER UN CARACTER)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;Guardarlo en la variable
	mov ah, 0
	MOV num_Col, Ax


    call SALTO

    ; === Ingreso de filas ===
    mov ah, 09h
    lea dx, msg_Fil
    int 21h

    ;Leer desde el teclado (LEER UN CARACTER)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;Guardarlo en la variable
	mov ah, 0
	MOV num_Fil, Ax
	
	CALL SALTO
	
	; === Obtener el numero de espacios en la matriz ====
	MOV AH, 09h		;Mostrar mensaje del resultado
	LEA DX, msg_tot
	INT 21h
	
	SUB num_Col, 30h
	SUB num_Fil, 30h

	XOR AX, AX
	MOV Ax, num_Col
	MOV Bx, num_Fil
	MUL Bx

	;antes de convertirlo a ASCII se sacaran decenas y luego unidades	
	;para poder imprimir si el resultado es un numero de 2 digitos primero se dividira dentro de 10 
	;y se pone cociente y despue residuo sacando decenas y luego unidades (valor real)
	XOR AH, AH
	;UTILIZAMOS REGISTROS AUXILIARES (CH) PARA LA DIVISION
	MOV CH, 0AH
	DIV CH
	;En AL tendriamos las decenas y en AH las unidades
	MOV BL, AH	;movemos el valor de AH a BL para poder guardar el valor 
	;IMPRESION DE LAS DECENAS
	ADD AL, 30H
	;Imprecion del resultado
	MOV AH, 02H
	MOV DL, AL		;imprimir el resultado
	INT 21H	
	;IMPRESION DE LAS unidades	
	MOV num_tot, BL
	ADD BL, 30H
	MOV AH, 02H
	MOV DL, BL		;imprimir el resultado
	INT 21H		
	
	
	
    xor di, di                   ; Índice para la matriz (empieza en 0)
    mov cl, num_tot             ; Guardamos num_tot en CL como contador
    mov al, comparador          ; Valor inicial a guardar en la matriz
	xor bx, bx

	;mov di, 0
	lea di, matriz

Llenado:
    ;mov matriz[di], al       ; Guardar el valor en la matriz
	mov [di], AL
	cmp AL, cl
	je show
	inc AL
	inc di
	jmp Llenado

Show:
	;Mensaje de muestra de matriz
    call SALTO
    mov ah, 09h
    lea dx, msg_show
    int 21h
	
	call SALTO

	lea di, matriz
	mov cl, 0	
	mov bl, 0
	
Mostrar:
	xor ch, ch
	mov ah, 09h
    lea dx, espacio
    int 21h

	mov dl, [di]
	add dl, 30h
	mov ah, 02h
	int 21h
	inc cl
	inc di
	cmp cx, num_Col
	je cambio_linea
	jmp Mostrar
	
	
cambio_linea:
	call SALTO
	inc bl
	xor bh, bH
	cmp bx, num_Fil
	je Solicitud
	xor cx, cx
	jmp Mostrar
	
Solicitud:    
	; === Ingreso de filas ===
    mov ah, 09h
    lea dx, fila_bus
    int 21h

    ;Leer desde el teclado (LEER UN CARACTER)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;Guardarlo en la variable
	mov ah, 0
	sub al, 30h
	MOV fila, Ax
	
	CALL SALTO
	
    ; === Ingreso de columnas ===
    mov ah, 09h
    lea dx, columna_bus
    int 21h

    ;Leer desde el teclado (LEER UN CARACTER)
	;Leer dessde el teclado (LEER UN CARACTER)
	MOV AH, 01H		;Parametro para leer desde el teclado
	INT 21H			;ejecuta la lectura
	;Guardarlo en la variable
	mov ah, 0
	sub al, 30h
	MOV columna, Ax
	
	Busqueda fila, columna 
	
	


Fin:
    ; Finalizar programa
    mov ah, 4Ch
    int 21h

END programa