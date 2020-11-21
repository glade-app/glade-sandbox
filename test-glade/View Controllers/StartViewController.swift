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
        
        // If user is signed up: Refresh their access token, update their data in Firestore, then send to home page
        if signedUp {
            Token.refreshAccessToken()

            let group = DispatchGroup()
            let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".datastorage.queue", attributes: .concurrent)
            // Request user's top artists from Spotify and save to Firebase
            group.enter()
            queue.async {
                DataStorage.storeUserTopArtists() { (result) in
                    print("Finished storing top artists")
                    group.leave()
                }
            }
            
            // Request user's top songs from Spotify and save to Firebase
            group.enter()
            queue.async(group: group) {
                DataStorage.storeUserTopSongs() { (result) in
                    print("Finished storing top songs")
                    group.leave()
                }
            }
            
            group.notify(queue: .main) {
                print("Finished storing data to Firestore")
                self.performSegue(withIdentifier: "startToMain", sender: self)
            }
        }
        // If user isn't signed up: Send them to the sign up sequence
        else {
            performSegue(withIdentifier: "toSchools", sender: self)
        }
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
