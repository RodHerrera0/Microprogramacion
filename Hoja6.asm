.model small
.stack 100h

.data
    ; Entrada del usuario
    entrada db 100             ; Tamaño máximo permitido
            db ?               ; Longitud real ingresada
            db 100 dup('$')    ; Buffer de caracteres

    ; Mensajes
    msgIngresa db 'INGRESE UNA CADENA: $'
    msgSi      db 'SI ES PALINDROMO$'
    msgNo      db 'NO ES PALINDROMO$'
    salto      db 13,10,'$'

.code
programa:
    ; Inicialización de segmentos
    mov ax, @data
    mov ds, ax

    ; Solicitar entrada
    mov ah, 09h
    lea dx, msgIngresa
    int 21h

    ; Leer cadena con función 0Ah
    lea dx, entrada
    mov ah, 0Ah
    int 21h

    ; Inicializar punteros
    lea si, entrada
    add si, 2          ; SI apunta al primer carácter ingresado

    mov cl, entrada[1] ; Longitud ingresada
    xor ch, ch
    lea di, entrada
    add di, 2
    add di, cx         ; DI apunta justo después del último carácter
    dec di             ; Posicionar DI en el último carácter real

; Bucle principal: comparación de caracteres ignorando espacios y mayúsculas
comparar:
buscar_izq:
    ; Saltar espacios desde la izquierda
    mov al, [si]
    cmp al, ' '
    jne validar_izq
    inc si
    cmp si, di
    jae es_palindromo
    jmp buscar_izq

validar_izq:
    ; Convertir a mayúscula si es minúscula
    cmp al, 'a'
    jb siguiente_izq
    cmp al, 'z'
    ja siguiente_izq
    sub al, 32 ; Convertir a mayúscula

siguiente_izq:
    mov bl, al

buscar_der:
    ; Saltar espacios desde la derecha
    mov al, [di]
    cmp al, ' '
    jne validar_der
    dec di
    cmp si, di
    jae es_palindromo
    jmp buscar_der

validar_der:
    ; Convertir a mayúscula si es minúscula
    cmp al, 'a'
    jb siguiente_der
    cmp al, 'z'
    ja siguiente_der
    sub al, 32 ; Convertir a mayúscula

siguiente_der:
    ; Comparar caracteres
    cmp bl, al
    jne no_es_palindromo

    ; Avanzar índices
    inc si
    dec di
    cmp si, di
    jbe comparar

es_palindromo:
    lea dx, msgSi
    jmp imprimir

no_es_palindromo:
    lea dx, msgNo

imprimir:
    mov ah, 09h
    int 21h

salir:
    mov ah, 4Ch
    int 21h

end programa
