import UIKit

final class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    var model: LoginViewModel! {
        didSet {
            model.submitEnabled = model.username.isValidEmail() ? true : false
        }
    }
    
    // MARK: - UI Elements
    
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Login"
        titleLabel.font = UIFont(name:"Avenir", size: 22)!
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    fileprivate var usernameField: TextFieldExtension = {
        return TextFieldExtension.emailField("Email")
    }()
    
    private var passwordField: TextFieldExtension = {
        return TextFieldExtension.passwordField()
    }()
    
    fileprivate var submitButton: UIButton = {
        let submitButton = BasicButtonFactory(text: "Login",
                                              textColor: .white,
                                              buttonBorderWidth: 2,
                                              buttonBorderColor: UIColor.lightText.cgColor,
                                              buttonBackgroundColor: UIColor(red:0.92, green:0.32, blue:0.33, alpha:1.0))
        return submitButton.createButton()
    }()
    
    override func layoutSubviews() {
        tag = 1
        super.layoutSubviews()
        backgroundColor = .white
        usernameField.delegate = self
        setup(titleLabel: titleLabel)
        setup(usernamefield: usernameField)
        setup(passwordField: passwordField)
        setup(submitButton: submitButton)
        submitButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    }
    
    func configure(model: LoginViewModel) {
        self.model = model
        submitButton.isEnabled = model.submitEnabled
    }
    
    private func sharedLayout(view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.09).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
    }
    
    private func setup(titleLabel: UILabel) {
        sharedLayout(view: titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: UIScreen.main.bounds.height * -0.25).isActive = true
    }
    
    private func setup(usernamefield: TextFieldExtension) {
        sharedLayout(view: usernameField)
        usernamefield.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIScreen.main.bounds.height * 0.07).isActive = true
    }
    
    private func setup(passwordField: TextFieldExtension) {
        sharedLayout(view: passwordField)
        passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.09).isActive = true
    }
    
    private func setup(submitButton: UIButton) {
        sharedLayout(view: submitButton)
        submitButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: UIScreen.main.bounds.height * 0.09).isActive = true
    }
    
    func loginButtonTapped() {
        delegate?.submitButtonTapped()
    }
}

// MARK: - UITextFieldDelegate

extension LoginView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        model.username = text
        submitButton.isEnabled = model.submitEnabled
        delegate?.usernameFieldDidAddText(text: usernameField.text)
    }
}
