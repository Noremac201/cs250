#include<stdio.h>
#include<math.h>

void circumference(int a);
void area(int b);
void volume(int c);

int main(void) {
    void (*f[3])(int) = {circumference, area, volume};
    int radius;
    size_t choice;
    printf("%s", "Enter the radius: ");
    scanf("%u", &radius);
    printf("%s", "Enter a number between 0 and 2, 3 to end: ");
    scanf("%u", &choice);
    
    while(choice >= 0 && choice < 3) {
        (*f[choice])(radius);
        printf("%s", "Enter a number between 0 and 2, 3 to end: ");
        scanf("%u", &choice);
        printf("%s", "Enter the radius: ");
        scanf("%u", &radius);
    }
    puts("Program execution completed.");
}

void circumference(int a) {
    float circum = 2*a*M_PI;
    printf("Circumference: %f \n\n", circum);
}
void area(int b) {
    float area = M_PI*b*b;
    printf("Area: %f \n\n", area);
}
void volume(int c) {
    float volume = 4/3*M_PI*c*c*c;
    printf("Volume: %f \n\n", volume);
}
