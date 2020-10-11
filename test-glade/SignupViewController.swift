//
//  SignupViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit

class SignupViewController: UIViewController {

    @IBOutlet weak var validationFeedbackLabel: UILabel!
    @IBOutlet weak var emailFormInput: UITextField!
    
    var schoolName = "UC Berkeley"
    var emailValidation = EmailValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func toPasswordTapped(_ sender: Any) {
        if emailFormInput.text == "" {
            validationFeedbackLabel.text = "Email is required"
            validationFeedbackLabel.textColor = UIColor.darkGray
        }
        else {
            let inputEmail: String = (emailFormInput.text ?? "").lowercased()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPassword" {
            let passVC: PasswordViewController = segue.destination as! PasswordViewController
            passVC.email = emailFormInput.text!.lowercased()
        }
    }
}
