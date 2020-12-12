import XCTest
import AdventOfCode2020

class DayTwelveTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayTwelve-sample" : "DayTwelve", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayTwelve_1_sample() {
        let dayTwelve = DayTwelve(input: makeInput(sample: true))
        XCTAssertEqual(25, dayTwelve.partOne())
    }
    
    func testDayTwelve_1() {
        let dayTwelve = DayTwelve(input: makeInput())
        measure {
            XCTAssertEqual(420, dayTwelve.partOne())
        }
    }

    func testDayTwelve_2_sample() {
        let dayTwelve = DayTwelve(input: makeInput(sample: true))
        XCTAssertEqual(286, dayTwelve.partTwo())
    }

    func testDayTwelve_2() {
        let dayTwelve = DayTwelve(input: makeInput())
        measure {
            XCTAssertEqual(42073, dayTwelve.partTwo())
        }
    }
}
