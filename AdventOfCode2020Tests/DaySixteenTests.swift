import XCTest
import AdventOfCode2020

class DaySixteenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> String {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DaySixteen-sample" : "DaySixteen", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
    }

    func testDaySixteen_1_sample() {
        let daySixteen = DaySixteen(input: makeInput(sample: true))
        XCTAssertEqual(71, daySixteen.partOne())
    }

    func testDaySixteen_1() {
        let daySixteen = DaySixteen(input: makeInput())
        measure {
            XCTAssertEqual(27911, daySixteen.partOne())
        }
    }

    func testDaySixteen_2() {
        let daySixteen = DaySixteen(input: makeInput())
        measure {
            XCTAssertEqual(737176602479, daySixteen.partTwo())
        }
    }
}
