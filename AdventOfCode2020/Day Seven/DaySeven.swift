import Foundation

public final class DaySeven {
    private let bags: [String: [String]]
    private let target: String

    var visited = Set<String>()

    public init(bags: [String: [String]], target: String = "shiny gold") {
        self.bags = bags
        self.target = target
    }

    public func partOne() -> Int {
        var count = 0

        for (bag, _) in bags where bag != target {
            visited.removeAll()
            count += dfs(name: target, bag: bag)
        }

        return count
    }

    public func partTwo() -> Int {
        countChildren(bag: target)
    }

    private func countChildren(bag: String) -> Int {
        let children = bags[bag]!

        return children.reduce(children.count) { count, child in
            count + countChildren(bag: child)
        }
    }

    private func dfs(name: String, bag: String) -> Int {
        visited.insert(bag)

        var count = 0

        if bag == name {
            return 1
        } else {
            for containedBag in bags[bag]! {
                if !visited.contains(containedBag) {
                    count += dfs(name: name, bag: containedBag)
                }
            }
        }

        return count
    }
}
