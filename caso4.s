.text
.global _start

_start:
    movia r2, 0x10001000       # Dirección del JTAG
    movi r11, 2                # Coeficiente 'a'
    movia r12, 3               # Coeficiente 'b'
    movia r13, 5               # Coeficiente 'c'
    movi r20, 0x2f             # Código ASCII para diferenciar
    movi r22, 0x66             # Código ASCII 'f' para función
    movi r16, 0x2b             # Código ASCII '+'
    movi r17, 0x2d             # Código ASCII '-'
    movi r18, 0x2a             # Código ASCII '*'
    movi r19, 0x2f             # Código ASCII '/'

loop:
    beq r6, zero, read
	beq r4, zero, read
	beq r5, zero, oper1
	br oper2
read:
	ldwio r3, 0(r2)            # Leer código de tecla desde el teclado
	andi r3, r3, 0xff
	movia r10, 0x10001000
	stwio r3, 0(r10)
	beq r3, r22, set_func      # Si r3 es 'f' (función), establecer operación de función
    bleu r3, r20, set_oper     # Si r3 < '2f', es un operador
    bgt r3, r20, set_num      # Si r3 >= '2f', es un número
    
	
oper1:
	movi r10, 5
    beq r6, r10, func            # Si oper es 5, ejecutar la función cuadrática
    bne r5, zero, oper2          # Si num2 tiene valor, proceder a oper2
	br read
	
oper2:
	movi r10, 1
    beq r6, r10, suma
	movi r10, 2
    beq r6, r10, resta
	movi r10, 3
    beq r6, r10, mult
	movi r10, 4
    beq r6, r10, div

set_num:
    subi r3, r3, 0x30          # Convierte el código ASCII a número
    beq r4, r0, store_num      # Si num1 está vacío, guardar en num1
    mov r5, r3              # Si num1 ya tiene valor, guardar en num2
	movi r3, 0
    br loop                    # Volver a leer teclado

store_num:
    mov r4, r3              
	movi r3, 0
    br loop

set_oper:
    # Definir el operador según el código ASCII
    beq r3, r16, set_suma      # '+' para suma
    beq r3, r17, set_resta     # '-' para resta
    beq r3, r18, set_mult      # '*' para multiplicación
    beq r3, r19, set_div       # '/' para división
	
	movi r3, 0

set_suma:
    movi r6, 1                 # Operador suma
    br loop
set_resta:
    movi r6, 2                 # Operador resta
    br loop
set_mult:
    movi r6, 3                 # Operador multiplicación
    br loop
set_div:
    movi r6, 4                 # Operador división
    br loop
set_func:
    movi r6, 5                 # Operador función cuadrática
    br loop

# Operaciones básicas
suma:
    add r9, r4, r5             # r9 = num1 + num2
    br display_result

resta:
    sub r9, r4, r5             # r9 = num1 - num2
    br display_result

mult:
    mul r9, r4, r5             # r9 = num1 * num2
    br display_result

div:
    divu r9, r4, r5            # r9 = num1 / num2
    br display_result

func:
    # Cálculo de función cuadrática: r9 = a*num1^2 + b*num1 + c
    mul r14, r4, r4            # r14 = num1^2
    mul r14, r14, r11          # r14 = a * num1^2

    mul r15, r4, r12           # r15 = b * num1

    add r14, r14, r15          # r14 = a*num1^2 + b*num1
    add r9, r14, r13           # r9 = a*num1^2 + b*num1 + c
    br display_result

display_result:
    movia r10, 0x10001000      # Dirección del JTAG UART
	
    movi r2, '='              
    stwio r2, 0(r10)          # Enviar '=' al UART
    # Extraer decenas
    movi r12, 10               
    divu r2, r9, r12           
    muli r8, r2, 10            
    sub r9, r9, r8             

    # Convertir decenas a ASCII y enviar al JTAG UART
    addi r2, r2, 0x30          
    stwio r2, 0(r10)           

    # Convertir unidades a ASCII y enviar al JTAG UART
    addi r9, r9, 0x30          
    stwio r9, 0(r10)           
	
	movi r2, 0x0a
	stwio r2, 0(r10)
	
	movi r4, 0
	movi r5, 0
	movi r6, 0
	movi r9, 0
	
    break