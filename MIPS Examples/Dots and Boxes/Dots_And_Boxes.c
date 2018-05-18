#include<stdio.h>

unsigned int m_w;
unsigned int m_z;

char board[49];
char input1[3], input2[3];

int dir[] = {-7, -1, 1, 7};
int middlePoint[] = {8,10,12,22,24,26,36,38,40};
char playerName[] = {'C', 'M'};
int score[2] = {0,0};

int move;

void initialize_random()
{
    printf("Enter 1st initializer(must not be zero): ");
    scanf("%d", &m_w);
    printf("Enter 2nd initializer(must not be zero): ");
    scanf("%d", &m_z);
}

unsigned int get_random()
{
    m_z = 36969 * (m_z & 65535) + (m_z >> 16);
    m_w = 18000 * (m_w & 65535) + (m_w >> 16);
        return ( (m_z << 16) + m_w ); /* 32-bit result */
}

void initializeBoard()
{
    int i;
    for(i=0; i<49; i++)
    {
        if(i%2==1) board[i] = ' ';
        else if((i%7)%2 == 1) board[i] = ' ';
        else board[i] = '.';
    }
}


void showBoard()
{
    int i;
    char ch = 'a';
    printf("  1 2 3 4");
    for(i=0; i<49; i++)
    {
        if(i%14 == 0) printf("\n%c ",ch++);
        else if(i%7 == 0) printf("\n  ");
        printf("%c", board[i]);

    }
    printf("\n\n\n");

}

int isGameOver()
{
    if( score[0] >= 5 || score[1] >= 5)
        return 1;
    return 0;
}

int calcIndex(char* input)
{
    int x = (input[0] - 'a')*14 + (input[1] - '1')*2;

    return x;

}

int takeInput()
{
    int index1, index2;
    while(1)
    {
        printf("Enter 1st coordinate: ");
        scanf("%s",&input1);
        printf("Enter 2nd coordinate: ");
        scanf("%s",&input2);

        index1 = calcIndex(input1);
        index2 = calcIndex(input2);

        int diff = abs(index1 - index2);

        if(diff == 2 || diff == 14) break;

        printf("Invalid Input\n");
    }

    return (index1+index2)/2;


}
void makeMove()
{
    if((move%7)%2 == 1)
    {
        board[move] = '_';
        //printf("Horizontal move %d\n", move);
    }

    else
    {
        board[move] = '|';
        //printf("Vertical move %d\n", move);
    }
}

int countScore(int player)
{
    int i,j;
    int flag1, flag2 = 0;

    for(i=0; i<9; i++)
    {
        flag1 = 1;

        if(board[middlePoint[i]] == ' ')
        {
            for(j=0; j<4; j++)
            {
                int x = middlePoint[i]+dir[j];
                printf("%d", x);
                if(board[x]==' ')
                {
                    flag1 = 0;
                    break;
                }
            }
            if(flag1)
            {
                board[middlePoint[i]] = playerName[player];
                score[player]++;
                flag2 = 1;
            }

        }

    }

    return flag2;

}


void playGame(int player)
{
    if(player == 0)
        printf("Computer's turn: \n");

    while(1)
    {
        if(player == 0)
        {
            //printf("Computer's turn: \n");
            move = get_random() % 49;

            if(move%2 == 0) continue;

            if(board[move] != ' ')
            {
                continue;
            }

            makeMove();

            if(!countScore(player))
            {
                showBoard();
                break;
            }

            showBoard();
            printf("\t\tScore: %d - %d\n",score[0], score[1]);

            if(isGameOver())
                break;
        }
        else
        {
            printf("Your turn: \n");
            move = takeInput();

            if(board[move] != ' ')
            {
                printf("Line already exists!\n");
                continue;
            }

            makeMove();

            if(!countScore(player))
            {
                showBoard();
                break;
            }

            showBoard();
            printf("\t\tScore: %d - %d\n",score[0], score[1]);

            if(isGameOver())
                break;
        }
    }


}



int main()
{
    initialize_random();
    initializeBoard();
    showBoard();

    printf("\t\tScore: %d - %d\n",score[0], score[1]);

    int player = ( get_random() + get_random()) % 2;

    while(1)
    {
        playGame(player);
        player = !player;
        printf("\t\tScore: %d - %d\n",score[0], score[1]);
        if(isGameOver())
            break;

    }

    showBoard();

    if(score[0] > score[1])
        printf("\n\nPC win!!!\n");
    else if(score[0] < score[1])
        printf("\n\nYou win!!!\n");
    else
        printf("\n\nDraw!\n");
    printf("PC's Score: %d\n", score[0]);
    printf("Your Score: %d\n", score[1]);

    return 0;
}
