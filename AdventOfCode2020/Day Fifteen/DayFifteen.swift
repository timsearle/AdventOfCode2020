import Foundation

public final class DayFifteen {
    let numbers: [Int]

    public init(input: String) {
        numbers = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: ",")
            .compactMap { Int($0) }
    }

    public func partOne(_ target: Int = 2020) -> Int {
        var cache = [Int: Int]()
        var numbers = self.numbers
        let initialLength = numbers.count

        for (index, number) in numbers[0..<(initialLength-1)].enumerated() {
            cache[number] = index + 1
        }

        for i in (initialLength - 1)..<target-1 {
            let previousNumber = numbers[i]

            if let previousTurn = cache[previousNumber] {
                let nextNumber = (i + 1) - previousTurn
                numbers.append(nextNumber)
            } else {
                numbers.append(0)
            }
            cache[previousNumber] = i + 1
        }

        return numbers.last!
    }

    public func partTwo() -> Int {
        return partOne(30000000)
    }
}
