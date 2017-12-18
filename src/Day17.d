import std.stdio;
import std.container: Array;
import std.conv;
import std.c.stdlib;

enum SIZE = 2017;

void main(string[] args) {
    if (args.length != 2) {
       writeln("One arguemnt is expected");
       exit(1);
    }

    int index = 0;
    int number = 1;
    int skipSize = to!int(args[1]);
    auto numbers = Array!int(0);

    numbers.reserve(SIZE);

    for (int i = 0; i < SIZE; i++) {
        index += skipSize;
        index %= numbers.length;
        numbers.insertAfter(numbers[0..index + 1], number);
        index += 1;
        number += 1;
    }

    writeln(numbers[index + 1]);
}
