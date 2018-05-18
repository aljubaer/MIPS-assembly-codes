

#	Start .text segment(program code)
.text
#	Declare Main as a global function
.globl main
#	The lebel 'main' represent the starting code
main:
	# Initialize the registers
	add		$t0, $t0, $0 			# i = 0
	la		$s1, A 					# $s1 = &A
	la		$s2, B 					# $s2 = &B
	li		$t5, 5 					# $t6 = 5
	
	# register :
	# $t0 : i
	
	
	# for(i=0; i<5; i++) {
	#	A[i] = B[i] - 1;
	#}
	start_for_loop :
		bge		$t0, $t5, end_for_loop
		sll		$t1, $t0, 2
		add		$t4, $t1, $s1		# $t4 = &A[i]
		add		$t2, $t1, $s2		# $t2 = &B[i]
		lw		$t3, 0($t2)			# $t3 = B[i]
		addi	$t3, $t3,-1			# $t3 = $t3-1	
		sw		$t3,0($t4)   		# A[i] = $t3
		addi	$t0,$t0,1 			# i++
		j		start_for_loop
		
	end_for_loop:	
	
	# i--;
	addi		$t0,$t0,-1 			# i--
	li			$t6,-1 				#$t6 = -1
	
	
	# while(i >= 0) {
	#	A[i]=(A[i]+B[i]) * 2;
	#	i--;
	#}
	
	start_while:
		blt		$t0, $0, end_while 
		sll 	$t1, $t0, 2				# $t1 = $t0 * 4
		add 	$t2, $t1, $s1 			# $t2 = &A[i]
		lw 		$t3, 0($t2) 			# $t3 = A[i]
		add 	$t2, $t1, $s2 			# $t2 = &B[i]
		lw 		$t4, 0($t2)				# $t4 = B[i]
		add 	$t3, $t3, $t4 			# $t3 = A[i] +B[i]
		add 	$t2, $t1, $s1 			# $t2 = &A[i]
		sll 	$t3, $t3, 1 			# $t3 = (A[i]+B[i])*2
		sw 		$t3, 0($t2) 			# A[i] = (A[i]+B[i])*2 
		addi 	$t0, $t0,-1				# i = i - 1
		j		start_while
		
	end_while:
	
	Exit:	
		li $v0,10
		syscall
		
#	Start .data segment(Data!)
.data 
	A: .word 0:5					# int A[5];
	B: .word 1,2,4,8,16				# int B[5] = {1,2,4,8,16};
		
		
	
	
	
	
