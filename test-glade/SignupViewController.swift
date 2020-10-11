//
//  SignupViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var validationFeedbackLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    
    var userData = ["email": "", "password": "", "spotifyID": "", "school": ""]
    var schoolName = "UC Berkeley"

    var emailValidation = EmailValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toPasswordTapped(_ sender: Any) {
        if emailField.text == "" {
            validationFeedbackLabel.text = "Email is required"
            validationFeedbackLabel.textColor = UIColor.darkGray
        }
        else {
            let inputEmail: String = (emailField.text ?? "").lowercased()
            emailValidation.validateEmail(school: schoolName, email: inputEmail)
            let isValid = emailValidation.isValidEmail()
            if !isValid {
                validationFeedbackLabel.text = "Invalid " + schoolName + " email"
                validationFeedbackLabel.textColor = UIColor.red
            }
            else {
                validationFeedbackLabel.text = ""
                performSegue(withIdentifier: "toPassword", sender: self)
            }
        }
    }
    @IBAction func backToSchoolsTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToSchools", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPassword" {
            let passVC: PasswordViewController = segue.destination as! PasswordViewController
            userData["email"] = emailField.text!.lowercased()
            userData["school"] = schoolName
            passVC.userData = userData
        }
    }
}
