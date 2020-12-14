import XCTest
import AdventOfCode2020

class DayFourteenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayFourteen-sample" : "DayFourteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    private func makeInput2(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayFourteen-sample2" : "DayFourteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayFourteen_1_sample() {
        let dayFourteen = DayFourteen(input: makeInput(sample: true))
        XCTAssertEqual(165, dayFourteen.partOne())
    }

    func testDayFourteen_1() {
        let dayFourteen = DayFourteen(input: makeInput())
        XCTAssertEqual(11612740949946, dayFourteen.partOne())
    }

    func testDayFourteen_2_sample() {
        let dayFourteen = DayFourteen(input: makeInput2(sample: true))
        XCTAssertEqual(208, dayFourteen.partTwo())
    }

    func testDayFourteen_2() {
        let dayFourteen = DayFourteen(input: makeInput2())
        XCTAssertEqual(3394509207186, dayFourteen.partTwo())
    }
}
