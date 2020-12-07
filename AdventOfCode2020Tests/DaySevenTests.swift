import XCTest
import AdventOfCode2020

class DaySevenTests: XCTestCase {
    private func makeInput(sample: Bool = false) -> [String: [String]] {
        let inputURL = Bundle(for: type(of: self)).url(forResource: sample ? "DaySeven-sample" : "DaySeven", withExtension: "txt")!
        let bagSpec = try! String(contentsOf: inputURL)
            .replacingOccurrences(of: "bags", with: "")
            .replacingOccurrences(of: "bag", with: "")
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map { $0.components(separatedBy: "contain") }
            .map {$0.trimmingCharacters(in: .whitespaces) }

        var bags = [String: [String]]()

        for entry in bagSpec {
            let parent = entry[0]
            let children = entry[1]
                .components(separatedBy: ",")
                .trimmingCharacters(in: .whitespacesAndPunctuation)

            var newChildren = [String]()

            for child in children where child != "no other" {
                let bagNumber = Int(child[0])!

                for _ in 0..<bagNumber {
                    newChildren.append(child.removingDigits().trimmingCharacters(in: .whitespacesAndPunctuation))
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

    func testDaySeven_2_performance() {
        let daySeven = DaySeven(bags: makeInput())
        measure {
            XCTAssertEqual(18885, daySeven.partTwo())
        }
    }
}
