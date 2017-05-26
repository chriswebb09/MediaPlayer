import UIKit

protocol Coordinator {
    weak var delegate: CoordinatorDelegate? { get set }
    var type: CoordinatorType { get set }
    func start(viewController: UIViewController)
}

