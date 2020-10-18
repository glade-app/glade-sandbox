//
//  PasswordViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit

class PasswordViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var passwordPromptLabel: UILabel!
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var passwordFeedbackLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var userData: [String: String] = [:]
    var passwordValidation = PasswordValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        // Vertical Stack
        verticalStack.spacing = 20
        
        // Top prompt
        passwordPromptLabel.text = "Create a password"
        //passwordPromptLabel.textColor
        passwordPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        passwordPromptLabel.textAlignment = .left
        passwordPromptLabel.numberOfLines = 0
        
        // Password field
        self.passwordField.delegate = self
        
        // Confirm password field
        self.confirmPasswordField.delegate = self
        
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
    
    // On next button tap, validates email: If valid, sends user to next view, else displays feedback
    @IBAction func nextButtonTapped(_ sender: Any) {
        let password: String = passwordField.text ?? ""
        let confirmPassword: String = confirmPasswordField.text ?? ""
        passwordValidation.validatePassword(firstPass: password, confirmedPass: confirmPassword)
        if !passwordValidation.isValidPassword() {
            passwordFeedbackLabel.text = passwordValidation.validPasswordFeedback()
            passwordFeedbackLabel.textColor = UIColor.red
        }
        else {
            performSegue(withIdentifier: "toSpotifyConnect", sender: self)
            passwordFeedbackLabel.textColor = UIColor.darkGray
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        passwordField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
    }
    
    @IBAction func backButtonTapped (_ sender: Any) {
        performSegue(withIdentifier: "backToSignup", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSpotifyConnect" {
            let spotifyVC: SpotifyConnectViewController = segue.destination as! SpotifyConnectViewController
            userData["password"] = passwordField.text!
            spotifyVC.userData = userData
        }
    }
}
