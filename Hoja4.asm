.model small
.stack 100h
.data
    ; Declaración de variables
    num1 dw ?              ; Almacena el primer número ingresado
    num2 dw ?              ; Almacena el segundo número ingresado
    suma dw ?            ; Suma de los divisores del primer número
	
	numAUX dw ?

    ; Mensajes a imprimir
    msg1 db 'Ingrese el primer numero: $'
    msg2 db 'Ingrese el segundo numero: $'
	
    msgSuma1 db 'Suma de divisores del primer numero: $'
	msgSuma2 db 'Suma de divisores del segundo numero: $'

	msgPRUEBA db 'MENSAJE DE PRUEBA EN LABORATORIO $'
	
    msgSonAmigos db 'Los numeros si son amigos$', 0Dh, 0Ah, '$'
    msgNoSonAmigos db 'Los numeros no son amigos$', 0Dh, 0Ah, '$'
	
    LineJmp db 0Dh, 0Ah, '$'   ; Salto de línea

.code
programa:
    ; Inicializar el segmento de datos
    MOV AX, @data
    MOV DS, AX

INICIO:
    ; Solicitar el primer número
    MOV AH, 09h
    MOV DX, OFFSET msg1
    INT 21h
    CALL LEER_NUMERO
    MOV num1, AX

    ; Imprimir salto de línea
    MOV AH, 09h
    MOV DX, OFFSET LineJmp
    INT 21h

    ; Solicitar el segundo número
    MOV AH, 09h
    MOV DX, OFFSET msg2
    INT 21h
    CALL LEER_NUMERO
    MOV num2, AX

    ; Imprimir salto de línea
    MOV AH, 09h
    MOV DX, OFFSET LineJmp
    INT 21h


	;MUESTRA LA SUMA DE LOS DIVISORES DE NUM1
    ; Calcular suma de divisores de num1
    MOV AX, num1
    CALL CALCULAR_SUMADIV

    ; Mostrar suma de divisores del primer número
    MOV AH, 09h
    MOV DX, OFFSET msgSuma1
    INT 21h
    CALL IMPRIMIR_NUMERO
    MOV AH, 09h
    MOV DX, OFFSET LineJmp
    INT 21h
	
	; Comparar sumas y determinar si son amigos en base al la comparacion de num1 y suma de los divisores de num2
    MOV AX, suma
    CMP AX, num2
    JNE NO_SON_AMIGOS

	
	;MUESTRA LA SUMA DE LOS DIVISORES DE NUM2
    ; Calcular suma de divisores de num2
    MOV AX, num2
    CALL CALCULAR_SUMADIV

    ; Mostrar suma de divisores del primer número
    MOV AH, 09h
    MOV DX, OFFSET msgSuma2
    INT 21h
    CALL IMPRIMIR_NUMERO
    MOV AH, 09h
    MOV DX, OFFSET LineJmp
    INT 21h

	; Si son amigos, imprimir mensaje correspondiente
    MOV AH, 09h
    MOV DX, OFFSET msgSonAmigos
    INT 21h
    JMP FIN
	; Comparar sumas y determinar si son amigos en base al la comparacion de num2 y suma de los divisores de num1
    MOV AX, suma
    CMP AX, num1
    JNE NO_SON_AMIGOS

    ; Si son amigos, imprimir mensaje correspondiente
    MOV AH, 09h
    MOV DX, OFFSET msgSonAmigos
    INT 21h
    JMP FIN


NO_SON_AMIGOS:
    ; Si no son amigos, imprimir mensaje correspondiente
    MOV AH, 09h
    MOV DX, OFFSET msgNoSonAmigos
    INT 21h

FIN:
    ; Terminar el programa
    MOV AH, 4Ch
    INT 21h

; Procedimiento para leer un número ingresado por el usuario
LEER_NUMERO PROC
    XOR AX, AX  ; Limpiar AX
    XOR CX, CX  ; Inicializar CX en 0 (acumulador del número)
	;INGRESO DE CENTENA
	MOV AH, 01H  ; Leer carácter
    INT 21H
    SUB AL, 30H  ; Convertir ASCII a número
    MOV AH, 0
    MOV BX, 100 
    MUL BX       ; Multiplicar CX por 100
	MOV CX, AX
	;INGRESO DE DECENA
    MOV AH, 01H  ; Leer carácter
    INT 21H
    SUB AL, 30H  ; Convertir ASCII a número
    MOV AH, 0
    MOV BX, 10   
    MUL BX       ; Multiplicar CX por 10
	ADD AX, CX
	MOV CX, AX	;GUARDAMOS LA DECENA
	;INGRESO DE UNIDAD
    MOV AH, 01H  ; Leer carácter
    INT 21H
    SUB AL, 30H  ; Convertir ASCII a número
    MOV AH, 0 
	ADD AX, CX
    RET
LEER_NUMERO ENDP

; Procedimiento para calcular la suma de divisores de un número
CALCULAR_SUMADIV PROC
    XOR BX, BX  ; Limpiar BL (acumulador de la suma)
    MOV CX, AX  ; Copiar número a CX
	MOV numAUX, CX
DIV_LOOP:
    DEC CX       ; Decrementar CX para revisar divisor
    CMP CX, 0    ; Si CX es 0, terminar
    JE FIN_DIV
    MOV DX, 0    
    MOV AX, numAUX  ; Obtener número base
    DIV CX       ; Dividir número entre CX
    CMP DX, 0    ; Si el residuo no es 0, no es divisor
    JNE DIV_LOOP 
    ADD BX, CX   ; Sumar divisor válido
    JMP DIV_LOOP 
FIN_DIV:
    MOV suma, BX   ; Retornar suma de divisores
    RET
CALCULAR_SUMADIV ENDP

; Procedimiento para imprimir un número en pantalla
IMPRIMIR_NUMERO PROC
    MOV AX, suma  ; Obtener número a imprimir
    CALL CONVERTIR_NUMERO  ; Convertir número a texto y mostrar
    RET
IMPRIMIR_NUMERO ENDP

; Procedimiento para convertir un número en caracteres ASCII
CONVERTIR_NUMERO PROC
    MOV CX, 0
CONVERTIR_LOOP:
    XOR DX, DX  ; Limpiar DX
    MOV BX, 10  ; Divisor
    DIV BX      ; División AX / 10, resultado en AX, residuo en DX
    ADD DL, 30H ; Convertir dígito a ASCII
    PUSH DX     ; Almacenar dígito temporalmente en la pila
    INC CX      ; Contador de dígitos
    TEST AX, AX  ; Si AX es 0, terminar
    JNZ CONVERTIR_LOOP

IMPRIMIR_CIFRAS:
    POP DX      ; Recuperar dígitos desde la pila
    MOV AH, 02H ; Imprimir carácter
    INT 21H
    LOOP IMPRIMIR_CIFRAS
    RET
CONVERTIR_NUMERO ENDP

END programa