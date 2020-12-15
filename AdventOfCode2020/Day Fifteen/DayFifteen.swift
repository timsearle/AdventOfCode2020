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

        for i in 0..<numbers.count-1 {
            cache[numbers[i]] = i + 1
        }

        var readNumber = numbers[numbers.count - 1]

        for i in (numbers.count - 1)..<target-1 {
            let previousNumber = readNumber

            if let previousTurn = cache[previousNumber] {
                let nextNumber = (i + 1) - previousTurn
                readNumber = nextNumber
            } else {
                readNumber = 0
            }
            cache[previousNumber] = i + 1
        }

        return readNumber
    }

    public func partTwo() -> Int {
        return partOne(30000000)
    }
}
