import Foundation

public final class DayTen {

    private let adapters: [Int]

    public init(input: String) {
        self.adapters = input.components(separatedBy: .newlines).filter { !$0.isEmpty }.compactMap { Int($0) }
    }

    public func partOne() -> Int {
        var one = 0
        var three = 0
        var adapters = self.adapters

        nextAdapter(from: &adapters, source: 0, oneDifferenceCount: &one, threeDifferenceCount: &three)

        return one * (three + 1)
    }

    private func nextAdapter(from adapters: inout [Int], source: Int, oneDifferenceCount: inout Int, threeDifferenceCount: inout Int) {

        guard let min = adapters.removingMin() else {
            // empty array
            return
        }

        if min - source == 3 {
            threeDifferenceCount += 1
        } else if min - source == 1 {
            oneDifferenceCount += 1
        }

        nextAdapter(from: &adapters, source: min, oneDifferenceCount: &oneDifferenceCount, threeDifferenceCount: &threeDifferenceCount)
    }
}
