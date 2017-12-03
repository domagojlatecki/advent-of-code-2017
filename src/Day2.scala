if (args.length == 0) {
    println("No arguments given")
    System.exit(1)
}

val sum = args.map(_.split("\\s+"))
              .map(_.map(_.toInt))
              .map(row => row.max - row.min)
              .sum

println(sum)
