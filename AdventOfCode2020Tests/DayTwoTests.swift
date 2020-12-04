import XCTest
import AdventOfCode2020

class DayTwoTests: XCTestCase {
    private func makeInput() -> [String] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: "DayTwo", withExtension: "txt")!
        return try! String(contentsOf: inputURL).components(separatedBy: .newlines)
    }

    func testDayTwo_1() {
        let dayTwo = DayTwo(lines: makeInput())
        print(dayTwo.partOne())
    }

    func testDayTwo_2() {
        let dayTwo = DayTwo(lines: makeInput())
        print(dayTwo.partTwo())
    }

    func testPerformanceDayTwo_1() throws {
        let dayTwo = DayTwo(lines: makeInput())

        measure {
            XCTAssertEqual(dayTwo.partOne(), 418)
        }
    }

    func testPerformanceDayTwo_2() throws {
        let dayTwo = DayTwo(lines: makeInput())

        measure {
            XCTAssertEqual(dayTwo.partTwo(), 616)
        }
    }

}
