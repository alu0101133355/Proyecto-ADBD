
###################PSEUDOCODIGO###############
#include <iostream>
#using namespace std;

#const unsigned m=4;	//numero de filas 
#const unsigned n=5;	//numero de columnas
 
#int matriz1[m][n]={{1,2,3,4,5},{6,7,8,9,0},{0,2,4,6,8},{1,3,5,7,9}};
#int traspuesta[n][m]=0;

#int main (void){

#	for(int i=0; i<n; i++){
#		for(int j=0 ; j<m; j++){
#			traspuesta[j][i] = matriz1[i][j];
#			} 
#		}
#	for(int i = 0; i < m; i++){
#		for(int j = 0; j < n; j++){
#			cout<<traspuesta[i][j]<<"\t";
			
#			}
#			cout<<endl;
#		}
#	}
############################################



m = 4		# numero de filas de matriz1
n = 5		# numero de columnas de  matriz1
size = 4	# tamano de cada elemento


# HAY QUE PONER UN ESPACIO DETRAS DE CADA COMA EN LA DEF DE VECTORES Y MATRICES
			.data
matriz1:	.word	1, 2, 3, 4, 5
			.word	6, 7, 8, 9, 0
			.word	0, 2, 4, 6, 8
			.word	1, 3, 5, 7, 9

.data
titulo:		.asciiz			"Practica 4 \n"	
enun1:		.asciiz			"MATRIZ\n"
enun2:		.asciiz			"TRASPUESTA\n"
barra:		.asciiz 		"  |  "
slinea:		.asciiz			"\n"


			.text
main:
		
								
	li $v0,4   			
	la $a0, titulo 			
	syscall				

	li $v0,4					
	la $a0,enun1
	syscall 	
			
	la $s1,matriz1			
	move $t0, $zero			
	li $t2, size			
	li $t3, n			 	
	li $t6, m			 
	

	move $t1,$zero			
	move $t0,$zero			
	
	
mostrar1:
	
	move $t1,$zero

mostrar2:
	
	mul $t4,$t0,$t3			
	addu $t4,$t4,$t1		
	mul $t4,$t4,$t2			
	addu $t4,$t4,$s1		
	lw $t4,0($t4)			

	
	li $v0,1
	move $a0,$t4			
	syscall


	addi $t1,$t1,1			
	blt $t1,n,mostrar2		

	addi $t0,$t0,1			
	blt $t0,m,mostrar1		
	
	move $t1,$zero

	li $v0,4
	la $a0,slinea
	syscall

	#Calculo de la traspuesta 
	
	li $v0,4
	la $a0,enun2	
	syscall

buc_1:
	
	move $t0,$zero

buc_2:
	
	mul $t8,$t0,$t3			
	addu $t8,$t8,$t1		
	mul $t8,$t8,$t2			
	addu $t8,$t8,$s1		
	lw $t8,0($t8)			

	li $v0,1
	move $a0,$t8			
	syscal

	addi $t0,$t0,1			
	blt $t0,m,buc_2

	li $v0,4				 
	la $a0,slinea
	syscall

	addi $t1,$t1,1			
	blt $t1,n,buc_1



	
	
    li	$v0,10
    syscall
			
