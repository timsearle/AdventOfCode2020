import Foundation

public final class DayThirteen {
    let earliestTime: Int
    let busIDs: [Int]
    let rawBusIDs: [String]
    
    public init(input: String) {
        let items = input.components(separatedBy: .newlines)
        earliestTime = Int(items[0])!
        rawBusIDs = items[1].components(separatedBy: ",")
        busIDs = rawBusIDs.compactMap { Int($0) }
    }

    public func partOne() -> Int {
        let (bus, departureTime) = busIDs
            .map { ($0, Int(ceil(Float(earliestTime) / Float($0)) * Float($0))) }
            .min { $0.1 < $1.1 }!

        return (departureTime - earliestTime) * bus
    }

    public func partTwo() -> Int {
        return 0
    }
}
