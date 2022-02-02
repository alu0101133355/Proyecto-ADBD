

            .data
titulo:	                .asciiz "Practica 5. PRINCIPIOS DE COMPUTADORES.\n"
hermite:                .asciiz "Polinomio de Hermite.\n"           
orden:                  .asciiz "Introduzca el orden del polinomio: "
punto:                  .asciiz "Introduzca el punto donde calcular el polinomio: "
orden_negativa:         .asciiz "Tiene orden negativa."
resultado_general:      .asciiz "El resultado del polinomio es: "
resultado_cero:         .asciiz "El resultado del polinomio es: 1"
salto_de_linea:         .asciiz "\n"
petop0:                 .asciiz "\nIntroduzca su opcion: "
petop1: 		        .asciiz "\n1. Iterativa."
petop2:			        .asciiz "\n2. Recursiva. "
petop3:			        .asciiz "\n0. Salir del programa."



            .text
main:

    li $v0, 4
    la $a0, titulo 
    syscall
    
    li $v0, 4 
    la $a0,hermite  
    syscall
    
    la $a0,salto_de_linea 
    li $v0,4
    syscall
error_orden:
    la $a0,orden 
    li $v0,4
    syscall
   
    li $v0,5 
    syscall
    move $t2,$v0

    blt $t2,$zero,negativa 

    la $a0,salto_de_linea 
    li $v0,4
    syscall

    la $a0,punto 
    li $v0,4
    syscall

    li $v0,6
    syscall      
       

menu:   

    la $a0,salto_de_linea 
    li $v0,4
    syscall

    li $v0,4  	 	
	la $a0, petop1
	syscall

    li $v0,4  	 	
	la $a0, petop2
	syscall

    li $v0,4  	 	
	la $a0, petop3
	syscall

    li $v0,4  	 	
	la $a0, petop0
	syscall

    li $v0,5 
	syscall
	move $t5,$v0

    beq $t5, 1, iterativa_f
    beq $t5, 2, recursiva_f
    beq $t5, 0, final

negativa:
        la $a0,orden_negativa   
        li $v0,4               
        syscall               

        la $a0,salto_de_linea   
        li $v0,4               
        syscall               

        j error_orden      


final:  
    li $v0,10
    syscall



iterativa_f:


    jal iterativa



            la $a0,salto_de_linea   
            li $v0,4               
            syscall 

            la $a0,resultado_general 
            li $v0,4
            syscall

            mov.s $f12,$f26
            li $v0,2
            syscall

    j menu



    iterativa:

    mov.s $f12,$f0  #X
    move $a0,$t2   #Orden
    li.s $f1,2.0
    li.s $f6, 2.0
    li.s $f24, 1.0 #H0
    li.s $f25, 0.0 #H1
    li.s $f18, 1.0

    bgt $a0, 1, HM_I
    beq $a0, 1, H1_I


        la $a0,resultado_cero 
        li $v0,4
        syscall
        j menu

        H1_I:
            mul.s $f26, $f1, $f12
            jr $ra 

        HM_I:
            mul.s $f25, $f1, $f12
        for:

                mtc1 $a0,$f9           
                cvt.s.w $f9,$f9 

                c.eq.s $f6,$f9
                bc1t end_for


                mul.s $f20,$f1,$f9
                mul.s $f20,$f20,$f25
                
                sub.s $f4,$f6,$f18
                mul.s $f21,$f1,$f4
                mul.s $f21,$f21,$f24

                
                
                sub.s $f26,$f20,$f21
                #$f26=2*orden*$f25-(2*($t6-1)*$f24) 
                mov.s $f24, $f25
                #$f24 = $f25
                mov.s $f25, $f26
                #$f25 = $26
        
        add.s $f6,$f6,$f18
        j for
        end_for:
            jr $ra 



recursiva_f:

    mov.s $f12,$f0 
    move $a0,$t2
    
    li.s $f1,2.0            
    li.s $f10,1.0
    li $t3,1  

    jal recursiva

    la $a0,salto_de_linea   
    li $v0,4               
    syscall 

    la $a0,resultado_general 
    li $v0,4
    syscall

    mov.s $f12,$f3
    li $v0,2
    syscall

    j menu

        recursiva: 
            addi $sp, -24  
            sw $ra,16($sp) 
            sw $a0,24($sp) 

        H0:
            bne $a0,$zero,H1    
            li.s $f2,1.0       
            j pop_pila          

        H1:
            bne $a0,$t3,general    
            mul.s $f3,$f1,$f12     
            addi $a0,$a0,-1       
            b H0 

        general:
            addi $a0,$a0,-1       
            jal recursiva 
            lw $a0,24($sp)          

            mul.s $f4,$f1,$f0       
            mul.s $f4,$f4,$f3       
        
            mtc1 $a0,$f6           
            cvt.s.w $f6,$f6         

            sub.s $f6,$f6,$f10       
            mul.s $f5,$f1,$f6       
            mul.s $f5,$f5,$f2       
        
       
            sub.s $f7,$f4,$f5       

            mov.s $f2,$f3          
            mov.s $f3,$f7           

        pop_pila:                       
            lw $ra,16($sp)  
            addi $sp,24
            jr $ra

