import UIKit

protocol NavigationCoordinator: Coordinator {
    var navigationController: UINavigationController { get set }
    var childViewControllers: [UIViewController] { get set }
    init(navigationController: UINavigationController)
}
