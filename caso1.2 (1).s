.text
.global _start

_start: 

movia r2, 0x10001000     #direccion del JTAG UART
movia r4, 0x10000020 	 #direccion 7 segmentos

movia r6, hex_segments


loop:

	ldwio r3, 0(r2)  #cargamos valores desde el JTAG UART
	andi r7, r3, 0x0F  #ultimo digito ascii
	
	srli r8, r3, 4		#primer digito ascii
	andi r8, r8, 0x0F 
	
	#Ultimo digito
	slli r7, r7, 2            
    add r7, r6, r7 
    ldw r7, 0(r7)  
	
	#Primer digito
	slli r8, r8, 2           
    add r8, r6, r8           
    ldw r8, 0(r8)    
	
	slli r8, r8, 8            
    or r9, r8, r7
	
    stwio r9, 0(r4)           
    br loop            

hex_segments:
    .word 0x3F  # '0' en ASCII (código de 7 segmentos)
    .word 0x06  # '1'
    .word 0x5B  # '2'
    .word 0x4F  # '3'
    .word 0x66  # '4'
    .word 0x6D  # '5'
    .word 0x7D  # '6'
    .word 0x07  # '7'
    .word 0x7F  # '8'
    .word 0x6F  # '9'
    .word 0x77  # 'A'
    .word 0x7C  # 'b'
    .word 0x39  # 'C'
    .word 0x5E  # 'd'
    .word 0x79  # 'E'
    .word 0x71  # 'F'
    .word 0x76  # 'H'
    .word 0x38  # 'L'
    .word 0x37  # 'P'
    .word 0x3E  # 'U'
