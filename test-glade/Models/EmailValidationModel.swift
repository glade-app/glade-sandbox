//
//  EmailValidation.swift
//  test-glade
//
//  Created by Allen Gu on 10/10/20.
//

import Foundation

struct EmailValidationModel {
    var validEmail: Bool = false
    var schoolEmailEndings = ["UC Berkeley": "@berkeley.edu"]
    mutating func validateEmail(school: String, email: String) {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: "([A-Za-z0-9.(),:;<>@!#$%&'*+-/=?^_`{|}~])+@berkeley.edu")
        validEmail = regex.firstMatch(in: email, options: [], range: range) != nil
    }
    func isValidEmail() -> Bool {
        return validEmail
    }
    func validEmailFeedback() -> String {
        if validEmail {
            return "Invalid email"
        }
        return "Valid email"
    }
}
