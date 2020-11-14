//
//  SocialsViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class SocialsViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var socialsPromptLabel: UILabel!
    @IBOutlet weak var facebookStack: UIStackView!
    @IBOutlet weak var facebookImage: UIImageView!
    @IBOutlet weak var facebookField: UITextField!
    @IBOutlet weak var instagramStack: UIStackView!
    @IBOutlet weak var instagramImage: UIImageView!
    @IBOutlet weak var instagramField: UITextField!
    @IBOutlet weak var snapchatStack: UIStackView!
    @IBOutlet weak var snapchatImage: UIImageView!
    @IBOutlet weak var snapchatField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    var userData: [String: String] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        // Do any additional setup after loading the view.
    }
    
    func setupItems() {
        facebookImage.image = UIImage(named: "facebook")
        instagramImage.image = UIImage(named: "instagram")
        snapchatImage.image = UIImage(named: "snapchat")
        snapchatImage.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 0/255, alpha: 1)
        snapchatImage.layer.cornerRadius = 10

        // Vertical stack
        verticalStack.spacing = 20
        
        // Socials prompt
        socialsPromptLabel.text = "Connect your socials:"
        //emailPromptLabel.textColor
        socialsPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        socialsPromptLabel.textAlignment = .left
        socialsPromptLabel.numberOfLines = 0
        
        // Facebook stack
        facebookStack.spacing = 10
        self.facebookField.delegate = self
        
        // Instagram stack
        instagramStack.spacing = 10
        self.instagramField.delegate = self

        // Snapchat stack
        snapchatStack.spacing = 10
        self.snapchatField.delegate = self

        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .right
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        facebookField.resignFirstResponder()
        instagramField.resignFirstResponder()
        snapchatField.resignFirstResponder()
    }
    
    @IBAction func signupButtonTapped(_ sender: Any) {
        DataStorage.saveUserFieldValue(field: "socials", value: [
                                        "snapchat": snapchatField.text,
                                        "facebook": facebookField.text,
                                        "instagram": instagramField.text])
        performSegue(withIdentifier: "signupToMain", sender: self)
    }
    
    @IBAction func backSwiped(_ sender: Any) {
        performSegue(withIdentifier: "backToDescription", sender: self)
    }
}
