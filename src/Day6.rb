require 'set'

if ARGV.length == 0
    puts "No arguments given"
    exit 1
end

seenItems = Set.new
currentItem = ARGV.map(&:to_i)
length = ARGV.length
count = 0

until seenItems.member? currentItem.join " "
    oldItem = currentItem.join " "
    seenItems.add(oldItem)

    maxIndex = currentItem.each_index.max_by { |i| currentItem[i] }
    maxValue = currentItem[maxIndex]
    currentItem[maxIndex] = 0

    globalIncrement = maxValue / length
    remainingIncrement = maxValue - globalIncrement * length

    currentItem = currentItem.map { |i| i + globalIncrement }

    startIndex = maxIndex + 1
    endIndex = maxIndex + remainingIncrement
    indexesToIncrement = (startIndex .. endIndex).to_a.map { |i| i % length }

    for i in indexesToIncrement
        currentItem[i] += 1
    end

    if currentItem.join(" ") != oldItem
        count += 1
    end
end

puts count
