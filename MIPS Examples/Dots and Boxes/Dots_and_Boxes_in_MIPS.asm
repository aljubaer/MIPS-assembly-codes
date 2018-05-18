# Program 	: DOTS AND BOXES GAME 3 X 3
# Author 	: Toukir Ahmed 
#			  Abdullah Al Jubaer
#			  ABA Kawser 


# Global data
.data
#unsigned int m_w;
m_w:			.word	0
#unsigned int m_z;
m_z:			.word	0
#char board[49];
board_size:		.word	49
board:			.byte	0:49

#char input1[3], input2[3];
input1_size:	.word	3
input1:			.asciiz	""	
input2_size:	.word	3
input2:			.asciiz	""	
#int dir[] = {-7, -1, 1, 7};
dir:			.word	-7, -1, 1, 7
#int middlePoint[] = {8,10,12,22,24,26,36,38,40};
middlePoint:	.word	8, 10, 12, 22, 24, 26, 36, 38, 40
#char playerName[] = {'C', 'M'};
playerName:		.byte	'C', 'M'
#int score[2] = {0,0};
score:			.word	0, 0
#int move;
_move:			.word	0
#
line_feed:		.asciiz	"\n"
d_line_feed:	.asciiz	"\n\n"
t_line_feed:	.asciiz	"\n\n\n"
space:			.asciiz " "
d_space:		.asciiz "  "

#void initialize_random();
#unsigned int get_random();
#void initializeBoard();
#void showBoard();
#int isGameOver();
#int calcIndex(char* input);
#int takeInput();
#void makeMove();
#int countScore(int player);
#void playGame(int player);
#
.text
.globl main
main:
#int main()
#{
#    initialize_random();
	jal		initialize_random
#	jal		get_random
#    initializeBoard();
	jal		initializeBoard
#    showBoard();
	jal		showBoard

	la		$s3, score
	lw		$s1, ($s3)
	lw		$s2, 4($s3)
	
#    printf("\t\tScore: %d - %d\n",score[0], score[1]);
	la		$a0, tt_scr
	li		$v0, 4
	syscall
	
	move	$a0, $s1
	li		$v0, 1
	syscall
	
	la		$a0, sp_m
	li		$v0, 4
	syscall
	
	move	$a0, $s2
	li		$v0, 1
	syscall
	
	la		$a0, line_feed
	li		$v0, 4
	syscall
	
#    int player = ( get_random() + get_random()) % 2;

	# $s0 : player
	jal		get_random
	move	$t0, $v0
	
	jal		get_random
	move 	$t1, $v0
	
	addu	$s0, $t0, $t1
	li		$t2, 2
	divu	$s0, $t2
	#rem		$s0, $s0, $t2
	mfhi	$s0
	
	
#    while(1)
	main_while:
	
#        playGame(player);
		move	$a0, $s0
		jal		playGame
#        player = !player;
		li		$s1, 1
		sub		$s0, $s1, $s0
		
		la		$s3, score
		lw		$s1, ($s3)
		lw		$s2, 4($s3)
	
#        printf("\t\tScore: %d - %d\n",score[0], score[1]);

		la		$a0, tt_scr
		li		$v0, 4
		syscall
	
		move	$a0, $s1
		li		$v0, 1
		syscall
		
		la		$a0, sp_m
		li		$v0, 4
		syscall
		
		move	$a0, $s2
		li		$v0, 1
		syscall
		
		la		$a0, line_feed
		li		$v0, 4
		syscall
		
#        if(isGameOver())
		jal		isGameOver
		move	$t0, $v0
		bne		$t0, $0, end_main_while				# break;

		j		main_while
		
	end_main_while:
#    showBoard();
	jal		showBoard
	
#    if(score[0] > score[1])
	ble		$s1, $s2, scr_elseif
#        printf("\n\nPC win!!!\n");
		la		$a0, PC_win
		li		$v0, 4
		syscall
		
		j		scr_end
		
	scr_elseif:
#    else if(score[0] < score[1])
		bge		$s1, $s2, scr_else
#        printf("\n\nYou win!!!\n");
		la		$a0, U_win
		li		$v0, 4
		syscall
		
		j		scr_end
		
#    else
	scr_else:
#        printf("\n\nDraw!\n");
		la		$a0, Draw
		li		$v0, 4
		syscall
	scr_end:

	la		$s3, score
	lw		$s1, ($s3)
	lw		$s2, 4($s3)
		
#    printf("PC's Score: %d\n", score[0]);
	la		$a0, PC_scr
	li		$v0, 4
	syscall
	
	move		$a0, $s1
	li		$v0, 1
	syscall
	
#    printf("Your Score: %d\n", score[1]);

	la		$a0, U_scr
	li		$v0, 4
	syscall
	
	move	$a0, $s2
	li		$v0, 1
	syscall

	# Exit the programe
	li		$v0, 10
	syscall

.data
	tt_scr:		.asciiz	"\t\tScore: "
	sp_m:		.asciiz	" - "
	PC_win:		.asciiz "\n\nPC win!!!\n"
	U_win:		.asciiz	"\n\nYou win!!!\n"
	Draw:		.asciiz	"\n\nDraw!\n"
	PC_scr:		.asciiz	"\nPC's Score: "
	U_scr:		.asciiz	"\nYour Score: "
	

.text
########################## void initialize_random() #########################
initialize_random:
#    print("Enter 1st initializer(must not be zero): ");
	la		$a0, init_1st_prompt
	li		$v0, 4
	syscall
	
#    scanf("%d", &m_w);
	li		$v0, 5
	syscall
	sw		$v0, m_w
	
	
#    printf("Enter 2nd initializer(must not be zero): ");
	la		$a0, init_2nd_prompt
	li		$v0, 4
	syscall

#    scanf("%d", &m_z);

	li		$v0, 5
	syscall
	sw		$v0, m_z
	
	jr		$ra
	
.data
	init_1st_prompt: .asciiz	"Enter 1st initializer(must not be zero): "
	init_2nd_prompt: .asciiz	"Enter 2nd initializer(must not be zero): "


.text
################################ unsigned int get_random() ####################
get_random:

#    m_z = 36969 * (m_z & 65535) + (m_z >> 16);
	li		$t1, 36969
	lw		$t3, m_z
	srl		$t4, $t3, 16			# m_z >> 16
	andi	$t2, $t3, 65535			# m_z & 65535
	mulu	$t3, $t1, $t2
	addu	$t3, $t3, $t4			# (m_z & 65535) + (m_z >> 16)
	
	sw		$t3, m_z

#    m_w = 18000 * (m_w & 65535) + (m_w >> 16);
	
	li		$t1, 18000
	lw		$t3, m_w
	srl		$t4, $t3, 16			# m_w >> 16
	andi	$t2, $t3, 65535			# m_w & 65535
	mul		$t3, $t1, $t2
	addu	$t4, $t3, $t4			# 18000 * (m_w & 65535) + (m_w >> 16)
	
	sw		$t4, m_w
	
# return ( (m_z << 16) + m_w ); /* 32-bit result */
	sll		$t0, $t3, 16
	addu	$v0, $t0, $t4
	
	jr		$ra

.text
##########################void initializeBoard() ######################
initializeBoard:
#{
#    int i;
	move	$t0, $zero
	li		$t1, 49
	li		$t2, 2
	li		$t7, 1
	la		$t9, board
#    while( i<49; i++)
	start_iBWhile:
		bge		$t0, $t1, end_iBWhile
		add		$t8, $t0, $zero
		add		$t8, $t9, $t8
#    {
#        if(i%2==1) board[i] = ' ';
			div		$t3, $t0, $t2
			mfhi	$t3
			beq		$t3, $zero, iB_else_if
		
			lb		$t6, IB_ch_sp
			sb		$t6, ($t8)
			j		end_IB_cond
			
#        else if((i%7)%2 == 1) board[i] = ' ';
		iB_else_if:
			li		$t4, 7
			rem		$t3, $t0, $t4
			rem		$t3, $t3, $t2
			beqz	$t3, iB_else
			lb		$t6, IB_ch_sp
			sb		$t6, ($t8)
			j		end_IB_cond
#        else board[i] = '.';
		iB_else:
			lb		$t6, IB_ch_dot
			sb		$t6, ($t8)
		end_IB_cond:
		addi	$t0, $t0, 1
		j		start_iBWhile
#    }
	end_iBWhile:
	jr		$ra

.data
	IB_ch_sp:	.byte	' '
	IB_ch_dot:	.byte	'.'
	
	
.text
##################### void showBoard() #####################
showBoard:
#{
#    int i;
	add		$t0, $zero, $zero
	addi	$t1, $zero, 49
	addi	$t3, $zero, 14
	addi	$t4, $zero, 7
	la		$t8, board
#    char ch = 'a';
	addi	$t9, $zero, 97
#    printf("  1 2 3 4");
	la		$a0, sB_prompt
	li		$v0, 4
	syscall
#    for(; i<49; i++)
	sB_start_for:
#    {
			bge		$t0, $t1, sB_end_for
#        if(i%14 == 0) printf("\n%c ",ch++);
			div		$t5, $t0, $t3
			mfhi	$t5
			bnez	$t5, sB_else_if
		
			la		$a0, line_feed
			li		$v0, 4
			syscall
		
			move	$a0, $t9
			li		$v0, 11
			syscall
			addi	$t9, $t9, 1
		
			la		$a0, space
			li		$v0, 4
			syscall
			j		sB_end_ifelse
#        else if(i%7 == 0) printf("\n  ");
		sB_else_if:
			rem		$t5, $t0, $t4
			bnez	$t5, sB_else
		
			la		$a0, line_feed
			li		$v0, 4
			syscall
		
			la		$a0, d_space
			li		$v0, 4
			syscall
		sB_else:
		sB_end_ifelse:
		
#        printf("%c", board[i]);
		add		$t7, $t8, $t0
		lb		$t7, ($t7)
		move 	$a0, $t7
		li		$v0, 11
		syscall
#
#    }
	addi	$t0, $t0, 1
	j		sB_start_for
	sB_end_for:
#    printf("\n\n\n");
	la		$a0, t_line_feed
	li		$v0, 4
	syscall
	
	jr		$ra
#}
.data	
	sB_prompt:	.asciiz	"  1 2 3 4"

.text
################################## int isGameOver() #########################
isGameOver:
#    if( score[0] >= 5 || score[1] >= 5)
	lw		$t0, score
	la		$t1, score
	lw		$t1, 4($t1)
	li		$t5, 5
	bge		$t0, 5 GO_return_1
	blt		$t1, 5 GO_return_0
	
#   return 1;
	GO_return_1:
	li		$v0, 1
	jr		$ra
	

#    return 0;

	GO_return_0:
	li		$v0, 0
	jr		$ra


#int calcIndex(char* input)
#{
#    int x = (input[0] - 'a')*14 + (input[1] - '1')*2;
#
#    return x;
#}

.text
########################## int takeInput() ##########################
takeInput:

#    int index1, index2;
#	register convention:
#		$s1 : index1
#		$s2 : index2
#    while(1)
	TI_while:
#    {
#        printf("Enter 1st coordinate: ");
		la		$a0, TI_prompt1
		li		$v0, 4
		syscall
		
#        scanf("%s",&input1);
		la		$a0, input1
		li		$a1, 4
		li		$v0, 8
		syscall
		
#        printf("Enter 2nd coordinate: ");
		la		$a0, TI_prompt2
		li		$v0, 4
		syscall
#        scanf("%s",&input2);

		la		$a0, input2
		li		$a1, 4
		li		$v0, 8
		syscall
		
		#if(input[0] < 'a' || input[0] > 'd' || input[1] < '1' || input[1] > '4' )
		lb $t0,input1
		blt $t0,97,isValid
		bgt $t0,100,isValid
		la $t0,input1
		lb $t0,1($t0)
		blt $t0,49,isValid
		bgt $t0,52,isValid
		
		#if(input[0] < 'a' || input[0] > 'd' || input[1] < '1' || input[1] > '4' )
		lb $t0,input2
		blt $t0,97,isValid
		bgt $t0,100,isValid
		la $t0,input2
		lb $t0,1($t0)
		blt $t0,49,isValid
		bgt $t0,52,isValid
#
		
#        index1 = (input1[0] - 'a')*14 + (input1[1] - '1')*2;
#        int x = (input[0] - 'a')*14 + (input[1] - '1')*2;
		li		$t5, 14
		li		$t6, 2
		la		$t0, input1
		lb		$t1, input1
		subiu	$t1, $t1, 97
		mult	$t1, $t5
		mflo	$t1
		
		move	$s1, $t1
		
		addi	$t1, $t0, 1
		lb		$t1, 1($t0)
		subiu	$t1, $t1, 49
		multu	$t1, $t6
		mflo	$t1
		
		addu	$s1, $s1, $t1
		
#        index2 = calcIndex(input2);

		li		$t5, 14
		li		$t6, 2
		la		$t0, input2
		lb		$t1, input2
		subiu	$t1, $t1, 97
		multu	$t1, $t5
		mflo	$t1
		move	$s2, $t1
		
		addi	$t1, $t0, 1
		lb		$t1, 1($t0)
		subiu	$t1, $t1, 49
		multu	$t1, $t6
		mflo	$t1

		addu	$s2, $s2, $t1
#
#        int diff = abs(index1 - index2);
		sub		$t0, $s1, $s2
		abs		$t0, $t0
#
#        if(diff == 2 || diff == 14) break;
		li		$t2, 2
		li		$t3, 14
		beq		$t0, $t2, TI_while_break
		beq		$t0, $t3, TI_while_break
#
#        printf("Invalid Input\n");
		la		$a0, TI_Err_prompt
		li		$v0, 4
		syscall
		j		TI_while
#    }
	TI_while_break:
#    return (index1+index2)/2;
	addu	$v0, $s1, $s2
	div		$v0, $v0, $t2
	
	jr		$ra
###### valid input Check ######
isValid:
	la $a0,TI_Err_prompt
	li $v0,4
	syscall
	j TI_while

.data
	TI_prompt1:		.asciiz		"Enter 1st coordinate: "
	TI_prompt2:		.asciiz		"Enter 2nd coordinate: "
	TI_Err_prompt:	.asciiz		"Invalid Input\n"


.text
############################ void makeMove() ###########################
makeMove:
	la		$t8, board
	lw		$t0, _move
#    if((move%7)%2 == 1)
	li		$t7, 7
	li		$t2, 2
	rem		$t1, $t0, $t7
	rem		$t1, $t1, $t2
	add		$t5, $t8, $t0
	beqz	$t1, MM_else
	
	lb		$t6, H_Line
# printf("draw line between: %c%d and %c%d\n", move/14 + 'a', (move%7)/2+1, move/14 + 'a', (move%7)/2+2);	
	
	la $a0,msg
	li $v0,4
	syscall

	div $s3,$t0,14
	add $s3,$s3,97
	move $a0,$s3
	li $v0,11
	syscall
	
	rem $s3,$t0,7
	div $s3,$s3,2
	addi $s3,$s3,1
	move $a0,$s3
	li $v0,1
	syscall
	
	la $a0,msg1
	li $v0,4
	syscall
	
	div $s3,$t0,14
	add $s3,$s3,97
	move $a0,$s3
	li $v0,11
	syscall
	
	rem $s3,$t0,7
	div $s3,$s3,2
	addi $s3,$s3,2
	move $a0,$s3
	li $v0,1
	syscall
	
	la $a0,endLine
	li $v0,4
	syscall
	
	j		MM_end
#        board[move] = '_';
#    else
	MM_else:
	lb		$t6, V_Line
#printf("draw line between: %c%d and %c%d\n", move/14 + 'a', (move%7)/2+1, move/14+1 + 'a', (move%7)/2+1);
	la $a0,msg
	li $v0,4
	syscall

	div $s3,$t0,14
	add $s3,$s3,97
	move $a0,$s3
	li $v0,11
	syscall
	
	rem $s3,$t0,7
	div $s3,$s3,2
	addi $s3,$s3,1
	move $a0,$s3
	li $v0,1
	syscall
	
	la $a0,msg1
	li $v0,4
	syscall
	
	div $s3,$t0,14
	add $s3,$s3,98
	move $a0,$s3
	li $v0,11
	syscall
	
	rem $s3,$t0,7
	div $s3,$s3,2
	addi $s3,$s3,1
	move $a0,$s3
	li $v0,1
	syscall
	
	la $a0,endLine
	li $v0,4
	syscall

#        board[move] = '|';
	MM_end:
	sb		$t6, ($t5)
	jr		$ra



.data
	H_Line:	.byte	'_'
	V_Line:	.byte	'|'
	msg: .asciiz "drew line between : "
	msg1: .asciiz " and "
	endLine: .asciiz "\n"
	


.text	
######################### int countScore(int player) #######################
countScore:
#{
#    int i,j;
	li	 	$t0, 0					# $t0 : i
	li		$t1, 0					# $t1 : j
#    int flag1, flag2 = 0;
	li		$t8, 0
	li		$t9, 0
	
	li		$s6, 9
	li		$s7, 4
	
	la		$s4, board
	la		$s5, middlePoint
	move	$s0, $a0
#
#    for(i=0; i<9; i++)
	CS_for_outer:
		bge		$t0, $s6, CS_end_for_outer
#        flag1 = 1;
		li		$t8, 1
#        if(board[middlePoint[i]] == ' ')
		la		$s4, board
		la		$s5, middlePoint
		sll		$t2, $t0, 2
		addu	$t2, $t2, $s5
		lw		$t3, 0($t2)
		
		addu	$s2, $s4, $t3
		lb		$t4, 0($s2)					# $t3 : middlePoint[i]
		lb		$t5, IB_ch_sp				# $t4 : board[middlePoint[i]]
		move    $t6, $0
		seq		$t6, $t4, $t5
		#move	$v1, $t6
		beqz	$t6, CS_end_if_outer
		
		#bne		$t4, $t5, CS_end_if_outer
#        {
#            for(j=0; j<4; j++)
			li		$t1, 0
			CS_for_inner:
			bge		$t1, $s7, CS_end_for_inner
#            {
#                int x = middlePoint[i]+dir[j];
					
				li		$v0, 1
				sll		$t7, $t1, 2
				la		$t6, dir
				add		$t6, $t6, $t7
				lw		$t6, ($t6)
				add		$t6, $t3, $t6
				lb		$t5, IB_ch_sp
#                if(board[x]==' ')
				add		$t6, $t6, $s4
				lb		$t6, ($t6)
				seq		$t5, $t5, $t6
				beqz	$t5, CS_iif
				#bne		$t5, $t6, CS_iif
#                {
					
#                    flag1 = 0;
					li		$t8, 0
#                    break;
					b		CS_end_for_inner
#                }
				CS_iif:
				addi	$t1, $t1, 1
				j		CS_for_inner
#            }
			CS_end_for_inner:
#            if(flag1)
			beqz	$t8,  CS_end_if_outer
			
#            {
#                board[middlePoint[i]] = playerName[player];
				
				la		$t6, playerName
				add		$t7, $t6, $s0
				lb		$t7, ($t7)
				sb		$t7, ($s2)
#               score[player]++;

				la		$t6, score
				sll		$t7, $s0, 2
				add		$t7, $t6, $t7
				lw		$t6, ($t7)
				addi	$t6, $t6, 1
				sw		$t6, ($t7)
#                flag2 = 1;
				li		$t9, 1
#            }
#        }
		CS_end_if_outer:
		addi	$t0, $t0, 1
		j		CS_for_outer
#    }
	CS_end_for_outer:
#
	move	$v0, $t9
	jr		$ra
#    return flag2;
#
#}
.text
############################# void playGame(int player) #######################
playGame:
#{
	addi	$sp, $sp, -4
	sw		$ra, 0($sp)
	
	move	$s0, $a0
#    if(player == 0)
	bnez	$s0, PG_if2
#        printf("Computer's turn: \n");
		li		$v0, 4
		la		$a0, PT_prompt
		syscall
		
#    while(1)
	PG_while:
#    {
#        if(player == 0)
#        {
		bnez	$s0, PG_if2
#            move = get_random() % 49;
			# $s1 : _move
			jal		get_random
			move	$s1, $v0
			li		$t7, 49
			rem		$s1, $s1, $t7
			sw		$s1, _move
#
#            if(move%2 == 0) continue;
			li		$t2, 2
			rem		$t3, $s1, $t2
			beqz	$t3, PG_while
#
#            if(board[move] != ' ')
#            {
			la		$t4, board
			add		$t4, $t4, $s1
			lb		$t4, ($t4)
			lb		$t5, IB_ch_sp
			bne		$t4, $t5, PG_while
#                continue;
#            }
#
#            makeMove();
			jal		makeMove
#
#            if(!countScore(player))
#            {
			move	$a0, $s0
			jal		countScore
			move	$t4, $v0
			bnez	$t4, PG_if4
#                showBoard();
				jal		showBoard
#                break;
				j		PG_end_while
#            }
			PG_if4:
#            showBoard();
			jal		showBoard
#            printf("\t\tScore: %d - %d\n",score[0], score[1]);
			la		$s3, score
			lw		$s4, ($s3)
			lw		$s5, 4($s3)
			
			la		$a0, tt_scr
			li		$v0, 4
			syscall
	
			move	$a0, $s4
			li		$v0, 1
			syscall
		
			la		$a0, sp_m
			li		$v0, 4
			syscall
		
			move	$a0, $s5
			li		$v0, 1
			syscall
			
#            if(isGameOver())
			jal		isGameOver
			bne		$v0, $0, PG_end_while
#                break;
			
#        }
		PG_if2:
#        else
#        {
#            printf("Your turn: \n");
			la		$a0, UT_prompt
			li		$v0, 4
			syscall
#            move = takeInput();
			jal		takeInput
			move	$s1, $v0
			sw		$s1, _move
#
			
#            if(board[move] != ' ')
			la		$t4, board
			add		$t4, $t4, $s1
			lb		$t5, ($t4)
			lb		$t6, IB_ch_sp
#            {
			#beq		$t5, $t6, PG_if11
			sne		$t5, $t5, $t6

			beqz	$t5, PG_if11
#                printf("Line already exists!\n");
				li		$v0, 4
				la		$a0, Err_ext
				syscall
				j		PG_while
#                continue;
#            }
			PG_if11:
#
#            makeMove();

			jal		makeMove
#
#            if(!countScore(player))
#            {
				li		$v0, 1
				move	$a0, $s0
				jal		countScore
				move	$t4, $v0
				bnez	$t4, PG_if12
#             showBoard();
				jal		showBoard
#                break;
				j		PG_end_while
#            }
			PG_if12:
#
#            showBoard();
			jal		showBoard
#            printf("\t\tScore: %d - %d\n",score[0], score[1]);
#
			la		$s3, score
			lw		$s4, ($s3)
			lw		$s5, 4($s3)
			
			la		$a0, tt_scr
			li		$v0, 4
			syscall
	
			move	$a0, $s4
			li		$v0, 1
			syscall
		
			la		$a0, sp_m
			li		$v0, 4
			syscall
		
			move	$a0, $s5
			li		$v0, 1
			syscall
			
			la		$a0, line_feed
			li		$v0, 4
			syscall

#            if(isGameOver())
			jal		isGameOver
			bne		$v0, $0, PG_end_while
#               break;
				
#           
#        }
		j	PG_while
#    }
	PG_end_while:
	
	lw		$ra, 0($sp)
	addi	$sp, $sp, 4

	jr		$ra
#}

.data
	PT_prompt:	.asciiz	"Computer's turn: \n"
	UT_prompt:	.asciiz	"Your turn: \n"
	Err_ext:	.asciiz	"Line already exists!\n"
