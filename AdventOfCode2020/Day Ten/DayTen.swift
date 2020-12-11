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

    public func partTwo() -> Int {
        let splitValues = split((differences([0] + adapters.sorted()) + [3]))
        return splitValues.map(numberOfArrangements).reduce(1, *)
    }

    private func differences(_ input: [Int]) -> [Int] {
        var result = [Int]()

        for i in 1..<input.count {
            result.append(input[i] - input[i - 1])
        }

        return result
    }

    private func split(_ input: [Int]) -> [[Int]] {
        var result = [[Int]]()

        var pending = [Int]()
        for value in input {
            if value == 3 {
                result.append(pending)
                result.append([3])
                pending.removeAll()
            }
        }

        return result
    }

    private func numberOfArrangements(_ input: [Int]) -> Int {
        guard input.count > 1 else {
            return 1
        }

        // TODO
        return 0
    }
}
