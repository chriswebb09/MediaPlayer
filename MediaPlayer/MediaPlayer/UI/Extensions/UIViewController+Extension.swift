//
//  UIViewController+Extension.swift
//  MediaPlayer
//
//  Created by Christopher Webb-Orenstein on 5/19/17.
//  Copyright © 2017 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit

extension UIViewController {
    func setSearchBarColor(searchBar: UISearchBar) {
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
    }
    
    func setupDefaultUI() {
        let cancelButtonAttributes: NSDictionary = [NSForegroundColorAttributeName: UIColor.textColor]
        UIBarButtonItem.appearance().setTitleTextAttributes(cancelButtonAttributes as? [String : AnyObject], for: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.textColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search for tracks...", attributes: [NSForegroundColorAttributeName: UIColor.white])
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .white
    }
    
}
