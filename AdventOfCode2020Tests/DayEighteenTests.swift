import XCTest
import AdventOfCode2020

class DayEighteenTests: XCTestCase {
    private func makeInput(sample: Bool = false, value: String? = nil) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayEighteen-sample\(value!)" : "DayEighteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayEighteen_1_sample() {
        let dayEighteen = DayEighteen(input: makeInput(sample: true, value: "1"))
        XCTAssertEqual(26335, dayEighteen.partOne())
    }

    func testDayEighteen_1() {
        let dayEighteen = DayEighteen(input: makeInput())
        XCTAssertEqual(6640667297513, dayEighteen.partOne())
    }

    func testDayEighteen_2_sample() {
        let dayEighteen = DayEighteen(input: makeInput(sample: true, value: "2"))
        XCTAssertEqual(693942, dayEighteen.partTwo())
    }

    func testDayEighteen_2() {
        let dayEighteen = DayEighteen(input: makeInput())
        XCTAssertEqual(451589894841552, dayEighteen.partTwo())
    }
}
