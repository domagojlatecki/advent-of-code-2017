$num_args = $#ARGV + 1;

if ($num_args != 1) {
    print "One argument is expected\n";
    exit 1;
}

@items = ("a".."p");
@moves = split /,/, $ARGV[0];

foreach $move (@moves) {
    if ($move =~ /s([0-9]+)/) {
        @items = (@items[($#items - $1 + 1)..$#items], @items[0..($#items - $1)]);
    } elsif ($move =~ /x([0-9]+)\/([0-9]+)/) {
        @items[$1, $2] = @items[$2, $1];
    } elsif ($move =~ /p([a-z])\/([a-z])/) {
        $index_1 = 0;
        $index_2 = 0;
        ++$index_1 until $items[$index_1] eq $1 or $index_1 > $#items;
        ++$index_2 until $items[$index_2] eq $2 or $index_2 > $#items;
        @items[$index_1, $index_2] = @items[$index_2, $index_1];
    }
}

print @items;
print "\n";
