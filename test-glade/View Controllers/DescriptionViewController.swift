//
//  DescriptionViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/17/20.
//

import UIKit

class DescriptionViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var descriptionPromptLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nextButton: UIButton!
    
//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
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
        DataStorage.updateUserFieldValue(field: "description", value: textView.text!)
        performSegue(withIdentifier: "toConnectSocials", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "toConnectSocials" {
//            let socialsVC: SocialsViewController = segue.destination as! SocialsViewController
//        }
//    }
    
    @IBAction func tapGestureRecognizer(_ sender: Any) {
        textView.resignFirstResponder()
    }
}
