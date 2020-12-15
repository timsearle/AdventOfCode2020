import XCTest
import AdventOfCode2020

class DayFifteenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayFifteen-sample" : "DayFifteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayFifteen_1_sample() {
        let dayFifteen = DayFifteen(input: makeInput(sample: true))
        XCTAssertEqual(436, dayFifteen.partOne())
    }

    func testDayFifteen_1() {
        let dayFifteen = DayFifteen(input: makeInput())
        XCTAssertEqual(319, dayFifteen.partOne())
    }

    func testDayFifteen_2() {
        let dayFifteen = DayFifteen(input: makeInput())
        XCTAssertEqual(2424, dayFifteen.partTwo())
    }
}
