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
            if !DayNine.sumComponentsExist(in: Array(series[i-preambleSize..<i]), total: series[i]) {
                return series[i]
            }
        }

        return 0
    }

    private static func sumComponentsExist(in array: [Int], total: Int) -> Bool {
        for i in 0..<array.count {
            for j in i+1..<array.count {
                if array[i] + array[j] == total {
                    return true
                }
            }
        }
        return false
    }

    public func partTwo(_ target: Int = 1492208709) -> Int {
        let numbers = numbersSumming(to: target)
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
