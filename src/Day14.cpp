#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <iostream>

#define NUM_VALUES 256
#define DENSE_HASH_SIZE 16
#define NUM_ROWS 128
#define NUM_ROUNDS 64

using namespace std;

int _index = 0;
int _skip_size = 0;

void hash_round(int* values, char* lengths, int num_lengths) {
    for (int len_index = 0; len_index < num_lengths; len_index++) {
        int length = *(lengths + len_index);
        int end_index = _index + length - 1;

        for (int i = _index; i < end_index; i++) {
            int j = i % NUM_VALUES;
            int end = end_index - (i - _index);
            int k = end % NUM_VALUES;

            if (i >= end) {
                break;
            }

            int tmp = *(values + j);

            *(values + j) = *(values + k);
            *(values + k) = tmp;
        }

        _index += length + _skip_size;
        _skip_size += 1;
    }
}

int get_ones(char ch) {
    switch (ch) {
        case '0':
            return 0;
        case '1':
            return 1;
        case '2':
            return 1;
        case '3':
            return 2;
        case '4':
            return 1;
        case '5':
            return 2;
        case '6':
            return 2;
        case '7':
            return 3;
        case '8':
            return 1;
        case '9':
            return 2;
        case 'a':
            return 2;
        case 'b':
            return 3;
        case 'c':
            return 2;
        case 'd':
            return 3;
        case 'e':
            return 3;
        case 'f':
            return 4;
    }
}

int count_hash_ones(char* chars) {
    int* values = (int*) malloc(NUM_VALUES * sizeof(int));

    for (int i = 0; i < NUM_VALUES; i++) {
        *(values + i) = i;
    }

    _index = 0;
    _skip_size = 0;

    char* lengths = (char*) malloc((strlen(chars) + 6) * sizeof(char));

    sprintf(lengths, "%s%c%c%c%c%c", chars, 17, 31, 73, 47, 23);

    for (int i = 0; i < NUM_ROUNDS; i++) {
        hash_round(values, lengths, strlen(lengths));
    }

    int dense_hash;
    int ones_count = 0;
    char hash_part[2];

    for (int i = 0; i < DENSE_HASH_SIZE; i++) {
        dense_hash = 0;

        for (int j = 0; j < DENSE_HASH_SIZE; j++) {
            dense_hash ^= *(values + j + DENSE_HASH_SIZE * i);
        }

        sprintf(hash_part, "%02x", dense_hash);
        ones_count += get_ones(hash_part[0]);
        ones_count += get_ones(hash_part[1]);
    }

    free(values);
    free(lengths);

    return ones_count;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        cout << "One argument is expected" << endl;

        return 1;
    }

    int string_length = strlen(argv[1]);
    int count = 0;

    for (int i = 0; i < NUM_ROWS; i++) {
        char* appended = (char*) malloc((string_length + 10) * sizeof(char));

        sprintf(appended, "%s-%d", argv[1], i);
        count += count_hash_ones(appended);
        free(appended);
    }

    cout << count << endl;

    return 0;
}
