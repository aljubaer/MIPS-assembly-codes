# Purpose:	This program shows that adding 0x20 to a character 
#			can result in an error when converting case, but
#			or'ing 0x20 always works
.text 
.globl main
main:
	# Show adding works if character is only in upper case 
	ori		$v0, $zero, 4
	la		$a0, output1
	syscall
	ori 	$t0, $zero, 65
	addi	$t0, $t0, 32
	or		$a0, $t0, $0
	ori		$v0, $0, 11
	syscall
	
	# Show adding not work if charcter is in lower case
	
	ori		$v0, $zero, 10
	syscall
	
.data
	output1: .asciiz "Valid convertion"