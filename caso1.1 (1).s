.text
.global _start

_start: 

movia r2, 0x10000100     #direccion del ps/2
movia r4, 0x10000020 	 #direccion 7 segmentos

movia r6, hex_segments


loop:

	ldwio r3, 0(r2)  #cargamos valores desde el ps2
	andi r7, r3, 0x0F  #ultimo digito scan code 
	
	srli r8, r3, 4		#primer digito scan code
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
    .word 0x3F  # Código para '0' en 7 segmentos
    .word 0x06  # Código para '1' en 7 segmentos
    .word 0x5B  # Código para '2' en 7 segmentos
    .word 0x4F  # Código para '3' en 7 segmentos
    .word 0x66  # Código para '4' en 7 segmentos
    .word 0x6D  # Código para '5' en 7 segmentos
    .word 0x7D  # Código para '6' en 7 segmentos
    .word 0x07  # Código para '7' en 7 segmentos
    .word 0x7F  # Código para '8' en 7 segmentos
    .word 0x6F  # Código para '9' en 7 segmentos
    .word 0x77  # Código para 'A' en 7 segmentos
    .word 0x7C  # Código para 'B' en 7 segmentos
    .word 0x39  # Código para 'C' en 7 segmentos
    .word 0x5E  # Código para 'D' en 7 segmentos
    .word 0x79  # Código para 'E' en 7 segmentos
    .word 0x71  # Código para 'F' en 7 segmentos