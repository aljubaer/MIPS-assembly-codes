#A recursive function which causes stack overflow
#Code in C
#void function(){
#	function();
#}
#void main(){
#	function();
#}

.text
# Main function
.globl main
main:
	# Call a recursive function
	jal inf_func
	
	# Exit the program
	li		$v0, 10
	syscall
	
# inf_func
inf_func:
# Push return address in the stack
	subi	$sp, $sp, 4
	sw		$ra, 0($sp)
	
	jal inf_func
	