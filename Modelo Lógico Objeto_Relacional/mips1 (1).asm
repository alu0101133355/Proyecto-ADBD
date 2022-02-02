#calculamos  mcd para aplicar mcm = ( A * B) / mcd usaremos el Algoritmo de Euclides para calcular mcd
.data # data section
    mes1: .asciiz "\n\nPrimer numero: "
    mes2: .asciiz "Segundo numero: "
    mes3: .asciiz "\nResultado MCD: "
    mes4: .asciiz "\nResultado MCM: "
    
.text
.globl main

# Inicio del main
main:            

	li $v0, 4 # Primer numero mensaje
	la $a0, mes1
	syscall


    	li $v0, 5 # Leer mumero		
	syscall
	move $s0, $v0


	li $v0, 4  # Segundo numero mensaje		
	la $a0, mes2
	syscall


    	li $v0, 5 # Leer mumero	
	syscall
	move $s1, $v0
	

	mult $s0,$s1 # Multiplicamos los numeros
	mflo $s4


REPEAT: # Hacemos bucle para calcular el mcd	
	move $s2,$s1
	div $s0,$s1
	mfhi $s3 #resto de la division
	move $s0,$s1
	move $s1,$s3
UNTIL: bnez $s3,REPEAT		 


	li $v0, 4 # Salida del MCD
	la $a0, mes3
	syscall
	
	li $v0, 1
	move  $a0, $s2
	syscall				


	div $s4,$s2 # Calculamos mcm como (A * B) / MCD(A,B)	
	mflo $t0
	

	li $v0, 4  # Salida del MCM	
	la $a0, mes4
	syscall
	
	li $v0, 1
	move  $a0, $t0
	syscall
	

	li $v0, 10 # Fin del main
	syscall
	
