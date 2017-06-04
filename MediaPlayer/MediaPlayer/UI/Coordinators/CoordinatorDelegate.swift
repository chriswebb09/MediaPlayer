import Foundation

protocol CoordinatorDelegate: class {
    func transitionCoordinator(type: CoordinatorType)
}

protocol TabDelegate: class {
    func tabOneSelected(selected: Bool)
    func tabTwoSelected(selected: Bool)
}
