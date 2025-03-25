.model small
.data 
    ; Mensajes
    inicio DB 'PRUEBA DE MENU $'
    instruccion DB 'INGRESE UN NUMERO 1 - 4 O 5 PARA FINALIZAR $'
    
    NUM1 DB ?     ; Variable para almacenar la opción ingresada
    op1 DB ?      ; Primer operando
    OP2 DB ?      ; Segundo operando
    
    ej1 DB 'OPCION 1: SE REALIZARA UNA SUMA $'
    ej2 DB 'OPCION 2: SE REALIZARA UNA RESTA $'
    ej3 DB 'OPCION 3: SE REALIZARA UNA MULTIPLICACION $'
    ej4 DB 'OPCION 4: SE REALIZARA UNA DIVISION $'
    fin DB 'FINALIZANDO PROGRAMA $'
    NO DB 'ERROR, NUMERO INVALIDO $'

.stack 
.code
programa:
    ; Inicializar segmento de datos
    MOV AX, @data
    MOV DS, AX
    
    CALL INICIOMENU  ; Llamada al procedimiento principal del menú
    MOV AH, 4CH      ; Terminar el programa
    INT 21H

; Procedimiento para imprimir un salto de línea
SALTO_LINEA PROC NEAR
    MOV DL, 0AH   ; Código ASCII de salto de línea
    MOV AH, 02H
    INT 21H
    RET
SALTO_LINEA ENDP

; Procedimiento principal que maneja el menú
INICIOMENU PROC NEAR
    ; Imprimir mensaje de inicio
    MOV DX, OFFSET inicio  
    MOV AH, 09H            
    INT 21H  
    CALL SALTO_LINEA

MENU:
    ; Imprimir instrucciones
    MOV DX, OFFSET instruccion  
    MOV AH, 09H
    INT 21H 
    CALL SALTO_LINEA

    ; Leer opción ingresada
    MOV AH, 01H
    INT 21H
    SUB AL, 30H  ; Convertir ASCII a número
    
    ; Validar si la entrada es un número válido (1-5)
    CMP AL, 1
    JL INVALIDO
    CMP AL, 5
    JG INVALIDO
    
    MOV NUM1, AL
    CALL SALTO_LINEA

    ; Evaluar opción seleccionada
    CMP NUM1, 1
    JE OPCION1
    CMP NUM1, 2
    JE OPCION2
    CMP NUM1, 3
    JE OPCION3
    CMP NUM1, 4
    JE OPCION4
    CMP NUM1, 5
    JE OPCION5

INVALIDO:
    ; Mensaje de error
    MOV DX, OFFSET NO  
    MOV AH, 09H            
    INT 21H 
    CALL SALTO_LINEA
    JMP MENU  

OPCION1:
    CALL numero1
    JMP MENU

OPCION2:
    CALL numero2
    JMP MENU

OPCION3:
    CALL numero3
    JMP MENU

OPCION4:
    CALL numero4
    JMP MENU

OPCION5:
    CALL numero5
    
RET
INICIOMENU ENDP 

; Procedimiento para solicitar dos números
Solicitud_Numeros PROC NEAR
    CALL SALTO_LINEA
    MOV AH, 01H
    INT 21H
    SUB AL, 30H  
    MOV op1, AL
    CALL SALTO_LINEA

    MOV AH, 01H
    INT 21H
    SUB AL, 30H  
    MOV OP2, AL
    CALL SALTO_LINEA
    RET
Solicitud_Numeros ENDP

; Procedimientos de operaciones
numero1 PROC NEAR
    MOV DX, OFFSET ej1
    MOV AH, 09H
    INT 21H
    CALL Solicitud_Numeros
    XOR AX, AX
    MOV AL, op1
    ADD AL, OP2
    CALL MOSTRAR_RESULTADO
    RET
numero1 ENDP

numero2 PROC NEAR
    MOV DX, OFFSET ej2
    MOV AH, 09H
    INT 21H
    CALL Solicitud_Numeros
    XOR AX, AX
    MOV AL, op1
    SUB AL, OP2
    CALL MOSTRAR_RESULTADO
    RET
numero2 ENDP

numero3 PROC NEAR
    MOV DX, OFFSET ej3
    MOV AH, 09H
    INT 21H
    CALL Solicitud_Numeros
    XOR AX, AX
    MOV AL, op1
    MOV BL, OP2
    MUL BL
    CALL MOSTRAR_RESULTADO
    RET
numero3 ENDP

numero4 PROC NEAR
    MOV DX, OFFSET ej4
    MOV AH, 09H
    INT 21H
    CALL Solicitud_Numeros
    XOR AX, AX
    MOV AL, op1
    MOV BL, OP2
    CMP BL, 0
    JE DIVISION_ERROR
    DIV BL
    CALL MOSTRAR_RESULTADO
    RET

DIVISION_ERROR:
    MOV DX, OFFSET NO
    MOV AH, 09H
    INT 21H
    CALL SALTO_LINEA
    RET
numero4 ENDP

numero5 PROC NEAR
    MOV DX, OFFSET fin
    MOV AH, 09H
    INT 21H
    MOV AH, 4CH  ; Salir del programa
    INT 21H
    RET
numero5 ENDP

; Procedimiento para mostrar resultado
MOSTRAR_RESULTADO PROC NEAR
    ADD AL, 30H  ; Convertir a ASCII
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    CALL SALTO_LINEA
    RET
MOSTRAR_RESULTADO ENDP

END programa
