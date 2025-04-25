.model small
.stack 100h

.data
    ; Buffers para función 0Ah (lectura de cadenas con formato especial):
    ; Byte 0 = tamaño máximo del buffer (100)
    ; Byte 1 = cantidad de caracteres leídos (se llena automáticamente)
    ; Bytes 2 en adelante = almacenamiento de la cadena

    entrada1 db 100             ; Tamaño máximo de la cadena 1
             db ?               ; Longitud leída (la completa DOS)
             db 100 dup(?)      ; Espacio para la cadena 1

    entrada2 db 100             ; Igual para cadena 2
             db ?
             db 100 dup(?)

    ; Mensajes para el usuario
    msg1 db 'Ingrese primer cadena: $'
    msg2 db 'Ingrese segunda cadena: $'
    msgSi db 'Si es una subcadena $'
    msgNo db 'No es una subcadena $'

.code
programa:
    ; Inicializar segmentos de datos
    mov ax, @data
    mov ds, ax

    ; === Entrada de la primera cadena ===
    mov ah, 09h                 ; Impresion del primer mensaje de solicitud
    lea dx, msg1
    int 21h

    lea dx, entrada1            ; Dirección del buffer estructurado para entrada1
    mov ah, 0Ah                 ; Función 0Ah: leer cadena con formato especial
    int 21h

    call SALTO                  ;salto de linea

    ; === Entrada de la segunda cadena ===
    mov ah, 09h
    lea dx, msg2
    int 21h

    lea dx, entrada2
    mov ah, 0Ah
    int 21h

    call SALTO

    ; === Inicializar punteros a las cadenas ingresadas ===
    lea si, entrada1 + 2        ; SI apunta al primer carácter útil de entrada1
    lea di, entrada2 + 2        ; DI apunta al primer carácter útil de entrada2

    mov bx, si                  ; BX guarda el inicio original (SI) de entrada1
    mov cx, di                  ; CX guarda el inicio original (DI) de entrada2

; ====== Búsqueda de subcadena (entrada2 en entrada1) ======
buscarSubcadena:
    mov si, bx                  ; Reiniciar SI al inicio de entrada1
    mov di, cx                  ; Reiniciar DI al inicio de entrada2

comparar:
    mov al, [di]                ; Obtener siguiente carácter de entrada2
    cmp al, 13                  ; compara el caracter con $ para saber si es el fin de una cadena
    je SiSub                    ; Si es valido si es una subcadena

    mov ah, [si]                ; Obtener carácter correspondiente de entrada1
    cmp ah, 13                  ; Si entrada1 terminó antes de completar comparación:
    je siguiente                ; pasar al siguiente carácter de entrada1

    cmp al, ah                  ; Comparar caracteres de ambas cadenas
    jne siguiente               ; Si no coinciden, probar en otra posición

    inc si                      ; Avanzar en ambas cadenas
    inc di
    jmp comparar                ; Continuar comparando siguientes caracteres

siguiente:
    inc bx                      ; Avanzar base de búsqueda en entrada1
    mov al, [bx]                ; Verificar si ya terminamos entrada1
    cmp al, 13
    je NoSub                    ; Si se finalizo entrada1, entonces no hay una subcadena

    jmp buscarSubcadena         ; Reiniciar comparación desde nueva posición

; ====== Resultado: Sí es subcadena ======
SiSub:
    mov ah, 09h
    lea dx, msgSi               ; Mostrar mensaje de afirmación
    int 21h
    jmp FIN

; ====== Resultado: No es subcadena ======
NoSub:
    mov ah, 09h
    lea dx, msgNo               ; Mostrar mensaje de negación
    int 21h
    jmp FIN

; ====== Salida del programa ======
FIN:
    mov ah, 4Ch                 ; Función 4Ch: salir del programa
    int 21h

; ====== Procedimiento para salto de línea (CR + LF) ======
SALTO proc near
    mov ah, 02h
    mov dl, 13                  ; Carriage return (CR)
    int 21h
    mov dl, 10                  ; Line feed (LF)
    int 21h
    ret
SALTO endp

end programa
