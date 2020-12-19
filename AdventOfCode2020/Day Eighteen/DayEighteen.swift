import Foundation

public final class DayEighteen {
    enum Operator: String {
        case add = "+"
        case multiply = "*"
    }

    private let sums: [String]

    public init(input: String) {
        sums = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { $0.replacingOccurrences(of: " ", with: "") }
    }

    public func partOne() -> Int {
        sums.map { evaluate($0) }.reduce(0, +)
    }

    // ((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2

    private func evaluate(_ sum: String) -> Int {
        var sum = sum
        var bracketCount = 0
        var subSum = ""

        for character in sum {
            guard character != "(" else {
                subSum.append(character)
                bracketCount += 1
                continue
            }

            guard character != ")" else {
                subSum.append(character)
                bracketCount -= 1

                if bracketCount == 0 {
                    if subSum.first == "(" && subSum.last == ")" {
                        subSum.removeFirst()
                        subSum.removeLast()
                    }
                    let result = evaluate(subSum)
                    sum = sum.replacingOccurrences(of: "(\(subSum))", with: "\(result)")
                    subSum = "\(result)"
                }
                continue
            }

            guard bracketCount != 0 || !subSum.isEmpty else {
                continue
            }
            
            subSum.append(character)
        }

        if sum.contains("(") {
            return evaluate(sum)
        }
        return subEvaluate(sum)
    }

    private func subEvaluate(_ sum: String) -> Int {
        var runningValue: Int?
        var op: Operator?

        var index = 0

        while index < sum.count {
            let nextValue = sum[index]

            guard var integer = Int(nextValue) else {
                op = Operator(rawValue: nextValue)!
                index += 1
                continue
            }

            index += 1
            while index < sum.count, let nextInteger = Int(sum[index]) {
                index += 1
                integer = Int("\(integer)\(nextInteger)")!
            }

            if let value = runningValue, let op = op {
                runningValue = calculate(integer, value, op)
            } else {
                runningValue = integer
            }
        }

        return runningValue!
    }

    private func calculate(_ valueA: Int, _ valueB: Int, _ op: Operator) -> Int {
        switch op {
        case .add:
            return valueA + valueB
        case .multiply:
            return valueA * valueB
        }
    }
}
