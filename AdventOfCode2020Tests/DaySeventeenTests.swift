import XCTest
import AdventOfCode2020

class DaySeventeenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DaySeventeen-sample" : "DaySeventeen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDaySeventeen_1_sample() {
        let daySeventeen = DaySeventeen(input: makeInput(sample: true))
        XCTAssertEqual(112, daySeventeen.partOne())
    }

    func testDaySeventeen_1() {
        let daySeventeen = DaySeventeen(input: makeInput())
        measure {
            XCTAssertEqual(317, daySeventeen.partOne())
        }
    }

    func testDaySeventeen_2_sample() {
        let daySeventeen = DaySeventeen(input: makeInput(sample: true))
        XCTAssertEqual(848, daySeventeen.partTwo())
    }

    func testDaySeventeen_2() {
        let daySeventeen = DaySeventeen(input: makeInput())
        XCTAssertEqual(1692, daySeventeen.partTwo())
    }
}
