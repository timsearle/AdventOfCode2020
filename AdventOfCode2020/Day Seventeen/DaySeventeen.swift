import Foundation

public final class DaySeventeen {
    enum Cube: String, CustomStringConvertible {
        case active = "#"
        case inactive = "."

        var description: String {
            self.rawValue
        }
    }

    private let pocketDimension: [[[Cube]]]

    public init(input: String) {
        let rows = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { value in
                value.map { Cube(rawValue: String($0))! }
            }

        pocketDimension = [rows]
    }

    public func partOne() -> Int {
        var pocketDimension = self.pocketDimension

        for _ in 0..<6 {
            expand(&pocketDimension)
            cycle(&pocketDimension)
        }

        return pocketDimension
            .flatMap {
                $0.flatMap {
                    $0.compactMap { $0 }
                }
            }
            .filter { $0 == .active }
            .count
    }

    private func expand(_ pocketDimension: inout [[[Cube]]]) {
        var new = pocketDimension

        let existingWidth = pocketDimension[0][0].count
        let emptyRow = Array(repeating: Cube.inactive, count: existingWidth + 2)

        for z in 0..<pocketDimension.count {
            for y in 0..<pocketDimension[z].count {
                let row = [Cube.inactive] + pocketDimension[z][y] + [Cube.inactive]
                new[z][y] = row
            }
            new[z] = [emptyRow] + new[z] + [emptyRow]
        }

        // Add new z-layer
        let emptyLayer = new[0].map { $0.map { _ in Cube.inactive } }

        new = [emptyLayer] + new + [emptyLayer]

        pocketDimension = new
    }

    private func cycle(_ pocketDimension: inout [[[Cube]]]) {
        var result = pocketDimension

        for z in 0..<pocketDimension.count {
            for y in 0..<pocketDimension[z].count {
                for x in 0..<pocketDimension[z][y].count {
                    let activeNeighbourCount = activeNeighbours(of: (z,y,x), inside: pocketDimension)

                    switch pocketDimension[z][y][x] {
                    case .active:
                        if activeNeighbourCount != 2 && activeNeighbourCount != 3 {
                            result[z][y][x] = .inactive
                        }
                    case .inactive:
                        if activeNeighbourCount == 3 {
                            result[z][y][x] = .active
                        }
                    }
                }
            }
        }

        pocketDimension = result
    }

    private func activeNeighbours(of coordinate: (Int,Int,Int), inside pocketDimension: [[[Cube]]]) -> Int {
        let (z,y,x) = coordinate
        var counter = 0
        for checkX in x-1...x+1 {
            for checkY in y-1...y+1 {
                for checkZ in z-1...z+1 {
                    if (checkZ, checkY, checkX) == coordinate {
                        continue
                    }
                    if let value = pocketDimension[safe: checkZ]?[safe: checkY]?[safe: checkX], value == .active {
                        counter += 1
                    }
                }
            }
        }
        return counter
    }
}
