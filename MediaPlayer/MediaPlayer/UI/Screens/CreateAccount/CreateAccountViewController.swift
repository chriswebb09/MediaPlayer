import UIKit

class CreateAccountViewController: UIViewController {
    
    let createAccountView = CreateAccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      createAccountView.frame = UIScreen.main.bounds
        view = createAccountView
        view.layoutSubviews()
        title = "Create Account"
        
        navigationController?.navigationBar.isHidden = false
    }
}
