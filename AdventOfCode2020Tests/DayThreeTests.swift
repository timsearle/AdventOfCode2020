import XCTest
import AdventOfCode2020

class DayThreeTests: XCTestCase {
    private func makeInput() -> [[String]] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: "DayThree", withExtension: "txt")!
        let rows = try! String(contentsOf: inputURL).components(separatedBy: .newlines)
        var result = rows.map { $0.map { String($0) } }
        result.removeLast()
        return result
    }

    func testDayThree_1() {
        let dayThree = DayThree(input: makeInput())
        print(dayThree.partOne())
    }

    func testDayThree_2() {
        let dayThree = DayThree(input: makeInput())
        print(dayThree.partTwo())
    }

}
