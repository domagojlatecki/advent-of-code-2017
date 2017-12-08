declare var process: {
    argv: Array<string>
    exit(): void
}

if (process.argv.length <= 2) {
    console.log("No arguments given")
    process.exit()
}

let lines = process.argv.slice(2)
let count: {
    [key: string]: number
} = {}

function conditionSatisfied(left: number, operator: string, right: number): boolean {
    switch (operator) {
        case ">": {
            return left > right
        }
        case "<": {
            return left < right
        }
        case "==": {
            return left == right
        }
        case ">=": {
            return left >= right
        }
        case "<=": {
            return left <= right
        }
        case "!=": {
            return left != right
        }
        default: {
            return false
        }
    }
}

function getAmount(command: string, value: number) {
    if (command == "inc") {
        return value
    } else if (command == "dec") {
        return -value
    } else {
        return 0
    }
}

for (let line of lines) {
    let split: Array<string> = line.split(/\s+/)
    let register: string = split[0]
    let command: string = split[1]
    let value: number = Number(split[2])
    let left: string = split[4]
    let operator: string = split[5]
    let right: number = Number(split[6])

    if (!(register in count)) {
        count[register] = 0
    }

    if (!(left in count)) {
        count[left] = 0
    }

    if (conditionSatisfied(count[left], operator, right)) {
        count[register] += getAmount(command, value)
    }
}

var max = 0

for (let k in count) {
    if (count[k] > max) {
        max = count[k]
    }
}

console.log(max)
