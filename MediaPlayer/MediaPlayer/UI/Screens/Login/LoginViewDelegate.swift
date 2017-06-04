//
//  LoginViewDelegate.swift
//  NewMediaPlayer
//
//  Created by Christopher Webb-Orenstein on 6/4/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import Foundation

protocol LoginViewDelegate: class {
    func submitButtonTapped()
    func usernameFieldDidAddText(text: String?)
}
