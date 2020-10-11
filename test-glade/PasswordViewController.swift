//
//  PasswordViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit

class PasswordViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    
    var email: String = ""
    var passwordValidation = PasswordValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toSpotifyConnectTapped(_ sender: Any) {
        let password: String = passwordField.text ?? ""
        let confirmPassword: String = confirmPasswordField.text ?? ""
        passwordValidation.validatePassword(firstPass: password, confirmedPass: confirmPassword)
        if passwordValidation.isValidPassword() {
            performSegue(withIdentifier: "toSpotifyConnect", sender: self)
            passwordFeedbackLabel.textColor = UIColor.darkGray
        }
        else {
            passwordFeedbackLabel.text = passwordValidation.validPasswordFeedback()
            passwordFeedbackLabel.textColor = UIColor.red
        }

    }
    @IBAction func backToSignupTapped(_ sender: Any) {
        performSegue(withIdentifier: "backToSignup", sender: self)
    }
}
