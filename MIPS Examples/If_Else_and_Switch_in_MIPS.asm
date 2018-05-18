# Author: Abdullah Al Jubaer
# Perpose: Implement the following C code in MIPS
# int main()
# {
# 	 int A=10;
#	 int B=15;
#	 int C=6;
#	 int Z=0;
#	 if(A > B || ((C+1) == 7))
#		 Z = 1;
#	 else if(A < B && C > 5)
#		 Z = 2;
#	 else
#		 Z = 3;
#	 switch(Z) {
#		 case 1:
#			 Z = -1;
#			 break;
#		 case 2:
#			 Z = -2;
#			 break;
#		 case 3:
#			 Z = -3;
#			 break;
#		 default:
#			 Z = 0;
#			 break;
#	 }
# }

#	Start .text segment(program code)
.text
#	Declare Main as a global function
.globl main
#	The lebel 'main' represent the starting code
main:
	# Load the variables in register
		la		$t1, A					
		lw		$s1, 0($t1)				# $s1 = A
	
		la		$t2, B
		lw		$s2, 0($t2)				# $s2 = B
	
		la		$t3, C
		lw		$s3, 0($t3)				# $s3 = C
	
		la		$s0, Z
		lw		$t0, 0($s0)				# $t0 = Z
	
	# Check the condition 
	# if (A > B || ((C+1) == 7))
		sgt		$t1, $s1, $s2			# $t1 = (A > B) ? 1 : 0
		addi	$t4, $s3, 1				# $t4 = C + 1
		li		$t4, 7
		seq		$t2, $t4, $t4			# $t2 = (C+1)==7 ? 1 : 0 
		or		$t1, $t1, $t2			# $t1 = $t1 or $t2
		beqz 	$t1	else_if				# if($t1 == 0) goto else_if
		li		$t0, 1					# else Z = 1
		j		end_if
	
	# else if(A < B && C > 5)
	else_if:
		slt		$t1, $s1, $s2			# $t1 = (A < B) ? 1 : 0
		li		$t4, 5					# $t5 = 5
		sgt		$t2, $s3, $t4			# $t2 = (C > 5) ? 1 : 0
		and		$t1, $t1, $t2			# $t1 = $t1 and $t2
		beqz 	$t1, else				# if($t1 == 0) goto else
		li		$t0, 2					# else Z = 2
		j		end_if
	
	# else	
	else:
		li		$t0, 3					# Z = 3
		
	end_if:
	# switch (Z)
	# case 1:
		li		$t1, 1
		bne		$t0, $t1, case_2		# if (Z != 1)jump case_2
		li		$t0, -1					# if (Z == 1)Z = -1
		j		end_switch
	# case 2:
	case_2:
		li		$t1, 2
		bne		$t0, $t1, case_3		# if (Z != 2)jump case_2
		li		$t0, -2					# if (Z == 1)Z = -2
		j		end_switch
	# case 3:
	case_3:
		li		$t1, 3
		bne		$t0, $t1, default		# if (Z != 3)jump default
		li		$t0, -3					# if (Z == 1)Z = -3
		j		end_switch
	# default:
	default:
		li		$t0, 0					# Z = 0
		
	end_switch:
	
	# store the result 
		sw		$t0, 0($s0)				# Z = $t0(the result)
	
# Exit the program
	li 		$v0, 10						# Exit_program syscall code = 10
	syscall


#	Start .data segment(Data!)
.data
	A:		.word 10
	B: 		.word 15
	C: 		.word 6
	Z: 		.word 0
	lf: 	.asciiz "\n"