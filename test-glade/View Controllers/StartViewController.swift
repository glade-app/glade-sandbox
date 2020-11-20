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
    
    override func viewDidAppear(_ animated: Bool) {
        let signedUp = UserDefaults.standard.bool(forKey: "signedUp")
//        if signedUp {
//            Token.refreshAccessToken()
//            let userDefaults = UserDefaults.standard.string(forKey: "username")
//
//            // Request user's top artists from Spotify and save to Firebase
//            DataStorage.storeUserTopArtists()
//
//            // Request user's top songs from Spotify and save to Firebase
//            DataStorage.storeUserTopSongs()
//
//            performSegue(withIdentifier: "startToMain", sender: self)
//        }
//        else {
//            performSegue(withIdentifier: "toSchools", sender: self)
//        }
        performSegue(withIdentifier: "toSchools", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    }
}
