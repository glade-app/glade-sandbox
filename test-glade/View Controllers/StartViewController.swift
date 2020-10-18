//
//  StartViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit

class StartViewController: UIViewController {
    
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        // Vertical Stack
        verticalStack.spacing = 20
        
        // Glade
        gladeNameLabel.text = "Glade"
        //gladeNameLabel.textColor
        gladeNameLabel.font = UIFont.boldSystemFont(ofSize: 72)
        gladeNameLabel.textAlignment = .center
        gladeNameLabel.numberOfLines = 0
        
        // Signup Button
        signUpButton.setTitle("Signup", for: .normal)
        signUpButton.setTitleColor(UIColor.systemGreen, for: .normal)
        signUpButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        signUpButton.titleLabel!.textAlignment = .center
        
        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.systemGreen, for: .normal)
        loginButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        loginButton.titleLabel!.textAlignment = .center
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSignup", sender: self)
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toLogin", sender: self)
    }
}

