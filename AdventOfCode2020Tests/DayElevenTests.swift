import XCTest
import AdventOfCode2020

class DayElevenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayEleven-sample" : "DayEleven", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayEleven_1_sample() {
        let dayEleven = DayEleven(input: makeInput(sample: true))
        XCTAssertEqual(37, dayEleven.partOne())
    }

    func testDayEleven_1() {
        let dayEleven = DayEleven(input: makeInput())
        measure {
            XCTAssertEqual(2310, dayEleven.partOne())
        }
    }

    func testDayEleven_2_sample() {
        let dayEleven = DayEleven(input: makeInput(sample: true))
        XCTAssertEqual(26, dayEleven.partTwo())
    }

    func testDayEleven_2() {
        let dayEleven = DayEleven(input: makeInput())
        measure {
            XCTAssertEqual(2074, dayEleven.partTwo())
        }
    }
}
