package main

import "fmt"
import "os"
import "regexp"
import "reflect"

func main() {
    if len(os.Args) == 1 {
        fmt.Println("No arguments given")
        os.Exit(1)
    }

    inputs := os.Args[1:]
    length := len(inputs)
    mainSplitter := regexp.MustCompile("\\s*<->\\s*")
    subSplitter := regexp.MustCompile("\\s*,\\s*")
    transitions := map[string][]string {}

    for i := 0; i < length; i++ {
        split := mainSplitter.Split(inputs[i], 2)
        key := split[0]
        values := subSplitter.Split(split[1], -1)
        transitions[key] = values
    }

    reachables := map[string]bool {"0": true}

    oldReachablesCount := 0
    reachablesCount := 1
    targets := transitions["0"]

    for oldReachablesCount != reachablesCount {
        oldReachablesCount = reachablesCount
        numTargets := len(targets)
        newTargets := map[string]bool {}

        for i := 0; i < numTargets; i++ {
            targetTransitions := transitions[targets[i]]
            numTargetTransitions := len(targetTransitions)

            for j := 0; j < numTargetTransitions; j++ {
                reachables[targetTransitions[j]] = true
                newTargets[targetTransitions[j]] = true
            }
        }

        newTargetKeys := reflect.ValueOf(newTargets).MapKeys()
        numNewKeys := len(newTargetKeys)
        targets = make([]string, numNewKeys)

        for i := 0; i < numNewKeys; i++ {
            targets[i] = newTargetKeys[i].String()
        }

        reachablesCount = len(reachables)
    }

    fmt.Println(reachablesCount)
}
