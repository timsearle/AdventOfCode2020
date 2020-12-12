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
}
