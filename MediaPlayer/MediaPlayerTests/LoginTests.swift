//
//  LoginTests.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 6/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import XCTest
@testable import NewMediaPlayer
class LoginTests: XCTestCase {
    
    var loginView: LoginView!
    var loginViewController: LoginViewController!
    var loginViewModel: LoginViewModel!
    
    override func setUp() {
        super.setUp()
        loginViewModel = LoginViewModel()
        loginView = LoginView()
        loginViewController = LoginViewController(loginView: loginView)
    }
    
    override func tearDown() {
        super.tearDown()
        loginView = nil
        loginViewController = nil
        loginViewModel = nil
    }
    
    func testSubmitButtonEnabledToggle() {
        let username = "example.email.@gmail.com"
        loginView.configure(model: loginViewModel)
        let textField = UITextField()
        textField.text = username
        loginView.textFieldDidEndEditing(textField)
        XCTAssertTrue(loginView.model.submitEnabled)
        textField.text = ""
        loginView.textFieldDidEndEditing(textField)
        XCTAssertFalse(loginView.model.submitEnabled)
    }
}
