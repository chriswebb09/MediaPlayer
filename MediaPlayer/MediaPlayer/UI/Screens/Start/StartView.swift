import UIKit

final class StartView: UIView {
    
    weak var delegate: StartViewDelegate?
    
   private var titleLabel: UILabel = {
        let title = UILabel()
        title.textAlignment = .center
        return title
    }()
    
    private var guestUserButton: UIButton = {
        let guestUser = BasicButtonFactory(text: "Continue As Guest", textColor: .white, buttonBorderWidth: 2, buttonBorderColor:UIColor.blue.cgColor, buttonBackgroundColor: .lightGray)
        return guestUser.createButton()
    }()
    
    private var userLoginButton: UIButton = {
        let userLogin = LoginButtonFactory(text: "Log in to Account", textColor: .white, buttonBorderWidth: 2, buttonBorderColor: UIColor.blue.cgColor, buttonBackgroundColor: .blue)
        return userLogin.createButton()
    }()
    
    private var createAccountButton: UIButton = {
        let createAccount = LoginButtonFactory(text: "Create Account", textColor: .white, buttonBorderWidth: 2, buttonBorderColor: UIColor.blue.cgColor, buttonBackgroundColor: .blue)
        return createAccount.createButton()
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupElements()
        titleLabel.text = "Get started!"
        backgroundColor = .white
        setupSelectors()
    }
    
   private func setupElements() {
        setup(titleLabel: titleLabel)
        setup(guestUserButton: guestUserButton)
        setup(loginButton: userLoginButton)
        setup(createAccountButton: createAccountButton)
    }
    
    private func setupSelectors() {
        createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        guestUserButton.addTarget(self, action: #selector(guestUserButtonTapped), for: .touchUpInside)
        userLoginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func guestUserButtonTapped() {
        delegate?.continueAsGuestTapped()
    }
    
    func createAccountButtonTapped() {
        delegate?.createAccountTapped()
    }
    
    func loginButtonTapped() {
        delegate?.loginTapped()
    }
    
    private func setup(titleLabel: UILabel) {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * -0.25).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
   private func setup(guestUserButton: UIButton) {
        addSubview(guestUserButton)
        guestUserButton.translatesAutoresizingMaskIntoConstraints = false
        guestUserButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        guestUserButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * -0.1).isActive = true
        guestUserButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        guestUserButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setup(loginButton: UIButton) {
        addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        loginButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
    
    private func setup(createAccountButton: UIButton) {
        addSubview(createAccountButton)
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        createAccountButton.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * 0.25).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4).isActive = true
        createAccountButton.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1).isActive = true
    }
}
