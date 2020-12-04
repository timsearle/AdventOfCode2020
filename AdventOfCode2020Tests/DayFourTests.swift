import XCTest
import AdventOfCode2020

class DayFourTests: XCTestCase {
    private func makeInput() -> [[String: String]] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: "DayFour", withExtension: "txt")!
        let rows = try! String(contentsOf: inputURL).components(separatedBy: .newlines)

        var currentLines = [String]()
        var passportStrings = [String]()

        for line in rows {
            if line.isEmpty {
                passportStrings.append(currentLines.joined(separator: " "))
                currentLines = []
            } else {
                currentLines.append(line)
            }
        }

        var passports = [[String: String]]()

        for passportLine in passportStrings {
            var passport = [String: String]()
            let entries = passportLine.components(separatedBy: " ")

            for entry in entries {
                let components = entry.components(separatedBy: ":")
                passport[components[0]] = components[1]
            }

            passports.append(passport)
        }

        return passports
    }

    func testDayFour_1() {
        let dayFour = DayFour(passports: makeInput())
        XCTAssertEqual(256, dayFour.partOne())
    }

    func testDayFour_2() {
        let dayFour = DayFour(passports: makeInput())
        XCTAssertEqual(198, dayFour.partTwo())
    }
}
