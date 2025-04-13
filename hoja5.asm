.model small         
.stack 100h           

.data                 ; Sección de datos
    entrada db 100         ; Byte 0: longitud máxima de la cadena (100 caracteres)
            db ?           ; Byte 1: aquí DOS guardará la cantidad de caracteres ingresados por el usuario
            db 100 dup('$')  ; Bytes 2 a 101: espacio reservado para los caracteres de la cadena
			
    
    msgEJ1 db 'EJERCICIO 1: CONVERSION A MAYUSCULAS $'  
    msgEJ2 db 'EJERCICIO 2: CONTEO DE CARACTERES $' 
	
	msg db 'INGRESE UNA CADENA EN MINUSCULAS: $'  
    msgcont db 'LA CANTIDAD DE CARACTERES EN LA CADENA ES DE: $'
	
    salto   db 13,10,'$'    

    bufferSalida db 11 dup('$') ; Para almacenar número en ASCII (hasta 10 cifras)

.code                ; Sección de código
programa:
	; Inicializar
	MOV AX, @data	
	MOV DS, AX		

    ; Mostrar mensaje EJERCICIO 1
    mov ah, 09h           
    lea dx, msgEJ1
    int 21h            

    ; SALTO DE LINEA
    mov ah, 09h
    lea dx, salto
    int 21h
	
    ; Mostrar mensaje solicitando entrada
    mov ah, 09h           
    lea dx, msg          
    int 21h

    ; SALTO DE LINEA
    mov ah, 09h
    lea dx, salto
    int 21h

    ; Leer cadena
    lea dx, entrada       
    mov ah, 0Ah           
    int 21h               ; Solicita al usuario una cadena y la guarda en 'entrada'             

    ; Preparar para conversión a mayúsculas
    lea si, entrada + 2   ; SI apunta al primer carácter ingresado (después de los bytes de control)
    mov cl, entrada[1]    ; CL contiene la cantidad de caracteres ingresados
    mov ch, 0             ; CX = número total de caracteres ingresados           

; === BUCLE DE CONVERSIÓN A MAYÚSCULAS ===
convertir:
    mov al, [si]          ; AL toma el carácter actual
    cmp al, 'a'           
    jb siguiente          ; Si es menor que 'a', no es minúscula → saltar
    cmp al, 'z'           
    ja siguiente          ; Si es mayor que 'z', tampoco es minúscula → saltar

    sub al, 32            ; Convierte minúscula a mayúscula
    mov [si], al          ; Guarda el nuevo carácter en la misma posición

siguiente:
    inc si                ; Apunta al siguiente carácter
    loop convertir        ; Repite hasta que CX = 0       

; === AGREGAR TERMINADOR '$' ===
    ;lea si, entrada       
    ;mov cl, entrada[1]    
    ;mov ch, 0             
    ;add si, cx            ; SI apunta al final de los caracteres ingresados
    ;mov byte ptr [si+2], '$' ; Se coloca '$' al final para poder imprimir la cadena

	; SALTO DE LINEA
    mov ah, 09h
    lea dx, salto
    int 21h               ; Salto de línea

	;IMPORESION DE CADENA CONVERTIDA
    mov ah, 09h           
    lea dx, entrada + 2   
    int 21h               ; Imprime la cadena convertida a mayúsculas

	; SALTO DE LINEA
    mov ah, 09h
    lea dx, salto
    int 21h               ; Salto de línea

	
    ; Mostrar mensaje EJERCICIO 2
    mov ah, 09h           
    lea dx, msgEJ2          
    int 21h

    ; SALTO DE LINEA
    mov ah, 09h
    lea dx, salto
    int 21h

    ; Mostrar mensaje de conteo
    mov ah, 09h
    lea dx, msgcont
    int 21h

; === CONTEO DE CARACTERES (sin espacios) ===
    lea si, entrada + 2   ; SI apunta al inicio de la cadena ingresada
    xor cx, cx            ; CX será nuestro contador

contar:
    mov al, [si]          
    cmp al, '$'           
    je mostrarConteo      ; Si es el final de la cadena, termina
    cmp al, ' '           
    je continuar          ; Si es un espacio, no contar
    inc cx                ; Incrementar contador solo si no es espacio

continuar:
    inc si                
    jmp contar            ; Repetir el ciclo            

; === MOSTRAR EL CONTEO EN ASCII ===
mostrarConteo:
    mov ax, cx            ; AX = total de caracteres contados
    mov bx, 10            ; Preparamos la división para convertir a decimal
    lea di, bufferSalida + 10 ; Apunta al final del buffer

convertirNumero:
    xor dx, dx            ; Limpiar DX antes de dividir
    div bx                ; AX / 10 → AL = cociente, DL = residuo
    add dl, '0'           ; Convertir dígito a ASCII
    dec di                ; Retrocedemos una posición en el buffer
    mov [di], dl          ; Guardamos el dígito convertido
    cmp ax, 0             
    jne convertirNumero   ; Repetir hasta que AX = 0  

    ; Mostrar número
    mov ah, 09h
    lea dx, [di]
    int 21h               ; Imprimir los dígitos del número

	; Finalizar
	MOV AH, 4CH		
	INT 21H			

end programa          
