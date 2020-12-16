import Foundation

struct TicketSectionFormat {
    let sections: (String, [Range<Int>])

    func isValid(_ value: Int) -> Bool {
        for range in sections.1 {
            if value >= range.lowerBound && value <= range.upperBound {
                return true
            }
        }

        return false
    }
}

struct Ticket {
    let sectionValues: [Int]

    func invalidEntries(against ticketFormat: [TicketSectionFormat]) -> [Int] {
        var invalid = [Int]()

        for value in sectionValues {
            var isValid = false

            for format in ticketFormat {
                if format.isValid(value) {
                    isValid = true
                    break
                }
            }

            if !isValid {
                invalid.append(value)
            }
        }

        return invalid
    }
}

public final class DaySixteen {
    private let ticketFormat: [TicketSectionFormat]
    private let ticket: Ticket
    private let otherTickets: [Ticket]
    private let validTickets: [Ticket]

    public init(input: String) {
        let inputSections = input.components(separatedBy: "\n\n")
        let sectionLines = inputSections.map { $0.components(separatedBy: .newlines)}

        let rules = sectionLines[0]
        let myTicket = sectionLines[1]
        let nearbyTickets = sectionLines[2]

        let formats = rules.map { $0.components(separatedBy: ":")}

        let ticketFormat = formats.map { entry -> TicketSectionFormat in
            let name = entry[0]
            let ranges = entry[1]
                .trimmingCharacters(in: .whitespaces)
                .components(separatedBy: " or ")
                .map { rangeString -> Range<Int> in
                    let rangeValues = rangeString.components(separatedBy: "-")
                    return Range(uncheckedBounds: (Int(rangeValues[0])!, Int(rangeValues[1])!))
                }
            return TicketSectionFormat(sections: (name, ranges))
        }

        let ticket = Ticket(sectionValues: myTicket[1]
                            .components(separatedBy: ",")
                            .compactMap { Int($0) })

        let otherTickets = nearbyTickets
            .dropFirst()
            .dropLast()
            .map { Ticket(sectionValues: $0.components(separatedBy: ",")
                            .compactMap { Int($0) })}

        let validTickets = otherTickets.filter { $0.invalidEntries(against: ticketFormat).isEmpty }

        self.ticketFormat = ticketFormat
        self.ticket = ticket
        self.otherTickets = otherTickets
        self.validTickets = validTickets
    }

    public func partOne() -> Int {
        var errorRate = 0

        for ticket in otherTickets {
            errorRate += ticket.invalidEntries(against: ticketFormat).reduce(0, +)
        }

        return errorRate
    }

    public func partTwo() -> Int {
        var knownValues = Array(repeating: "", count: ticketFormat.count)
        var knownValuesCount = 0

        while knownValuesCount != ticketFormat.count {
            for i in 0..<ticketFormat.count {
                var potentialValues = Set(ticketFormat.map { $0.sections.0 }).subtracting(knownValues)

                for ticket in validTickets {
                    for format in ticketFormat {
                        if !format.isValid(ticket.sectionValues[i]) {
                            potentialValues.remove(format.sections.0)
                        }
                    }
                }

                if potentialValues.count == 1 {
                    knownValues[i] = potentialValues.first!
                    knownValuesCount += 1
                }
            }
        }

        return (0..<knownValues.count)
            .compactMap { knownValues[$0].contains("departure") ? $0 : nil }
            .map { ticket.sectionValues[$0] }
            .reduce(1, *)
    }
}
