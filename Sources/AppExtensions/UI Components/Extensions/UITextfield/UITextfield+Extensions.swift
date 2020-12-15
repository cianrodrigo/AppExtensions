//
//  UITextfield+Extensions.swift
//  
//
//  Created by Cristian Carlassare on 25/11/2020.
//

import UIKit


// MARK: - Validatable

public extension UITextField {
    
    func validateText(rules: [ValidationRule]) throws {
        let selfText = self.text ?? ""
        try selfText.validateText(rules: rules)
    }
    
    func validateText(rules: [ValidationRule], errorLabel: UILabel) throws {
        let selfText = self.text ?? ""
        let validationError =  Validator.validate(text: selfText, with: rules)
        
        errorLabel.text = ""
        
        if let validationError = validationError {
            errorLabel.text = validationError.message
            throw validationError
        }
    }
}

@objc public protocol TextFieldDelegate {
    @objc optional func textFieldDidChangeText(_ textField: UITextField)
}


// MARK: - Show or Hide Password

public extension UITextField {
    
    func enablePasswordToggle(showImage: String, hideImage: String) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: showImage), for: .normal)
        button.setImage(UIImage(named: hideImage), for: .selected)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        
        self.rightView = button
        self.rightViewMode = .always
    }
    
    func disablePasswordToggle() {
        self.rightView = nil
        self.rightViewMode = .never
    }
    
    @IBAction func togglePasswordView(_ sender: Any) {
        self.togglePasswordVisibility()
        self.setPasswordToggleImage(button: sender as! UIButton)
    }
    
    
    fileprivate func setPasswordToggleImage(button: UIButton) {
        button.isSelected = !self.isSecureTextEntry
    }
    
    // This method avoids the behavior when the password is deleted after showing or hiding it
    fileprivate func togglePasswordVisibility() {
        self.isSecureTextEntry = !self.isSecureTextEntry

        if let existingText = text, self.isSecureTextEntry {
            self.deleteBackward()

            if let textRange = self.textRange(from: self.beginningOfDocument, to: self.endOfDocument) {
                self.replace(textRange, withText: existingText)
            }
        }
        
        if let existingSelectedTextRange = self.self.selectedTextRange {
            self.selectedTextRange = nil
            self.selectedTextRange = existingSelectedTextRange
        }
    }
}
