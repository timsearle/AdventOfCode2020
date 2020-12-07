import XCTest
@testable import AdventOfCode2020

class DaySevenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> [String: [String]] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DaySeven-sample" : "DaySeven", withExtension: "txt")!
        let bagSpec = try! String(contentsOf: inputURL)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { $0.components(separatedBy: "contain").map { $0.trimmingCharacters(in: .whitespaces) } }

        var bags = [String: [String]]()

        for entry in bagSpec {
            let parent = entry[0].replacingOccurrences(of: "bags", with: "bag")
            let children = entry[1].components(separatedBy: ",").map { $0.replacingOccurrences(of: "bags", with: "bag").trimmingCharacters(in: CharacterSet.whitespaces.union(CharacterSet.punctuationCharacters)) }

            var newChildren = [String]()
            for child in children {
                if child == "no other bag" { continue }
                let bagNumber = Int(child[0])!

                for _ in 0..<bagNumber {
                    newChildren.append(child.components(separatedBy: .decimalDigits).joined().trimmingCharacters(in: CharacterSet.whitespaces.union(CharacterSet.punctuationCharacters)))
                }
            }

            var existing = bags[parent] ?? []
            existing.append(contentsOf: newChildren)
            bags[parent] = existing
        }

        return bags
    }

    func testDaySeven_1_sample() {
        let daySeven = DaySeven(bags: makeInput(sample: true))
        XCTAssertEqual(4, daySeven.partOne())
    }

    func testDaySeven_1() {
        let daySeven = DaySeven(bags: makeInput())
        XCTAssertEqual(348, daySeven.partOne())
    }

    func testDaySeven_1_performance() {
        let daySeven = DaySeven(bags: makeInput())
        measure {
            XCTAssertEqual(348, daySeven.partOne())
        }
    }

    func testDaySeven_2_sample() {
        let daySeven = DaySeven(bags: makeInput(sample: true))
        XCTAssertEqual(32, daySeven.partTwo())
    }

    func testDaySeven_2() {
        let daySeven = DaySeven(bags: makeInput())
        XCTAssertEqual(18885, daySeven.partTwo())
    }
}
