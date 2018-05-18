# is 0 < x < 10 and even?
.text	
.globl main
main:
	lw		$t0, x
	sgt		$t1, $t0, $0
	rem		$t2, $t0, 2
	seq		$t2, $t2, $0
	and		$t1, $t1, $t2
	beqz	$t1, exit
	if:
		move	$a0, $t1
		li		$v0, 1
		syscall
exit:
	li		$v0, 10
	syscall
	
.data
	x:	.word	2