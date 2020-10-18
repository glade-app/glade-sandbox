//
//  LoginViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/9/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
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
        
        // Login Button
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.systemGreen, for: .normal)
        loginButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        loginButton.titleLabel!.textAlignment = .center
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "loginToMain", sender: self)
    }
}
