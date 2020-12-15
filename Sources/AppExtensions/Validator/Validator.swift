//
//  Validator.swift
//  
//
//  Created by Cristian Carlassare on 25/11/2020.
//

import UIKit


// MARK: - Validator

public struct Validator {
    
    fileprivate init() {}
    
    static fileprivate func stringValidate(text: String, with rules: [ValidationRule]) -> String? {
        return rules.compactMap({ $0.check(text) }).first
    }
    
    static func validate(text: String, with rules: [ValidationRule]) -> ValidationError? {
        let stringError = Validator.stringValidate(text: text, with: rules)
        
        if let stringError = stringError {
            return ValidationError(stringError)
        }
        
        return nil
    }
}


// MARK: - ValidationRule

public struct ValidationRule {
    
    public init(check: @escaping (String) -> String?) {
        self.check = check
    }
    
    // Return nil if matches, error message otherwise
    var check: (String) -> String?
}


public struct ValidationError: Error {
    var message: String
    
    init(_ message: String) {
        self.message = message.localized
    }
}
