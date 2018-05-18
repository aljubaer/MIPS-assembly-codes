# Program to read a string from a user and
# print that string back to the console 

.text
main:
	# Prompt fot the string to enter 
	li $v0, 4
	la $a0, prompt
	syscall
	
	# Read the string 
	li $v0, 8
	la $a0, input
	lw $a1, inputSize
	syscall
	
	# Prompt the output
	li $v0, 4
	la $a0, output
	syscall
	
	# Output the string
	li $v0, 4
	la $a0, input
	syscall
	
	# Exit the program
	li $v0, 10
	syscall
	
.data
	input:		.space 81
	inputSize:	.word 80
	prompt:		.asciiz "Enter a string: "
	output:		.asciiz "\nYou typed the string: "	