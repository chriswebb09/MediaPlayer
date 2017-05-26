import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.frame = UIScreen.main.bounds
        loginView.delegate = self
        view = loginView
        view.layoutSubviews()
        title = "Login"
        navigationController?.isNavigationBarHidden = false
    }
}


extension LoginViewController: LoginViewDelegate {
    
    func usernameFieldDidAddText(text: String?) {
        print(text)
    }
    
    func submitButtonTapped() {
        print("Submitted")
        delegate?.loginButtonTapped()
    }
    
    
}
