//
//  String+Extensions.swift
//  
//
//  Created by Rodrigo Cian Berrios on 19/11/2020.
//

import Foundation

public extension String {
    
    static var forcedLanguage: String?
    
    // MARK: - Localization
    
    var localized: String {
        if let forcedLanguage = String.forcedLanguage  {
            return self.localized(for: forcedLanguage)
        }
        
        return NSLocalizedString(self, comment: "")
    }
    
    fileprivate func localized(for language: String) -> String {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")!
        let bundle = Bundle(path: path)!
        let localizedString = NSLocalizedString(self, bundle: bundle, comment: "")
        
        return localizedString
    }

}


// MARK: - Validations

public extension String {
    
    fileprivate static let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    
    var isBackSpace: Bool {
        let char = self.cString(using: String.Encoding.utf8)!
        let backSpace = strcmp(char, "\\b")
        
        if backSpace == -92 {
            return true
        }
        
        return false
    }
    
    var isEmail: Bool {
        return String.emailPredicate.evaluate(with: self)
    }
    
    var isAlphaNumeric: Bool {
        let invalidChars = NSCharacterSet.alphanumerics.inverted
        let range = self.rangeOfCharacter(from: invalidChars)
        
        if range != nil {
            return false
        }
        
        return true
    }
    
    
    // MARK: Add Text considering BackSpace
    
    func addingText(_ text: String) -> String {
        if (text.isBackSpace) {
            return self.substring(to: self.index(before: self.endIndex))
        } else {
            return self + text
        }
    }
    
    mutating func addText(_ text: String) {
        if (text.isBackSpace) {
            self = self.substring(to: self.index(before: self.endIndex))
        } else {
            self = self + text
        }
    }
}


// MARK: - Validatable

public extension String {
    
    func validateText(rules: [ValidationRule]) throws {
        let validationError =  Validator.validate(text: self, with: rules)
        
        if let validationError = validationError {
            throw validationError
        }
    }
}
