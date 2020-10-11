//
//  PasswordValidationModel.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import Foundation

struct PasswordValidationModel {
    var validPassword: Bool = false
    var failedCase: String = ""
    
    mutating func validatePassword(firstPass: String, confirmedPass: String) {
        validPassword = false
        // Check if passwords match
        if firstPass != confirmedPass {
            failedCase = "Passwords don't match"
        }
        // Check if password is at least 8 characters
        else if firstPass.count < 8 {
            failedCase = "Password must be at least 8 characters"
        }
        // Check for specific characters
        else {
            let range = NSRange(location: 0, length: firstPass.utf16.count)
            let regexAlphabet = try! NSRegularExpression(pattern: "[A-Za-z]")
            let regexNumber = try! NSRegularExpression(pattern: "[0-9]")
            let regexSpecial = try! NSRegularExpression(pattern: "[!@#$%^&*_-+=]")
            // Check for a letter
            if regexAlphabet.firstMatch(in: firstPass, options: [], range: range) != nil {
                failedCase = "Must contain a letter"
            }
            // Check for a number
            else if regexNumber.firstMatch(in: firstPass, options: [], range: range) != nil {
                failedCase = "Must contain a number"
            }
            // Check for a special character (!@#$%^&*_-+=)
            else if regexSpecial.firstMatch(in: firstPass, options: [], range: range) != nil {
                failedCase = "Must contain one of these characters: !@#$%^&*_-+="
            }
            else {
                validPassword = true
            }
        }
    }
    func isValidPassword() -> Bool {
        return validPassword
    }
    func validPasswordFeedback() -> String {
        if !validPassword {
            return failedCase
        }
        return "Valid email"
    }
}
