# Code in Code
# int n = printf("Enter a value for the summetionn, -1 to stop");
# while (n != -1){
# 	if (n < -1)printf("Negative input is invalid");
#	else {
#		int total = 0;
#		for (int i = 0; i < n; i++){
#			total += i;
#		}
#		printf("The summation is %d", total);
#	}
# }

.text
.globl main 
main:
	# Outer loop (Sentinel control loop)
	start_outer_loop:

		# Print the input prompt
		la		$a0, prompt
		li		$v0, 4
		syscall
	
		# Read the input
		li		$v0, 5
		syscall
		move 	$s0, $v0
	
		# Loop condition
		sne		$t0, $s0, -1
		beqz	$t0, end_outer_loop
		
		# Test for valid input
		slti	$t0, $s0, -1
		beqz	$t0, else
		la		$a0, error
		li		$v0, 4
		syscall
		j		end_brnch
		
		else:
			li		$s1, 0
			li		$t1, 0
			# Inner loop (counter control)
			start_inner_loop:
				add		$s1, $s1, $t1         # total = total + i
				addi	$t1, $t1, 1			  # i = i + 1
				bgt		$t1, $s0, end_inner_loop
				j		start_inner_loop
				
			end_inner_loop:	
			# Print output prompt	
			la		$a0, output
			li 		$v0, 4
			syscall
			
			# Print result
			li 		$v0, 1
			move	$a0, $s1
			syscall
			
			# Print new line 
			la		$a0, line_feed
			li		$v0, 4
			syscall
			
		end_brnch:
		j	start_outer_loop
	
	# End outer loop
	end_outer_loop:
		
Exit:
	li		$v0, 10
	syscall
			
.data
	prompt:		.asciiz		"Enter an integer, -1 to stop: "
	error:		.asciiz		"Negative input is invalid.\n"
	output:		.asciiz		"The summation is "
	line_feed:	.asciiz		"\n"
