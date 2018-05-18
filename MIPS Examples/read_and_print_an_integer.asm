# Programe to read an integer number from user and
# print that number back to console

.text 
main:
	# Prompt for the integer to enter
	li $v0, 4
	la $a0, propmt
	syscall
	
	# Read the integer and save it to $s0
	li $v0, 5
	syscall
	move $s0, $v0
	
	# Output the text
	li $v0, 4
	la $a0, output
	syscall
	
	# Output the number
	li $v0, 1
	move $a0, $s0
	syscall
	
	# Exit program
	li $v0, 10
	syscall
	
.data 
	propmt: .asciiz "Please enter a integer: "
	output: .asciiz "\nYour typed number "