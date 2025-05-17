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

    ; variables
    num_Col DB ?
    num_Fil DB ?
    num_tot DB ?
	comparador DB 1
    matriz DB 100 dup(?)
    indice DB 0

.code

SALTO PROC
    mov ah, 02h
    mov dl, 13      ; CR
    int 21h
    mov dl, 10      ; LF
    int 21h
    ret
SALTO ENDP



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
	MOV num_Col, AL


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
	MOV num_Fil, AL
	
	CALL SALTO
	
	; === Obtener el numero de espacios en la matriz ====
	MOV AH, 09h		;Mostrar mensaje del resultado
	LEA DX, msg_tot
	INT 21h
	
	SUB num_Col, 30h
	SUB num_Fil, 30h

	XOR AX, AX
	MOV AL, num_Col
	MOV BL, num_Fil
	MUL BL

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
	mov ch, 0
	
Mostrar:

	mov ah, 09h
    lea dx, espacio
    int 21h

	mov dl, [di]
	add dl, 30h
	mov ah, 02h
	int 21h
	inc cl
	inc di
	cmp cl, num_Col
	je cambio_linea
	jmp Mostrar
	
	
cambio_linea:
	call SALTO
	inc ch
	cmp ch, num_Fil
	je Fin
	mov cl, 0
	jmp Mostrar
	

Fin:
    ; Finalizar programa
    mov ah, 4Ch
    int 21h

END programa