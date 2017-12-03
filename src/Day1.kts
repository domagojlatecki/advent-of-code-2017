import kotlin.system.exitProcess

if (args.size != 1) {
    println("One argument is expected")
    exitProcess(1)
}

val list = args[0].toCharArray()
        .map(Character::getNumericValue)
        .filter { v -> v >= 0 }

if (list.isEmpty()) {
    println("0")
    exitProcess(0)
}

var sum = 0
var previous = list.last()
for (i in 0 until list.size) {
    val current = list[i]

    if (current == previous) {
        sum += current
    }

    previous = current
}

println(sum)
