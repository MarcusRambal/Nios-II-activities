.data
a: .word 2
b: .word 3
c: .word 5
x: .word 2
result: .word 0

.text
.global _start
_start:
	movia r3, a           
    movia r4, b              
    movia r5, c              
    movia r6, x            
    movia r7, result            

    call function               

    break                     

function:
    mul r8, r6, r6  #x^2            
    mul r8, r8, r3  #a*x^2           

    mul r9, r6, r4  #b*x           

    add r8, r8, r9  #a*x^2 + b*x           
    add r8, r8, r5  #a*x^2 + b*x + c            

    stw r8, 0(r7)               

    stw r6, 4(r7)               

    ret                         
