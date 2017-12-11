if (args.length != 1) {
    println("One argument is expected")
    System.exit(1)
}

def moves = [args[0].split(",")].flatten()
def moveMapper = { move ->
    switch (move) {
        case "n":
            return [-1, 1, 0]
        case "ne":
            return [0, 1, -1]
        case "nw":
            return [-1, 0, 1]
        case "s":
            return [1, -1, 0]
        case "se":
            return [1, 0, -1]
        case "sw":
            return [0, -1, 1]
        default:
            return [0, 0, 0]
    }
}
def moveSum = { left, right ->
    [left[0] + right[0], left[1] + right[1], left[2] + right[2]]
}

def numMoves = moves.collect(moveMapper)
                    .inject([0, 0, 0], moveSum)
                    .collect { it.abs() }
                    .sum() / 2

println(numMoves)
