//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit

class SpotifyConnectViewController: UIViewController {

    var userData: [String: String] = [:]
    @IBOutlet var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Customized button
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        connectButton.setTitleColor(UIColor.white, for: .normal)
        connectButton?.layer.cornerRadius = (connectButton?.frame.size.height ?? 0)/2.0
        connectButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        connectButton.backgroundColor = UIColor(red: 47/255, green: 156/255, blue: 90/255, alpha: 0.8)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func connectButtonTapped(_ sender: Any) {
    }
    
}
