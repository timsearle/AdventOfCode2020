import XCTest
import AdventOfCode2020

class DayThirteenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DayThirteen-sample" : "DayThirteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDayThirteen_1_sample() {
        let dayThirteen = DayThirteen(input: makeInput(sample: true))
        XCTAssertEqual(295, dayThirteen.partOne())
    }

    func testDayThirteen_1() {
        let dayThirteen = DayThirteen(input: makeInput())
        measure {
            XCTAssertEqual(203, dayThirteen.partOne())
        }
    }

    func testDayThirteen_2_micro_example() {
        let dayThirteen = DayThirteen(input: "123\n17,x,13,19")
        measure {
            XCTAssertEqual(3417, dayThirteen.partTwo())
        }
    }
}
