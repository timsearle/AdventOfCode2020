import Foundation

public struct Instruction: CustomStringConvertible {
    enum Op: String {
        case nop
        case acc
        case jmp
    }

    let op: Op
    let arg: Int

    let isExecuted: Bool

    public init(value: String) {
        let components = value.components(separatedBy: " ")
        op = Op(rawValue: components[0])!
        arg = Int(components[1])!
        isExecuted = false
    }

    init(op: Op, arg: Int, isExecuted: Bool) {
        self.op = op
        self.arg = arg
        self.isExecuted = isExecuted
    }

    public var description: String {
        "\(op.rawValue): \(arg)"
    }
}

public final class DayEight {
    let instructions: [Instruction]

    public init(input: String) {
        self.instructions = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map(Instruction.init)
    }

    public func partOne() -> Int {
        return execute(instructionSet: instructions).1
    }

    private func execute(instructionSet: [Instruction]) -> (Bool, Int) {
        var accumulator = 0
        var i = 0
        var instructionSet = instructionSet

        while i < instructionSet.count {
            let instruction = instructionSet[i]

            guard !instruction.isExecuted else {
                return (true, accumulator)
            }

            execute(instructionSet: &instructionSet, instruction: instruction, accumulator: &accumulator, index: &i)
        }

        return (false, accumulator)
    }

    private func execute(instructionSet: inout [Instruction], instruction: Instruction, accumulator: inout Int, index: inout Int) {
        let newInstruction = Instruction(op: instruction.op,
                                         arg: instruction.arg,
                                         isExecuted: true)
        instructionSet[index] = newInstruction

        switch newInstruction.op {
        case .acc:
            accumulator += newInstruction.arg
            index += 1
        case .jmp:
            index += newInstruction.arg
        case .nop:
            index += 1
        }
    }

    public func partTwo() -> Int {
        for i in 0..<instructions.count {
            var instructions = self.instructions

            let instruction = instructions[i]

            if instruction.op != .acc && instruction.arg != 0 {
                let newInstruction = Instruction(op: instruction.op == .jmp ? .nop : .jmp,
                                                 arg: instruction.arg,
                                                 isExecuted: false)
                instructions[i] = newInstruction

                let (loopDetected, accumulator) = execute(instructionSet: instructions)

                if !loopDetected {
                    return accumulator
                }
            }
        }

        return 0
    }
}
