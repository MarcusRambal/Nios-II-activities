.text
.global _start

_start:
    movia r2, 0x10001000  
    movia r4, 0x00001000  
    movia r10, 0x00001004 

ciclo_principal:
    stw r5, 0(r10)      
    
    mov r5, r0         

 
    movia r6, 0x0123456
    stw r6, 0(r4)        

leer_uart:
    ldwio r3, 0(r2)       
    beq r3, r0, leer_uart 
    andi r6, r3, 0x0F    


descomponer:
    movia r7, 0x0123456   
    mov r8, r0           

sumar_digitos:
    andi r9, r7, 0xF      
    add r8, r8, r9       
    srli r7, r7, 4      
    bne r7, r0, sumar_digitos 

 
suma_loop:
    beq r6, r0, fin_suma      

    add r5, r5, r8        
    subi r6, r6, 1       
    br suma_loop         

fin_suma:
    movia r11, 5000000   
retardo:
    subi r11, r11, 1
    bne r11, r0, retardo  

    br ciclo_principal    
