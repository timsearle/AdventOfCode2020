import Foundation

public final class DayEleven {
    private let seats: [[Character]]

    var didMutatePartOne = false
    var didMutatePartTwo = false

    public init(input: String) {
        seats = input.components(separatedBy: .newlines).filter { !$0.isEmpty }.map { $0.map { $0 } }
    }

    public func partOne() -> Int {
        var seats = self.seats

        while true {
            seats = runSeatModel(on: seats)
            if !didMutatePartOne {
                break
            } else {
                didMutatePartOne = false
            }
        }

        return countOccupiedSeats(seats)
    }

    private func runSeatModel(on seats: [[Character]]) -> [[Character]] {
        var result = seats

        for row in 0..<seats.count {
            for column in 0..<seats[row].count {
                switch seats[row][column] {
                case "#":
                    if adjacentSeats(of: (row,column), in: seats) >= 4 {
                        didMutatePartOne = true
                        result[row][column] = "L"
                    }
                case "L":
                    // Free
                    if adjacentSeats(of: (row,column), in: seats) == 0 {
                        didMutatePartOne = true
                        result[row][column] = "#"
                    }
                default:
                    continue
                }
            }
        }

        return result
    }

    private func adjacentSeats(of seat: (Int, Int), in seats: [[Character]]) -> Int {
        var count = 0

        [(seat.0, seat.1 - 1),
         (seat.0, seat.1 + 1),
         (seat.0 - 1, seat.1),
         (seat.0 + 1, seat.1),
         (seat.0 - 1, seat.1 + 1),
         (seat.0 - 1, seat.1 - 1),
         (seat.0 + 1, seat.1 - 1),
         (seat.0 + 1, seat.1 + 1)].forEach { seat in
            count += seats[safe:seat.0]?[safe:seat.1] == "#" ? 1 : 0
         }

        return count
    }

    public func partTwo() -> Int {
        var seats = self.seats

        while true {
            seats = runSeatModel2(on: seats)
            if !didMutatePartTwo {
                break
            } else {
                didMutatePartTwo = false
            }
        }

        return countOccupiedSeats(seats)
    }

    private func runSeatModel2(on seats: [[Character]]) -> [[Character]] {
        var result = seats

        for row in 0..<seats.count {
            for column in 0..<seats[row].count {
                switch seats[row][column] {
                case ".":
                    continue
                case "#":
                    if visibleOccupiedSeats(of: (row,column), in: seats) >= 5 {
                        result[row][column] = "L"
                        didMutatePartTwo = true
                    }
                case "L":
                    // Free
                    if visibleOccupiedSeats(of: (row,column), in: seats) == 0 {
                        result[row][column] = "#"
                        didMutatePartTwo = true
                    }
                default:
                    continue
                }
            }
        }

        return result
    }

    private func visibleOccupiedSeats(of seat: (Int, Int), in seats: [[Character]]) -> Int {
        let allLeft = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 }, columnMutator: { $0 - 1 })
        let allRight = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 }, columnMutator: { $0 + 1 })
        let allTop = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 - 1}, columnMutator: { $0 })
        let allBottom = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 + 1 }, columnMutator: { $0 })
        let allTopRight = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 - 1 }, columnMutator: { $0 + 1 })
        let allTopLeft = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 - 1 }, columnMutator: { $0 - 1 })
        let allBottomLeft = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 + 1 }, columnMutator: { $0 - 1 })
        let allBottomRight = hasVisibleOccupiedSeat(from: seat, in: seats, rowMutator: { $0 + 1 }, columnMutator: { $0 + 1 })

        let result = [allLeft, allRight, allTop, allBottom, allTopRight, allTopLeft, allBottomLeft, allBottomRight]

        return result.filter { $0 == true }.count
    }

    private func hasVisibleOccupiedSeat(from index: (Int, Int), in seats: [[Character]], rowMutator: (Int) -> Int, columnMutator: (Int) -> Int) -> Bool {

        var index = index

        index.0 = rowMutator(index.0)
        index.1 = columnMutator(index.1)

        guard index.0 >= 0 && index.0 < seats.count, index.1 >= 0 && index.1 < seats[index.0].count else {
            return false
        }

        var next = seats[index.0][index.1]

        while true {
            if next == "#" { return true }
            if next == "L" { return false }
            index.0 = rowMutator(index.0)
            index.1 = columnMutator(index.1)

            guard index.0 >= 0 && index.0 < seats.count, index.1 >= 0 && index.1 < seats[index.0].count else {
                break
            }

            next = seats[index.0][index.1]
        }

        return false
    }

    private func countOccupiedSeats(_ seats: [[Character]]) -> Int {
        seats.flatMap { $0 }.filter { $0 == "#" }.count
    }
}
