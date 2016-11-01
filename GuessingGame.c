#include<string.h>
#include<ncurses.h>
#include<time.h>
#include<stdlib.h>

char * selectWord(char *);
void checkWin(int);
int checkChar(char *, char *, char );
void output(char *, char *, int);



int row, col;
	int numGuessed = 0;
    char blankWord[25];
    char * guessedWord;
	char guessedLetters[26];
	char prompt[]="Enter your word: ";
	char charPrompt[]="Enter your guess: ";
	char guessesLeft[]="Guesses Left: ";

int main(int argc, char *argv[]) {	
    char currentGuess;

    int count = 5;

	initscr();
	noecho();
	curs_set(0);
	getmaxyx(stdscr, row, col);
    mvprintw(row/2,(col-strlen(prompt))/2, "%s", prompt);
	guessedWord = selectWord(argv[1]);
	echo();

    memset(blankWord, '_', strlen(guessedWord));
    mvprintw(row/4,(col-strlen(blankWord))/2, "%s", blankWord);
	move(row/2, 0);
	clrtoeol();
    mvprintw(row/2,(col-strlen(charPrompt))/2, "%s", charPrompt);
	output(guessedWord, blankWord, count);

    while (strcmp(guessedWord, blankWord) && count > 0) {
    currentGuess = getch();
        if (!checkChar(guessedWord, blankWord, currentGuess)) {
            count--;
        }
        output(guessedWord, blankWord, count);
    }
	
	clear();	
    checkWin(count);
	//curs_set(0);
	free(guessedWord);
	
	getch();
	endwin();
	
    return 0;

}
char * selectWord(char *fileName) {
		FILE *fp = NULL;
		char *words = malloc(20);
		int i = 0, ran = 0;
		srand(time(NULL));
		fp = fopen(fileName, "r+");
		for (; fgets(words, sizeof(words), fp);i++);
		ran = rand() %i;
		rewind(fp);
		for(i=0; i< ran; i++)
				fgets(words, sizeof(words), fp);
		return words;
}
void checkWin(int count) {

	start_color();
	use_default_colors();

    if (count) {
		char winStr[] = "You win!";	
		init_pair(1, COLOR_GREEN, -1);
		attron(COLOR_PAIR(1));
        mvprintw(row/2, (col-strlen(winStr))/2, "%s", winStr);
    } else {
		char loseStr[] = "You lose!";	
		init_pair(1, COLOR_RED, -1);
		attron(COLOR_PAIR(1));
        mvprintw(row/2, (col-strlen(loseStr))/2, "%s", loseStr);
    }
        mvprintw((row/2) + 4, (col-strlen(guessedWord))/2, "%s", guessedWord);
}

void output(char * guessedWord, char * blankWord, int count) {
    mvprintw(row/4,(col-strlen(blankWord))/2, "%s", blankWord);
    mvprintw((row/4) + 2,(col-strlen(guessesLeft))/2, "%s%d", guessesLeft, count);
    mvprintw(row-2,0, "%s", guessedLetters);
    move(row/2,(col+strlen(charPrompt)+1)/2);
}

int checkChar(char * guessedWord, char * blankWord, char c) {
    int check = 0;

    for (int i = 0; i < strlen(guessedWord); i++) {
        if (c == guessedWord[i]) {
            blankWord[i] = c;
            check++;
        }
    }
	guessedLetters[numGuessed++] = c;	
    return check; 
}
