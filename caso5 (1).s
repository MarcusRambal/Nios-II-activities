.text
    .global _start

_start:
    movia r2, 0x10000050          
    movia r3, 0x10000010         
    movi r5, 4                    
    movi r6, 0x1                  

loop:
    movi r4, 0                    

next_pattern:
    andi r7, r6, 0xF              
    
input:
    stwio r7, 0(r3)               
    call delay_medium             
    movi r8, 0x0                 
    stwio r8, 0(r3)
    call delay_long               

    ldwio r9, 0(r2)               
    beq r7, r9, correct_input     
    br input                 

correct_input:
    addi r4, r4, 1               
    slli r6, r6, 1               
    ori r6, r6, 0x1               
    andi r6, r6, 0xF              
    blt r4, r5, next_pattern      
    br loop                      

delay_medium:
    movia r10, 2000000   
delay_medium_loop:
    subi r10, r10, 1
    bne r10, zero, delay_medium_loop
    ret


delay_long:
    movia r10, 50000000           
delay_long_loop:
    subi r10, r10, 1
    bne r10, zero, delay_long_loop
    ret

	