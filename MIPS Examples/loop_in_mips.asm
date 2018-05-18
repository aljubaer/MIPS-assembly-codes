# Perpose:	This Program is to compute Sn such that 
#			Sn = 1 + 2 + 3 + ... + N. The value of N
#			will be taken from keyboard.
#	Start .text segment(program code)
.text
#	Declare Main as a global function
.globl main
#	The lebel 'main' represent the starting code
main:
	# Print prompt
	la		$a0, prompt
	li		$v0, 4			# print_string syscall code = 4
	syscall
	
	# Get N from user and save
	li		$v0, 5			# read_int syscall code = 5
	syscall
	add		$t0, $zero, $v0
	
	# Initialize registers
	li		$t1, 0			# initialize counter (i)
	li 		$t2, 0 			# initialize sum 
	
	# A loop
loop:
	addi	$t1, $t1, 1		# i = i + 1
	add		$t2, $t2, $t1 	# sum = sum + i
	bne		$t0, $t1, loop
	# end of loop
	# print res_msg1
	la		$a0, res_msg1
	li		$v0, 4			# print_string syscall code = 4
	syscall
	
	# print N
	move	$a0, $t0
	li		$v0, 1			# print_int syscall code = 1
	syscall
	
	# print res_msg2
	la		$a0, res_msg2
	li 		$v0, 4			# print_string syscall code = 4
	syscall					
	
	# print result
	move 	$a0, $t2
	li		$v0, 1			# print_int syscall code = 1
	syscall
	
	# Exit the program
	li		$v0, 10			# Exit the program
	syscall
	
	
#	Start .data segment(Data!)
.data	
	prompt:		.asciiz	"Enter a integer(N): "
	res_msg1:	.asciiz "Sum of first "
	res_msg2:	.asciiz " integers: "
	lf:			.asciiz "\n"
		