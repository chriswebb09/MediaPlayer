import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.frame = UIScreen.main.bounds
        loginView.delegate = self
        view = loginView
        view.layoutSubviews()
        navigationController?.isNavigationBarHidden = false
    }
}


extension LoginViewController: LoginViewDelegate {
    func usernameFieldDidAddText(text: String?) {
        print(text)
    }
    
    
    func submitButtonTapped() {
        // None
    }
    
    
}
