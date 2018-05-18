.text
.globl main
main:
	# register convention
	# $s0 - m
	# $s1 - answer

	la		$a0, prompt1
	li		$v0, 4
	syscall
	
	# Read int
	li		$v0, 5
	syscall
	move	$s0, $v0
	
	# Function calling
	move	$a0, $s0
	move	$a1, $s0
	jal		sqr
	
	# Print result 
	la		$a0, result
	li		$v0, 4
	syscall
	
	move	$a0, $s1
	li		$v0, 1
	syscall
	
	# Exit
	li		$v0, 10
	syscall	
	
sqr:
	addi	$sp, $sp, -8
	sw		$a0, 4($sp)
	sw		$ra, 0($sp)
	
	beqz	$a1, return
	subi	$a1, $a1, 1
	
	jal		sqr
	lw		$a0, 4($sp)
	add		$s1, $a0, $s1
	
	return:
		lw		$ra, 0($sp)
		addi	$sp, $sp, 8
		jr		$ra
	
.data
	prompt1:	.asciiz	"Enter an integer: "
	result:		.asciiz "The square of the number: "