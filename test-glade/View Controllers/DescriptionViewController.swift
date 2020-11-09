//
//  DescriptionViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class DescriptionViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var descriptionPromptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    var currentUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        // Vertical Stack
        verticalStack.spacing = 20
        
        // Description Prompt
        descriptionPromptLabel.text = "Add a description"
        //emailPromptLabel.textColor
        descriptionPromptLabel.font = UIFont.systemFont(ofSize: 32, weight: .semibold)
        descriptionPromptLabel.textAlignment = .left
        descriptionPromptLabel.numberOfLines = 0
        
        // Text View
        textView.layer.cornerRadius = 20
        textView.backgroundColor = UIColor(red: 0/255, green: 200/255, blue: 0/255, alpha: 0.05)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .right
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toConnectSocials", sender: self)
    }
    
    @IBAction func backSwiped(_ sender: Any) {
        performSegue(withIdentifier: "backToSchool", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toConnectSocials" {
            let socialsVC: SocialsViewController = segue.destination as! SocialsViewController
        }
    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        textView.resignFirstResponder()
    }
}
