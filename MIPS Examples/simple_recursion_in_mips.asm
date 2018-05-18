#Simple recursive function in mips

.text
.globl main
main:
# Print the prompt
	la		$a0, prompt
	li		$v0, 4
	syscall
# Get the input
	li		$v0, 5
	syscall	
	move	$s0, $v0
# Call a recursive function	
	jal rec_func
	
# Exit the program
	li		$v0, 10
	syscall
	
.globl rec_func
rec_func:
# Push $ra in the stack
	subi	$sp, $sp, 4
	sw		$ra, 0($sp)
# Base condition	
	seq 	$t0, $s0, $zero
	bnez	$t0, return
	
	addi	$s0, $s0, -1
	jal 	rec_func
	
	return:
# Pop the stack
	lw		$ra, 0($sp)
	addi 	$sp, $sp, 4
	jr		$ra	
	
.data
	prompt:	.asciiz	"Enter a integer "
	
	
	
