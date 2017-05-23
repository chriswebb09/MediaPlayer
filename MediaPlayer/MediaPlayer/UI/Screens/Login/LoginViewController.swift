import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.frame = UIScreen.main.bounds
        view.addSubview(loginView)
        loginView.layoutSubviews()
        navigationController?.isNavigationBarHidden = false
    }
}
