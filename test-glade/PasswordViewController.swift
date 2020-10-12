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
    
    var userData: [String: String] = [:]
    var passwordValidation = PasswordValidationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
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
