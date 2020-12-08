import Foundation

public extension String {
    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(count, r.lowerBound)),
                                            upper: min(count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    func removingDigits() -> String {
        components(separatedBy: .decimalDigits).joined()
    }
}

public extension Array where Element == String {
    func trimmingCharacters(in set: CharacterSet) -> Array {
        map { $0.trimmingCharacters(in: set) }
    }
}

public extension CharacterSet {
    static var whitespacesAndPunctuation: CharacterSet {
        CharacterSet.whitespaces.union(.punctuationCharacters)
    }
}