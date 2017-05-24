import UIKit

class LoginViewController: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.frame = UIScreen.main.bounds
        view.addSubview(loginView)
        loginView.layoutSubviews()
        loginView.delegate = self
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
