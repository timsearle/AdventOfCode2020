import XCTest
import AdventOfCode2020

class DayEightTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayEight-sample" : "DayEight", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayEight_1_sample() {
        let dayEight = DayEight(input: makeInput(sample: true))
        XCTAssertEqual(5, dayEight.partOne())
    }

    func testDayEight_1() {
        let dayEight = DayEight(input: makeInput())
        XCTAssertEqual(1394, dayEight.partOne())
    }

    func testDayEight_2_sample() {
        let dayEight = DayEight(input: makeInput(sample: true))
        XCTAssertEqual(8, dayEight.partTwo())
    }

    func testDayEight_2() {
        let dayEight = DayEight(input: makeInput())
        measure {
            XCTAssertEqual(1626, dayEight.partTwo())
        }
    }
}
