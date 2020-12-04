import Foundation

struct PasswordEntry {
    let range: Range<Int>
    let character: String
    let password: String

    func isValid(isPartTwo: Bool = false) -> Bool {
        if isPartTwo {
            return (password[range.lowerBound - 1] == character) != (password[range.upperBound - 1] == character)
        } else {
            let count = password.filter { String($0) == character }.count
            return count >= range.lowerBound && count <= range.upperBound
        }
    }
}


public final class DayTwo {
    private let lines: [String]

    public init(lines: [String]) {
        self.lines = lines
    }

    public func partOne() -> Int {
        return countValidPasswords()
    }

    public func partTwo() -> Int {
        return countValidPasswords(isPartTwo: true)
    }

    private func countValidPasswords(isPartTwo: Bool = false) -> Int {
        var count = 0
        for line in lines {
            guard !line.isEmpty else {
                continue
            }
            let components = line.components(separatedBy: " ")
            let range = components[0].components(separatedBy: "-").compactMap { Int($0) }
            let newRange = Range(uncheckedBounds: (range[0], range[1]))
            let character = components[1].replacingOccurrences(of: ":", with: "")
            let password = components[2]

            let entry = PasswordEntry(range: newRange, character: character, password: password)

            if entry.isValid(isPartTwo: isPartTwo) {
                count += 1
            }
        }

        return count
    }
}
