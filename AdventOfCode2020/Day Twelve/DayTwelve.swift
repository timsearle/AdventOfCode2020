public final class DayTwelve {
    struct Instruction: CustomStringConvertible {
        let action: Action
        let value: Int

        var description: String {
            return "\(action.rawValue)\(value)"
        }
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
        var direction: Direction
        var xPos: Int
        var yPos: Int

        mutating func forward(_ value: Int) {
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

                switch direction {
                case .north:
                    direction = .west
                case .south:
                    direction = .east
                case .east:
                    direction = .north
                case .west:
                    direction = .south
                }
            }
        }

        mutating func turnRight(_ value: Int) {
            var count = value / 90

            while count >= 1 {
                count -= 1

                switch direction {
                case .north:
                    direction = .east
                case .south:
                    direction = .west
                case .east:
                    direction = .south
                case .west:
                    direction = .north
                }
            }
        }

        mutating func apply(_ waypoint: Waypoint, times: Int) {
            xPos += waypoint.xPos * times
            yPos += waypoint.yPos * times
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
        var currentPosition = Position(direction: .east, xPos: 0, yPos: 0)

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
        var shipPosition = Position(direction: .east, xPos: 0, yPos: 0)
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

            var positions = [Int?]()

            if currentYDirection == .north {
                positions.append(abs(yPos))
            } else {
                positions.append(nil)
            }

            if currentXDirection == .east {
                positions.append(abs(xPos))
            } else {
                positions.append(nil)
            }

            if currentYDirection == .south {
                positions.append(abs(yPos))
            } else {
                positions.append(nil)
            }

            if currentXDirection == .west {
                positions.append(abs(xPos))
            } else {
                positions.append(nil)
            }

            return positions
        }

        func rotateClockwise(_ direction: Direction) -> Direction {
            switch direction {
            case .north:
                return .east
            case .south:
                return .west
            case .east:
                return .south
            case .west:
                return .north
            }
        }
    }
}
