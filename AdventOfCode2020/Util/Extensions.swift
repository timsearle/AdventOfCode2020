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

public extension Array {
    subscript (safe index: Int) -> Element? {
      indices.contains(index) ? self[index] : nil
    }
}

public extension Array where Element == String {
    func trimmingCharacters(in set: CharacterSet) -> Array {
        map { $0.trimmingCharacters(in: set) }
    }
}

public extension Array where Element == Int {
    mutating func removingMin() -> Int? {
        guard let minValue = self.min() else {
            return nil
        }

        remove(at: firstIndex(of: minValue)!)

        return minValue
    }
}

public extension CharacterSet {
    static var whitespacesAndPunctuation: CharacterSet {
        CharacterSet.whitespaces.union(.punctuationCharacters)
    }
}
