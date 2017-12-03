import math
import sys

if len(sys.argv) != 2:
    print("One argument is expected")
    sys.exit(1)

number = int(sys.argv[1])

if number == 1:
    print("0")
    sys.exit(0)

ring = int(math.ceil((number ** 0.5 - 1) / 2.0))
maxRingValue = (ring * 2 + 1) ** 2
ringMiddles = [maxRingValue - ring, maxRingValue - 3 * ring, maxRingValue - 5 * ring, maxRingValue - 7 * ring]
distancesToMiddles = map(lambda x: abs(x - number), ringMiddles)
distanceToMiddle = min(distancesToMiddles)

print(ring + distanceToMiddle)
