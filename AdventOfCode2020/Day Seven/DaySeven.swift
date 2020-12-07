import Foundation

final class DaySeven {
    private let bags: [String: [String]]

    var visited = Set<String>()

    init(bags: [String: [String]]) {
        self.bags = bags
    }

    func partOne() -> Int {
        var count = 0

        for (bag, _) in bags where bag != "shiny gold bag" {
            visited.removeAll()
            count += dfs(name: "shiny gold bag", bag: bag)
        }

        return count
    }

    func partTwo() -> Int {
        return countChildren(bag: "shiny gold bag")
    }

    func countChildren(bag: String) -> Int {
        guard let children = bags[bag], !children.isEmpty else {
            return 0
        }

        var count = children.count

        for child in children {
            count += countChildren(bag: child)
        }

        return count
    }

    func dfs(name: String, bag: String) -> Int {
        visited.insert(bag)
        var count = 0

        if bag == name {
            return 1
        } else {
            for containedBag in bags[bag] ?? [] {
                if !visited.contains(containedBag) {
                    count += dfs(name: name, bag: containedBag)
                }
            }
        }

        return count
    }
}
