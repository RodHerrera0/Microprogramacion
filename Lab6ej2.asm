.model small
.data 
    NUM1 DB ?
    espar DB 'El numero es PAR $'
    esimpar DB 'El numero es IMPAR $'	
	
    espacio DB 20h   ; Espacio
    linejmp DB 0AH   ; Salto de línea
    
.stack
.code
programa:
    ; Inicializar segmento de datos
    MOV AX, @data
    MOV DS, AX

    ; Leer un número desde el teclado
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; Convertir de ASCII a valor numérico
    MOV NUM1, AL

    ; Imprimir espacio y salto de línea
    MOV DL, espacio
    MOV AH, 02H
    INT 21H
    
    MOV DL, linejmp
    INT 21H

    ; Preparar división entre 2
    MOV AL, NUM1
    MOV AH, 00H      ; Limpiar AH para evitar "DIVIDE OVERFLOW"
    MOV BL, 2
    DIV BL           ; AL = cociente, AH = residuo
	
	MOV CH, AH		;guardar el residuo en CH
	CMP CH, 00		;comparar el residuo con 0, si es igual es par, de lo contrario es impar
	JE PAR
	JNE IMPAR
	

    ; Convertir el cociente en ASCII y mostrarlo
    ADD AL, 30H      ; Convertir a ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
	
	PAR:
    ; Imprimir el mensaje
    MOV DX, OFFSET espar  ; Cargar la dirección del mensaje en DX
    MOV AH, 09H             ; Función 09h de int 21h (imprimir cadena)
    INT 21H                 ; Llamar a la interrupción de DOS	
    ; Finalizar programa
    MOV AH, 4CH
    INT 21H
	
	IMPAR:
    ; Imprimir el mensaje
    MOV DX, OFFSET esimpar  ; Cargar la dirección del mensaje en DX
    MOV AH, 09H             ; Función 09h de int 21h (imprimir cadena)
    INT 21H                 ; Llamar a la interrupción de DOS	
    ; Finalizar programa
    MOV AH, 4CH
    INT 21H

END programa
