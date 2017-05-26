//
//  LoginViewProtocol.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/21/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol LoginViewDelegate: class {
    func submitButtonTapped()
    func usernameFieldDidAddText(text: String?)
}

protocol LoginViewControllerDelegate: class {
    func loginButtonTapped()
}
