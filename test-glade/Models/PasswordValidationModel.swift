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
        // Check for valid password
        else {
            let range = NSRange(location: 0, length: firstPass.utf16.count)
            // Check for letter
            let regexAlphabet = try! NSRegularExpression(pattern: "[A-Za-z]")
            // Check for number
            let regexNumber = try! NSRegularExpression(pattern: "[0-9]")
            // Check for special character
            let regexSpecial = try! NSRegularExpression(pattern: "[!@#$%^&*_+=]")
            // Check for a letter
            if firstPass.count < 8 || regexAlphabet.firstMatch(in: firstPass, options: [], range: range) == nil || regexNumber.firstMatch(in: firstPass, options: [], range: range) == nil || regexSpecial.firstMatch(in: firstPass, options: [], range: range) == nil{
                failedCase = "Password must be at least 8 characters and contain a letter, number, and special character"
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
        return "Valid Password"
    }
}
