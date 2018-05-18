# File: Lab_Part3.asm
# Author: Abdullah Al Jubaer
# 
.text
.globl main
main:
	lw	$t1, I
	lw	$t0, Z
	li	$t2, 21
	li	$t7, 100
	
	# Loop body
	# for(i=0; i<=21; i=i+3) {
	#	Z++;
	# }
	for_loop:
		bgt 	$t1, $t2, do_while
		addi	$t0, $t0, 1				# Z++
		addi	$t1, $t1, 3				# i = i + 3
		j		for_loop
	
	# do {
	# Z++;
	# } while (Z<100);
	do_while:
		addi	$t0, $t0, 1
		bge		$t0, $t7, while
		addi	$t0, $t0, 1				# Z++
		b		do_while
	
	# while(i > 0) {
	#	Z--;
	#	i--;
	# }
	while:
		beqz 	$t1, end_while
		addi	$t1, $t1, -1			# i--
		addi	$t0, $t0, -1			# Z--
		b		while
	
	end_while:
	
		la		$t7, Z
		sw		$t0, ($t7)
	
	# Exit the program
		li		$v0, 10
		syscall
	
	
	
.data
	I:	.word	0
	Z:	.word	4
