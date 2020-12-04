import XCTest
import AdventOfCode2020

class DayOneTests: XCTestCase {
    private func makeInput() -> [Int] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: "DayOne", withExtension: "txt")!
        return try! String(contentsOf: inputURL).components(separatedBy: .newlines).compactMap { Int($0) }
    }

    func testDayOne_1() {
        let dayOne = DayOne(input: makeInput())
        print(dayOne.partOne())
    }

    func testDayOne_2() {
        let dayOne = DayOne(input: makeInput())
        print(dayOne.partTwo())
    }

    func testPerformanceDayOne_1() throws {
        let dayOne = DayOne(input: makeInput())

        self.measure {
            XCTAssertEqual(dayOne.partOne(), 365619)
        }
    }

    func testPerformanceDayOne_2() throws {
        let dayOne = DayOne(input: makeInput())

        self.measure {
            XCTAssertEqual(dayOne.partTwo(), 236873508)
        }
    }

}
