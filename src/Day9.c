#include <stdio.h>
#include <string.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("One argument is expected\n");
        return 1;
    }

    int score = 0;
    int group = 0;
    int isGarbage = 0;
    int isIgnored = 0;
    int length = strlen(argv[1]);
    int index = 0;

    while (index < length) {
        char current = *(argv[1] + index);

        if (!isGarbage) {
            switch (current) {
                case '{':
                    group += 1;
                    break;
                case '}':
                    score += group;
                    group -= 1;
                    break;
                case '<':
                    isGarbage = 1;
                    break;
                default:
                    break;
            }
        } else if (!isIgnored) {
            switch (current) {
                case '>':
                    isGarbage = 0;
                    break;
                case '!':
                    isIgnored = 1;
                    break;
                default:
                    break;
            }
        } else {
            isIgnored = 0;
        }

        index += 1;
    }

    printf("%d\n", score);

    return 0;
}
