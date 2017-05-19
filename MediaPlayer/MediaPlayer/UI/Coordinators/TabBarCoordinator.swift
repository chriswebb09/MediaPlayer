import UIKit

protocol TabBarCoordinator: Coordinator {
    var tabBarController: UITabBarController { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    init(tabBarController: UITabBarController)
}
