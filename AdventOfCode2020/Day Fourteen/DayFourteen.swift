import Foundation

public final class DayFourteen {

    enum Instruction {
        case mask(String)
        case write(address: Int, value: Int)
    }

    private let instructions: [Instruction]
    private var memory = [Int: Int]()

    public init(input: String) {
        let entries = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { $0.components(separatedBy: " = ").trimmingCharacters(in: .whitespaces)}

        var instructions = [Instruction]()

        for line in entries {
            if line[0] == "mask" {
                instructions.append(.mask(line[1]))
            } else {
                let address = Int(line[0].trimmingCharacters(in: CharacterSet.decimalDigits.inverted))!
                let value = Int(line[1].trimmingCharacters(in: .whitespaces))!
                instructions.append(.write(address: address, value: value))
            }
        }

        self.instructions = instructions
    }

    public func partOne() -> Int {
        var currentMask = [String](repeating: "X", count: 36).joined()

        instructions.forEach {
            switch $0 {
            case let .mask(mask):
                currentMask = mask
            case let .write(address: address, value: value):
                write(masking(with: currentMask, to: value), at: address, in: &memory)
            }
        }

        return memory.reduce(into: 0) { (result, dict) in
            result += dict.value
        }
    }

    public func partTwo() -> Int {
        var currentMask = [String](repeating: "X", count: 36).joined()

        instructions.forEach {
            switch $0 {
            case let .mask(mask):
                currentMask = mask
            case let .write(address: address, value: value):
                for address in maskingV2(with: currentMask, to: address) {
                    write(value, at: address, in: &memory)
                }
            }
        }

        return memory.reduce(into: 0) { (result, dict) in
            result += dict.value
        }
    }

    private func write(_ value: Int, at index: Int, in memory: inout [Int: Int]) {
        memory[index] = value
    }

    private func masking(with mask: String, to value: Int) -> Int {
        let values = zip(mask, value.asBinaryString(paddedToLength: mask.count))
            .map { mask, binary -> String in
                guard mask != "X" else {
                    return String(binary)
                }

                return String(mask)
            }

        return Int(values.joined(), radix: 2)!
    }

    private func maskingV2(with mask: String, to value: Int) -> [Int] {
        let bits = zip(mask, value.asBinaryString(paddedToLength: mask.count))
            .map { mask, binary -> [String] in
                guard mask != "0" else {
                    return [String(binary)]
                }

                guard mask != "1" else {
                    return [String(mask)]
                }

                return ["1","0"]
            }

        let permutations = Node("Root", ready: true)

        for bit in bits {
            if bit.count == 1 {
                permutations.insert(bit[0])
                permutations.markAllAsReady()
            } else {
                for floating in bit {
                    permutations.insert(floating)
                }
                permutations.markAllAsReady()
            }
        }

        var buffer = [String]()
        var allPaths = [[String]]()

        visitAll(in: permutations, array: &buffer, allPaths: &allPaths)

        return allPaths.map { $0.joined() }.map { Int($0, radix: 2)! }
    }

    private func visitAll(in node: Node, array: inout [String], allPaths: inout [[String]]) {
        if node.children.isEmpty {
            array.append(node.value)
            allPaths.append(array)
        } else {
            if node.value != "Root" {
                array.append(node.value)
            }
            for child in node.children {
                visitAll(in: child, array: &array, allPaths: &allPaths)
            }
        }

        if !array.isEmpty {
            array.removeLast()
        }
    }
}

class Node {
    let value: String
    var children: [Node] = []
    var ready: Bool

    func markAllAsReady() {
        ready = true
        children.forEach {$0.markAllAsReady()}
    }

    init(_ value: String, ready: Bool) {
        self.value = value
        self.ready = ready
    }

    func insert(_ value: String) {
        if ready {
            if children.filter({ $0.ready }).isEmpty {
                children.append(Node(value, ready: false))
            } else {
                for child in children where child.ready {
                    child.insert(value)
                }
            }
        }
    }
}

extension Int {
    func asBinaryString(paddedToLength: Int? = nil) -> String {
        var binaryRepresentation = String(self, radix: 2)
        if let paddedToLength = paddedToLength {
            while binaryRepresentation.count != paddedToLength {
                binaryRepresentation = "0" + binaryRepresentation
            }
        }
        return binaryRepresentation
    }
}
