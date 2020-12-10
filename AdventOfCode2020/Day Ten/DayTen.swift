import Foundation

public final class DayTen {

    private let adapters: [Int]

    public init(input: String) {
        self.adapters = input.components(separatedBy: .newlines).filter { !$0.isEmpty }.compactMap { Int($0) }
    }

    public func partOne() -> Int {
        var one = 0
        var three = 0
        var adapters = self.adapters.sorted()

        nextAdapter(from: &adapters, source: 0, oneDifferenceCount: &one, threeDifferenceCount: &three)

        return one * (three + 1)
    }

    private func nextAdapter(from adapters: inout [Int], source: Int, oneDifferenceCount: inout Int, threeDifferenceCount: inout Int) {

        guard !adapters.isEmpty else {
            return
        }

        let first = adapters.removeFirst()

        if first - source == 3 {
            threeDifferenceCount += 1
        } else if first - source == 1 {
            oneDifferenceCount += 1
        }

        nextAdapter(from: &adapters, source: first, oneDifferenceCount: &oneDifferenceCount, threeDifferenceCount: &threeDifferenceCount)
    }
}
