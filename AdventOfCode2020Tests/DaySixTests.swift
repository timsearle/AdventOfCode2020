import XCTest
@testable import AdventOfCode2020

class DaySixTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> [[String]] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DaySix-sample" : "DaySix", withExtension: "txt")!
        return try! String(contentsOf: inputURL)
            .components(separatedBy: "\n\n")
            .map { $0.components(separatedBy: "\n") }
            .map { $0.filter { !$0.isEmpty } }
    }

    func testDaySix_1_sample() {
        let daySix = DaySix(answerGroups: makeInput(sample: true))
        XCTAssertEqual(11, daySix.partOne())
    }

    func testDaySix_1() {
        let daySix = DaySix(answerGroups: makeInput())
        XCTAssertEqual(6885, daySix.partOne())
    }

    func testDaySix_2_sample() {
        let daySix = DaySix(answerGroups: makeInput(sample: true))
        XCTAssertEqual(6, daySix.partTwo())
    }

    func testDaySix_2() {
        let daySix = DaySix(answerGroups: makeInput())
        XCTAssertEqual(3550, daySix.partTwo())
    }
}
