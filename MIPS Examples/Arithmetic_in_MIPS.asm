# Author:	Abdullah Al Jubaer
# Perpose:	This program is to calculate the equation
#			shown below (in C):
#			int main()
#			{
#				int A=15;
#				int B=10;
#				int C=5;
#				int D=2;
#				int E=18;
#				int F=-3;
#				int Z=0;
#				Z = (A-B) * (C+D) + (E-F) - (A/C);
#			}
#	Start .text segment(program code)
.text
#	Declare Main as a global function
.globl main
#	The lebel 'main' represent the starting code
main:
	# Initialize the registers
	li		$t1, 15			# A = 15
	li		$t2, 10			# B = 10
	li		$t3, 5			# C = 5
	li		$t4, 2			# D = 2
	li 		$t5, 18			# E = 18
	li 		$t6, -3			# F = -3
	li		$t0, 0			# Z = 0
	
	# Compute (A - B) and store in $s1
	sub		$s1, $t1, $t2	# $s1 = A - B
	
	# Compute (C + D) and store in $t2
	add		$s2, $t3, $t4	# $s2 = C + D
	
	# Compute (E - F) and store in $s3
	sub		$s3, $t5, $t6	# $s3 = E - F
	
	# Compute (A / C) and store in $s4
	div		$s4, $t1, $t3	# $s4 = A / C
	
	# Compute (A-B) * (C+D) and store in $t0
	mul		$t0, $s1, $s2
	
	# Compute (A-B) * (C+D) + (E-F) and store in $t0
	add		$t0, $t0, $s3
	
	# Compute (A-B) * (C+D) + (E-F) - (A/C) and store in $t0
	sub		$t0, $t0, $s4
	
	# Store the result in memory(Z)
	la		$t1, Z
	sw		$t0, ($t1)
	
	# Exit the program 
	li		$v0, 10
	syscall
	
#	Start .data segment(Data!)
.data
	Z:	.word	0