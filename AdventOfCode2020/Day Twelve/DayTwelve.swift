public final class DayTwelve {
    struct Instruction {
        let action: Action
        let value: Int
    }

    enum Action: String {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        case left = "L"
        case right = "R"
        case forward = "F"
    }

    enum Direction {
        case north
        case south
        case east
        case west
    }

    struct Position {
        var directions: [Direction]
        var xPos: Int
        var yPos: Int

        mutating func forward(_ value: Int) {
            advance(directions[0], for: value)
        }

        mutating func advance(_ direction: Direction, for value: Int) {
            switch direction {
            case .north:
                yPos -= value
            case .south:
                yPos += value
            case .east:
                xPos += value
            case .west:
                xPos -= value
            }
        }

        mutating func turnLeft(_ value: Int) {
            var count = value / 90

            while count >= 1 {
                count -= 1
                directions.rotateSingleRight()
            }
        }

        mutating func turnRight(_ value: Int) {
            var count = value / 90

            while count >= 1 {
                count -= 1
                directions.rotateSingleLeft()
            }
        }

        mutating func apply(_ waypoint: Waypoint, times: Int) {
            xPos += waypoint.xPos * times
            yPos += waypoint.yPos * times
        }
    }

    struct Waypoint {
        var xPos: Int
        var yPos: Int

        mutating func advance(_ direction: Direction, for value: Int) {
            switch direction {
            case .north:
                yPos -= value
            case .south:
                yPos += value
            case .east:
                xPos += value
            case .west:
                xPos -= value
            }
        }

        mutating func turnLeft(_ value: Int) {
            let count = value / 90

            var positions = self.positions

            for _ in 0..<count {
                positions.rotateSingleLeft()
            }

            update(positions)
        }

        mutating func turnRight(_ value: Int) {
            let count = value / 90

            var positions = self.positions

            for _ in 0..<count {
                positions.rotateSingleRight()
            }

            update(positions)
        }

        mutating func update(_ positions: [Int?]) {
            if let north = positions[0] {
                yPos = -(north)
            }

            if let east = positions[1] {
                xPos = east
            }

            if let south = positions[2] {
                yPos = south
            }

            if let west = positions[3] {
                xPos = -(west)
            }
        }

        var positions: [Int?] {
            let currentXDirection: Direction = xPos >= 0 ? .east : .west
            let currentYDirection: Direction = yPos >= 0 ? .south : .north

            var positions = [Int?](repeating: nil, count: 4)

            positions[0] = currentYDirection == .north ? abs(yPos) : nil
            positions[1] = currentXDirection == .east ? abs(xPos) : nil
            positions[2] = currentYDirection == .south ? abs(yPos) : nil
            positions[3] = currentXDirection == .west ? abs(xPos) : nil

            return positions
        }
    }

    private let instructions: [Instruction]

    public init(input: String) {
        instructions = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Instruction(action: Action(rawValue: $0[0])!,
                               value: Int(String($0[1..<$0.count]))!) }
    }

    public func partOne() -> Int {
        var currentPosition = Position(directions: [.east, .south, .west, .north], xPos: 0, yPos: 0)

        for instruction in instructions {
            processInstruction(instruction, on: &currentPosition)
        }

        return abs(currentPosition.xPos) + abs(currentPosition.yPos)
    }

    private func processInstruction(_ instruction: Instruction, on position: inout Position) {
        switch instruction.action {
        case .north:
            position.advance(.north, for: instruction.value)
        case .south:
            position.advance(.south, for: instruction.value)
        case .east:
            position.advance(.east, for: instruction.value)
        case .west:
            position.advance(.west, for: instruction.value)
        case .left:
            position.turnLeft(instruction.value)
        case .right:
            position.turnRight(instruction.value)
        case .forward:
            position.forward(instruction.value)
        }
    }

    public func partTwo() -> Int {
        var shipPosition = Position(directions: [.east, .south, .west, .north], xPos: 0, yPos: 0)
        var waypoint = Waypoint(xPos: 10, yPos: -1)

        for instruction in instructions {
            processInstruction(instruction, on: &shipPosition, waypoint: &waypoint)
        }

        return abs(shipPosition.xPos) + abs(shipPosition.yPos)
    }

    private func processInstruction(_ instruction: Instruction, on position: inout Position, waypoint: inout Waypoint) {
        switch instruction.action {
        case .north:
            waypoint.advance(.north, for: instruction.value)
        case .south:
            waypoint.advance(.south, for: instruction.value)
        case .east:
            waypoint.advance(.east, for: instruction.value)
        case .west:
            waypoint.advance(.west, for: instruction.value)
        case .left:
            waypoint.turnLeft(instruction.value)
        case .right:
            waypoint.turnRight(instruction.value)
        case .forward:
            position.apply(waypoint, times: instruction.value)
        }
    }
}
