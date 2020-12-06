import Foundation

final class DaySix {
    private let answerGroups: [[String]]

    init(answerGroups: [[String]]) {
        self.answerGroups = answerGroups
    }

    func partOne() -> Int {
        var total = 0

        for group in answerGroups {
            var set = Set<Character>()

            for form in group {
                for character in form {
                    set.insert(character)
                }
            }

            total += set.count
        }

        return total
    }

    func partTwo() -> Int {
        var total = 0

        for answerList in answerGroups {
            var set = Set<Character>(answerList[0].map { $0 })

            for person in answerList {
                guard !set.isEmpty else {
                    break
                }

                set = set.intersection(Set(person.map { $0 }))
            }

            total += set.count
        }

        return total
    }
}
