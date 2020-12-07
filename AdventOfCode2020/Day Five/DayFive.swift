import Foundation

public final class DayFive {
    private let passes: [String]
    private let rows: [Int]
    private let columns: [Int]

    public init(passes: [String]) {
        self.passes = passes
        self.rows = Array(0...127)
        self.columns = Array(0...7)
    }

    public func partOne() -> Int {
        return seatIDs().max()!
    }

    public func partTwo() -> Int {
        var seats = seatIDs()

        var previous = seats.removeFirst()

        for seat in seats {
            if seat != previous + 1 {
                return previous + 1
            }

            previous = seat
        }

        return 0
    }

    private func seatIDs() -> [Int] {
        passes
            .map {
                let row = search(value: String($0.prefix(7)), in: rows)
                let column = search(value: String($0.suffix(3)), in: columns)
                return row * 8 + column
            }
            .sorted()
    }

    private func search(value: String, in entry: [Int]) -> Int {
        guard entry.count > 1 else {
            return entry[0]
        }

        var value = value

        let letter = String(value.removeFirst())
        let mid = entry.count / 2

        if letter == "F" || letter == "L" {
            return search(value: value, in: Array(entry[0..<mid]))
        } else {
            return search(value: value, in: Array(entry[mid..<entry.count]))
        }
    }
}
