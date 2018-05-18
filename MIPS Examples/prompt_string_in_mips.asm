.text
main:
	la		$a0, prompt1
	li		$a1, 80
	jal		PromptString
	move	$a0, $v0
	li 		$v0, 4
	syscall
	
Exit:
	li		$v0, 10
	syscall
	
	
.data
	prompt1: .asciiz "Enter the first string: "
	prompt2: .asciiz "Enter the second string: "
	
# Subprogram:  PromptString
	
.text
PromptString:
	addi	$sp, $sp, -12
	sw		$ra, 0($sp)
	sw		$a1, 4($sp)
	sw 

.data













