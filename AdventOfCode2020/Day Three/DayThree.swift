import Foundation

public final class DayThree {
    private let input: [[String]]

    public init(input: [[String]]) {
        self.input = input
    }

    public func partOne(right: Int = 3, down: Int = 1) -> Int {
        var rowIndex = 0
        var columnIndex = 0

        var trees = 0

        while (rowIndex + 1) <= input.count - 1 {
            columnIndex = (columnIndex + right) % (input.first?.count ?? 0)
            rowIndex += down

            if input[rowIndex][columnIndex] == "#" {
                trees += 1
            }
        }

        return trees
    }

    public func partTwo() -> Int {
        partOne(right: 1, down: 1) +
        partOne(right: 3, down: 1) +
        partOne(right: 5, down: 1) +
        partOne(right: 7, down: 1) +
        partOne(right: 1, down: 2)
    }
}
