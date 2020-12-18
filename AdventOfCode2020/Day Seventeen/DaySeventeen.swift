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
    private let pocketDimension2: [[[[Cube]]]]

    public init(input: String) {
        let rows = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { value in
                value.map { Cube(rawValue: String($0))! }
            }

        pocketDimension = [rows]
        pocketDimension2 = [pocketDimension]
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

    public func partTwo() -> Int {
        var pocketDimension = self.pocketDimension2

        for _ in 0..<6 {
            expand2(&pocketDimension)
            cycle2(&pocketDimension)
        }

        return pocketDimension
            .flatMap {
                $0.flatMap {
                    $0.flatMap {
                        $0.compactMap {
                            $0
                        }
                    }
                }
            }
            .filter { $0 == .active }
            .count
    }

    private func expand2(_ pocketDimension: inout [[[[Cube]]]]) {
        var new = pocketDimension

        let existingDepth = pocketDimension[0].count
        let existingHeight = pocketDimension[0][0].count
        let existingWidth = pocketDimension[0][0][0].count

        let emptyRow = Array(repeating: Cube.inactive, count: existingWidth + 2)
        let emptyZ = Array(repeating: Cube.inactive, count: existingHeight + 2).map { _ in emptyRow}
        let emptyW = Array(repeating: Cube.inactive, count: existingDepth + 2).map { _ in emptyZ }

        for w in 0..<pocketDimension.count {
            for z in 0..<pocketDimension[w].count {
                for y in 0..<pocketDimension[w][z].count {
                    let row = [Cube.inactive] + pocketDimension[w][z][y] + [Cube.inactive]
                    new[w][z][y] = row
                }
                new[w][z] = [emptyRow] + new[w][z] + [emptyRow]
            }
            new[w] = [emptyZ] + new[w] + [emptyZ]
        }

        new = [emptyW] + new + [emptyW]

        pocketDimension = new
    }

    private func cycle2(_ pocketDimension: inout [[[[Cube]]]]) {
        var result = pocketDimension

        for w in 0..<pocketDimension.count {
            for z in 0..<pocketDimension[w].count {
                for y in 0..<pocketDimension[w][z].count {
                    for x in 0..<pocketDimension[w][z][y].count {
                        let activeNeighbourCount = activeNeighbours2(of: (w,z,y,x), inside: pocketDimension)

                        switch pocketDimension[w][z][y][x] {
                        case .active:
                            if activeNeighbourCount != 2 && activeNeighbourCount != 3 {
                                result[w][z][y][x] = .inactive
                            }
                        case .inactive:
                            if activeNeighbourCount == 3 {
                                result[w][z][y][x] = .active
                            }
                        }
                    }
                }
            }
        }

        pocketDimension = result
    }

    private func activeNeighbours2(of coordinate: (Int,Int,Int,Int), inside pocketDimension: [[[[Cube]]]]) -> Int {
        let (w,z,y,x) = coordinate
        var counter = 0
        for checkX in x-1...x+1 {
            for checkY in y-1...y+1 {
                for checkZ in z-1...z+1 {
                    for checkW in w-1...w+1 {
                        if (checkW, checkZ, checkY, checkX) == coordinate {
                            continue
                        }
                        if let value = pocketDimension[safe: checkW]?[safe: checkZ]?[safe: checkY]?[safe: checkX], value == .active {
                            counter += 1
                        }
                    }
                }
            }
        }
        return counter
    }
}
