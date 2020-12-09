import Foundation

public final class DayNine {
    private let preambleSize: Int
    private let series: [Int]

    public init(input: String, preambleSize: Int) {
        self.preambleSize = preambleSize

        self.series = input
            .components(separatedBy: .newlines)
            .compactMap { Int($0) }
    }

    public func partOne() -> Int {
        for i in preambleSize..<series.count {
            if DayOne.two_sum(Array(series[i-preambleSize..<i]), target: series[i]) == nil {
                return series[i]
            }
        }

        return 0
    }

    public func partTwo() -> Int {
        let numbers = numbersSumming(to: partOne())
        return numbers.min()! + numbers.max()!
    }

    private func numbersSumming(to targetValue: Int) -> [Int] {
        var targetNumbers = [Int]()

        for i in 0..<series.count {
            targetNumbers.append(series[i])

            var currentTotal = targetNumbers.reduce(0,+)

            while currentTotal > targetValue {
                targetNumbers.removeFirst()
                currentTotal = targetNumbers.reduce(0,+)
            }

            if currentTotal == targetValue {
                return targetNumbers
            }
        }

        return targetNumbers
    }
}
