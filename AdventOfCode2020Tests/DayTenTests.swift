import XCTest
import AdventOfCode2020

class DayTenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayTen-sample" : "DayTen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayTen_1_sample() {
        let dayTen = DayTen(input: makeInput(sample: true))
        XCTAssertEqual(35, dayTen.partOne())
    }

    func testDayTen_1() {
        let dayTen = DayTen(input: makeInput())
        measure {
            XCTAssertEqual(2263, dayTen.partOne())
        }
    }
}
