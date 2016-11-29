#include<stdio.h>
#include<string.h>
#include<stdlib.h>

#define MAX_NUMS 20
#define MAX_STR_LEN 25

void InsertionSort(char list[][MAX_STR_LEN], int);

int main() {
    int index;
    int count;
    char words[MAX_NUMS][MAX_STR_LEN];

    printf("Enter a line of up to %d words to be sorted,"
		   " terminated by a period.\n", MAX_NUMS);
    
    for (index = 0; index < MAX_NUMS; index++) {
        scanf("%s", words[index]);
	if (strchr(words[index], '.')) {
	    words[index][strlen(words[index]) - 1] = '\0';
	    break;
	}
    }
    //index is now equal to the size of the array that is used.
    index++;
    InsertionSort(words, index);
    printf("\nThe input set, in ascending order:\n");
    for (count = 0; count < index; count++){
        printf("%s\n", words[count]);
    }
}

void InsertionSort(char list[][MAX_STR_LEN], int index) {
    int unsorted;
    int sorted;
    char *temp;

    for (unsorted = 1; unsorted < index; unsorted++) {
        temp = list[unsorted];
        for (sorted = unsorted -1; (sorted >= 0) && (strcmp(list[sorted],temp) > 0); sorted--) 
		strcpy(list[sorted + 1], list[sorted]);
	strcpy(list[sorted + 1],temp);
    }
}
