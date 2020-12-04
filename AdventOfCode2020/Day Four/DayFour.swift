import Foundation
import Cocoa

public final class DayFour {
    private let passports: [[String: String]]

    public init(passports: [[String: String]]) {
        self.passports = passports
    }

    private func validPassports() -> [[String: String]] {
        var result = [[String: String]]()

        for passport in passports {
            var isValid = true

            for entry in ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"] {
                if passport[entry] == nil {
                    isValid = false
                }
            }

            if isValid {
                result.append(passport)
            }
        }

        return result
    }

    public func partOne() -> Int {
        validPassports().count
    }

    public func partTwo() -> Int {
        validPassports()
            .filter { passport in
                validBirthYear(passport["byr"]!) &&
                validIssueYear(passport["iyr"]!) &&
                validExpYear(passport["eyr"]!) &&
                validHeight(passport["hgt"]!) &&
                validHairColor(passport["hcl"]!) &&
                validEyeColor(passport["ecl"]!) &&
                validPassportId(passport["pid"]!)
            }
            .count
    }

    private func validBirthYear(_ value: String) -> Bool {
        guard let value = Int(value) else {
            return false
        }

        return (1920...2002).contains(value)
    }

    private func validIssueYear(_ value: String) -> Bool {
        guard let value = Int(value) else {
            return false
        }

        return (2010...2020).contains(value)
    }

    private func validExpYear(_ value: String) -> Bool {
        guard let value = Int(value) else {
            return false
        }

        return (2020...2030).contains(value)
    }

    private func validHeight(_ value: String) -> Bool {
        var value = value
        let unit = String(value.suffix(2))
        value.removeLast(2)

        guard let number = Int(value) else {
            return false
        }

        if unit == "cm" {
            return (150...193).contains(number)
        } else if unit == "in" {
            return (59...76).contains(number)
        }

        return false
    }

    private func validHairColor(_ value: String) -> Bool {
        let expression = try! NSRegularExpression(pattern: "^#[0-9a-fA-F]{6}$", options: [])
        return expression.firstMatch(in: value,
                                     options: [],
                                     range: NSRange(location: 0, length: value.count)) != nil
    }

    private func validEyeColor(_ value: String) -> Bool {
        ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"].contains(value)
    }

    private func validPassportId(_ value: String) -> Bool {
        value.count == 9 && (Int(value)) != nil
    }
}
