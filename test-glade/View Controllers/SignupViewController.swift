//
//  SignupViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var emailPromptLabel: UILabel!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var validationFeedbackLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    var userData: [String: String] = [:]
    var schoolName = "UC Berkeley"

    var emailValidation = EmailValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        // Vertical Stack
        verticalStack.spacing = 20
        
        // Top prompt
        emailPromptLabel.text = "Join with your school email:"
        //emailPromptLabel.textColor
        emailPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        emailPromptLabel.textAlignment = .left
        emailPromptLabel.numberOfLines = 0
        
        // Email Field
        self.emailField.delegate = self
        
        // Back Button
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(UIColor.systemGreen, for: .normal)
        backButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        backButton.titleLabel!.textAlignment = .center
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .center
    }
    
    // On tapping the next button, validate the email in the field: If valid, go to next view, else display feedback
    @IBAction func nextButtonTapped (_ sender: Any) {
        let inputEmail: String = (emailField.text ?? "").lowercased()
        emailValidation.validateEmail(school: schoolName, email: inputEmail)
        let isValid = emailValidation.isValidEmail()
        
        if !isValid {
            validationFeedbackLabel.text = emailValidation.emailValidationFeedback()
            validationFeedbackLabel.textColor = UIColor.red
        }
        else {
            validationFeedbackLabel.text = ""
            performSegue(withIdentifier: "toPassword", sender: self)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func tapGestureRecognizer(_ sender: Any) {
        emailField.resignFirstResponder()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
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
