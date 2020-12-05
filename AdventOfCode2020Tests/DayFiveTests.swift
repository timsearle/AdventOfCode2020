import XCTest
@testable import AdventOfCode2020

class DayFiveTests: XCTestCase {
    private func makeInput() -> [String] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: "DayFive", withExtension: "txt")!
        let passes = try! String(contentsOf: inputURL)
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }

        return passes
    }

    func testDayFive_1_sample() {
        let dayFive = DayFive(passes: ["BFFFBBFRRR",
                                       "FFFBBBFRRR",
                                       "BBFFBBFRLL"])
        XCTAssertEqual(820, dayFive.partOne())
    }

    func testDayFive_1() {
        let dayFive = DayFive(passes: makeInput())
        XCTAssertEqual(953, dayFive.partOne())
    }

    func testDayFive_2() {
        let dayFive = DayFive(passes: makeInput())
        XCTAssertEqual(615, dayFive.partTwo())
    }
}
