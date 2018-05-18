

#	Start .text segment(program code)
.text
#	Declare Main as a global function
.globl main
#	The lebel 'main' represent the starting code

main:
	
	li $s0, 0
	
	# scanf("%255s", string);
	# get string input	
	la $a0, string
	li $a1, 256
	li $v0, 8
	syscall
	
	# while(string[i] != '\0') {
	#	if(string[i] == 'm') {
	#	result = &string[i];
	#	break; 
	# 	}
	#	i++;
	# }
	
	move		$s0, $a0
	lb			$s1, m
	
	li		$t0, 0						# i = 0
	li		$t3, 0
	while: 
		add		$t4, $t0, $s0	
		lb		$t3, 0($t4)				# $t3 = string[i]
		beqz	$t3, not_found
		beq		$t3, $s1, found
		addi	$t0, $t0, 1
		j		while
		
		
	end_while:
	
	# printf("No match found\n");
	not_found:
		la		$a0, notMatch_prompt
		li		$v0, 4
		syscall
		j		EXIT
	
	# printf("First match at address %d\n", result);
	found:
		la		$s4, result
		sw		$t4, 0($s4)				# store result in result
		la		$a0, match_prompt
		li		$v0, 4
		syscall
		
		move	$a0, $t4
		li		$v0, 1
		syscall
		
		la		$a0, line_feed
		li		$v0, 4
		syscall
		
	
	convert:
	# Here we convert decimal to hexa decimal 
	# the value in $t4
		li		$t8, 8
		li		$t0, 0
		la		$s3, hex_result			# Store address where hexa address be stored
		li		$t1, 48					# hexa start with 0x
		li		$t2, 120
		sb		$t1, 0($s3)
		sb		$t2, 1($s3)
		addi	$t3, $s3, 2
		
		loop:
			beq		$t0, $t8, end_loop	# exit if loop execute 8 times
			rol		$t4, $t4, 4			# rotate 4 bits to left
			and		$t5, $t4, 0xf		# and with 1111
			bgt		$t5, 9, _add		
			addi	$t5, $t5, 48
			j		end
			
		_add:
			addi	$t5, $t5, 87
		end:
			sb		$t5, 0($t3)			# store hex digit
			addi	$t3, $t3, 1			# increment address counter
			addi	$t0, $t0, 1
			j		loop
			
		end_loop:
		
		
		# Print print_hex prompt
		la		$a0, print_hex
		li		$v0, 4
		syscall
		
		
		li		$t8, 10				# $t8 = 8
		li		$t0, 0				# $t0 = 0
		move	$t3, $s3
		
		print_loop:
			beq		$t0, 10, end_print_loop		# loop execute 10 times
			addi	$t3, $t3, 1					# increament address
			lb		$a0, 0($t3)					# load char to print 
			li		$v0, 11
			syscall
			addi	$t0, $t0, 1					
			j		print_loop
			
		end_print_loop:
			la		$a0, line_feed
			li		$v0, 4
			syscall
	
	# exit the program	
	EXIT:
		li		$v0, 10
		syscall
	
#	Start .data segment(Data!)
.data
	string: 		.space  256
	m: 				.byte  'm'
	result:			.word	0
	hex_result:		.space	12
	match_prompt: 	.asciiz  "First match at Address "
	print_hex:		.asciiz	 "\nHexa-decimal Address "
	notMatch_prompt: .asciiz "No Match Found\n"
	line_feed: 		.asciiz "\n"
		
	