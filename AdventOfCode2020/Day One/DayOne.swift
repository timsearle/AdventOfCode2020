import Foundation

public final class DayOne {
    private let input: [Int]

    public init(input: [Int]) {
        self.input = input
    }

    public func partOne() -> Int {
        if let (a, b) = two_sum(input, target: 2020) {
            return a * b
        }

        return 0
    }

    private func two_sum(_ array: [Int], target: Int) -> (Int, Int)? {
        var cache = [Int: Int]()

        for value in array {
            if let exists = cache[value] {
                return (exists, value)
            }

            cache[target - value] = value
        }

        return nil
    }

    public func partTwo() -> Int {
        if let (a, b, c) = three_sum(input, target: 2020) {
            return a * b * c
        }

        return 0
    }

    private func three_sum(_ array: [Int], target: Int) -> (Int, Int, Int)? {
        for value in array {
            if let result = two_sum(array, target: target - value) {
                return (value, result.0, result.1)
            }
        }

        return nil
    }

}
