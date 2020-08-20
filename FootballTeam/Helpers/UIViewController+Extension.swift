//
//  UIViewController+Extension.swift
//  FootballTeam
//
//  Created by Polina on 20.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Настройка клавиатуры
    
    func setKeyboardNotification() {
        if UIScreen.main.bounds.size.height <= 667 {
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillShow),
                                                   name: UIResponder.keyboardWillShowNotification,
                                                   object: nil)
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(keyboardWillHide),
                                                   name: UIResponder.keyboardWillHideNotification,
                                                   object: nil)
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == .zero {
                view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != .zero {
            view.frame.origin.y = .zero
        }
    }
}
