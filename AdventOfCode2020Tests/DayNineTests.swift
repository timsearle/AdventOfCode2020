import XCTest
import AdventOfCode2020

class DayNineTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayNine-sample" : "DayNine", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayNine_1_sample() {
        let dayNine = DayNine(input: makeInput(sample: true), preambleSize: 5)
        XCTAssertEqual(127, dayNine.partOne())
    }

    func testDayNine_1() {
        let dayNine = DayNine(input: makeInput(), preambleSize: 25)
        measure {
            XCTAssertEqual(1492208709, dayNine.partOne())
        }
    }

    func testDayNine_2_sample() {
        let dayNine = DayNine(input: makeInput(sample: true), preambleSize: 5)
        XCTAssertEqual(62, dayNine.partTwo())
    }

    func testDayNine_2() {
        let dayNine = DayNine(input: makeInput(), preambleSize: 25)
        measure {
            XCTAssertEqual(238243506, dayNine.partTwo())
        }
    }
}
