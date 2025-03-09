.MODEL small
.data 

    num1 db ?, ?, '$'  ; Dos espacios para los dígitos + terminador
    num2 db ?, ?, '$'  ; Dos espacios para los dígitos + terminador
	result db ? ;resultado
	
    msg1 db "Ingrese el primer numero: $"
    msg2 db "Ingrese el segundo numero: $"
    msg3 db "El primer numero es: $"
    msg4 db "El segundo numero es: $"
	msg5 db "Suma: $"
	
	salto_linea DB 0Ah
	division DB '-$'
	
.stack
.code
programa:
    start:
        mov ax, @data
        mov ds, ax
        
        ; Mostrar mensaje para el primer número
        mov dx, offset msg1
        mov ah, 09h
        int 21h
        
        ; Leer primer número
        mov si, offset num1
        call leer_numero
        
							; Salto de línea
							MOV DL, salto_linea
							MOV AH, 2H
							INT 21H
        
        ; Mostrar mensaje para el segundo número
        mov dx, offset msg2
        mov ah, 09h
        int 21h
        
        ; Leer segundo número
        mov si, offset num2
        call leer_numero
        
							; Salto de línea
							MOV DL, salto_linea
							MOV AH, 2H
							INT 21H
        
        ; Mostrar el primer número
        mov dx, offset msg3
        mov ah, 09h
        int 21h
        mov dx, offset num1
        int 21h
        
        ; Salto de línea
        mov dl, 0Dh
        mov ah, 02h
        int 21h
        mov dl, 0Ah
        int 21h
        
        ; Mostrar el segundo número
        mov dx, offset msg4
        mov ah, 09h
        int 21h
        mov dx, offset num2
        int 21h
        
        ; Terminar programa
        mov ah, 4Ch
        int 21h
    
    leer_numero proc
        mov ah, 01h  ; Leer carácter
        int 21h
        mov [si], al
        inc si
        cmp al, 0Dh  ; Verificar si es Enter
        je fin_lectura
        int 21h
        mov [si], al
        inc si
    fin_lectura:
        mov byte ptr [si], '$'  ; Terminar string
        ret
    leer_numero endp
	
							; Salto de línea
							MOV DL, salto_linea
							MOV AH, 2H
							INT 21H
							
							; Línea de división
							MOV DL, division
							MOV AH, 2H
							INT 21H
							
							; Salto de línea
							MOV DL, salto_linea
							MOV AH, 2H
							INT 21H	

    ;num1 + num2
	mov dx, offset msg5
    mov ah, 09h
    int 21h
    MOV AL, num1
    SUB AL, 30h   ; Convierte de ASCII a número
    MOV BL, num2
    SUB BL, 30h   ; Convierte de ASCII a número
    ADD AL, BL    ; Suma los valores
    ADD AL, 30h   ; Convierte de nuevo a ASCII para imprimir
    MOV result, AL

    ; Mostrar resultado
    MOV DL, result
    MOV AH, 2H
    INT 21H

END start
