import UIKit

protocol NavigationCoordinator: FlowCoordinator {
    var navigationController: UINavigationController { get set }
    var childViewControllers: [UIViewController] { get set }
    init(navigationController: UINavigationController)
}
