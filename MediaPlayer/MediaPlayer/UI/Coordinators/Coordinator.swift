import UIKit

protocol FlowCoordinator: class {
    weak var delegate: CoordinatorDelegate? { get set }
    func start()
}
