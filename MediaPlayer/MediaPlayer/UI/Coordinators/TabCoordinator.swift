import UIKit

protocol TabCoordinator: FlowCoordinator {
    var tabBarController: TabBarController { get set }
    var childCoordinators: [NavigationCoordinator] { get set }
    init(tabBarController: TabBarController)
}
