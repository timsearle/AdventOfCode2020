import XCTest
import AdventOfCode2020

class DayEighteenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayEighteen-sample" : "DayEighteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayEighteen_1_sample() {
        let dayEighteen = DayEighteen(input: makeInput(sample: true))
        XCTAssertEqual(26335, dayEighteen.partOne())
    }

    func testDayEighteen_1() {
        let dayEighteen = DayEighteen(input: makeInput())
        XCTAssertEqual(26335, dayEighteen.partOne())
    }
}
