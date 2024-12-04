.text
.global _start

_start:
    movia r2, 0x10000020     # Dirección del display

    movia r6, table
    movia r8, table
    movia r4, 10
    movia r5, 0
    movia r7, 0

loop:

    ldw r3, 0(r6)
    ldw r9, 0(r8)

    slli r9, r9, 8
    or r10, r3, r9
    stwio r10, 0(r2)

    call delay
 
    addi r5, r5, 1
    addi r6, r6, 4


    cmpge r1, r5, r4 
    bne r1, zero, increment_decenas

    br loop

increment_decenas:
    movia r6, table
    movia r5, 0

    addi r7, r7, 1
    addi r8, r8, 4

 
    cmpge r1, r7, r4
    bne r1, zero, reset

    br loop

reset:
    movia r8, table
    movia r7, 0
    br loop


delay:
    movia r11, 5000000

delay_loop:
    subi r11, r11, 1
    bne r11, zero, delay_loop 
    ret

table:
    .word 0x3F               # Número 0
    .word 0x06               # Número 1
    .word 0x5B               # Número 2
    .word 0x4F               # Número 3
    .word 0x66               # Número 4
    .word 0x6D               # Número 5
    .word 0x7D               # Número 6
    .word 0x07               # Número 7
    .word 0x7F               # Número 8
    .word 0x6F               # Número 9