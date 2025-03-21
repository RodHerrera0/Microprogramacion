.model small
.data 
    ; Variables 
    inicio DB 'PRUEBA DE MENU $'
    instruccion DB 'INGRESE UN NUMERO 1 - 4 O 5 PARA FINALIZAR $'
    
    NUM1 DB ? 
    op1 DB ?
    OP2 DB ?
    
    ej1 DB 'OPCION 1 SE REALIZARA UNA SUMA $'
    ej2 DB 'OPCION 2 SE REALIZARA UNA RESTA $'
    ej3 DB 'OPCION 3 SE REALIZARA UNA MULTIPLICACION $'
    ej4 DB 'OPCION 4 SE REALIZARA UNA DIVISION $'
    fin DB 'FINALIZANDO PROGRAMA $'
    NO DB 'ERROR, NUMERO INVALIDO $'

.stack 
.code
programa:
    ; Inicializar segmento de datos
    MOV AX, @data
    MOV DS, AX
    
    JMP INICIAR

INICIAR:
    ; Imprimir mensaje de inicio
    MOV DX, OFFSET inicio  
    MOV AH, 09H            
    INT 21H  

    CALL SALTO_LINEA

MENU:
    XOR AX, AX
    ; Imprimir instrucciones
    MOV DX, OFFSET instruccion  
    MOV AH, 09H
    INT 21H 

    CALL SALTO_LINEA

    ; Leer un número desde el teclado
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; Convertir de ASCII a valor numérico
    MOV NUM1, AL

    CALL SALTO_LINEA

    ; Evaluar opciones del menú con etiquetas intermedias
    CMP NUM1, 1
    JE numero1
    CMP NUM1, 2
    JE numero2
    CMP NUM1, 3
    JE numero3
    CMP NUM1, 4
    JE numero4
    CMP NUM1, 5
    JE numero5
    JMP ERROR

ERROR:
    CALL SALTO_LINEA
    MOV DX, OFFSET NO  
    MOV AH, 09H            
    INT 21H 
    CALL SALTO_LINEA
    JMP MENU  

numero1:    
    MOV DX, OFFSET ej1  
    MOV AH, 09H
    INT 21H
    CALL OPERACION
    ADD AL, OP2  
    JMP MOSTRAR_RESULTADO

numero2:
    MOV DX, OFFSET ej2  
    MOV AH, 09H
    INT 21H
    CALL OPERACION
    SUB AL, OP2  
    JMP MOSTRAR_RESULTADO

numero3:
    MOV DX, OFFSET ej3  
    MOV AH, 09H
    INT 21H
    CALL OPERACION
    MOV BL, OP2
    MUL BL
    JMP MOSTRAR_RESULTADO

numero4:
    MOV DX, OFFSET ej4  
    MOV AH, 09H
    INT 21H
    CALL OPERACION
    MOV BL, OP2
    XOR AH, AH
    DIV BL
    JMP MOSTRAR_RESULTADO
    
numero5:
    MOV DX, OFFSET fin  
    MOV AH, 09H
    INT 21H  
    MOV AH, 4CH        
    INT 21H

OPERACION:
    CALL SALTO_LINEA
    ; Leer primer número desde el teclado
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; Convertir de ASCII a valor numérico
    MOV op1, AL
    
    CALL SALTO_LINEA

    ; Leer segundo número desde el teclado
    MOV AH, 01H
    INT 21H
    SUB AL, 30H      ; Convertir de ASCII a valor numérico
    MOV OP2, AL
    
    CALL SALTO_LINEA
    
    XOR AX, AX
    MOV AL, op1
    RET

MOSTRAR_RESULTADO:
    ADD AL, 30H  ; Convertir a ASCII para mostrar
    MOV DL, AL
    MOV AH, 02H
    INT 21H
    
    CALL SALTO_LINEA
    JMP MENU

SALTO_LINEA:
    MOV DL, 0AH   ; Salto de línea
    MOV AH, 02H
    INT 21H
    RET

END PROGRAMA
