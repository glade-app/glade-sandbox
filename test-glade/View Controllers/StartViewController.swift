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
//        let signedUp = false // Testing Purposes
        
//        performSegue(withIdentifier: "startToMain", sender: self)
//        return
        
        // If user is signed up: Refresh their access token, update their data in Firestore, then send to home page
        if signedUp {
            Token.refreshAccessToken() { (result) in
                let username = UserDefaults.standard.string(forKey: "username")
                let accessToken = try! Token.getToken("accessToken", username: username!)
                Spotify.getUserData(accessToken: accessToken) { (result, user) in
                    DataStorage.storeUserData(user: user) { result in
                        // Store artists and songs data to Firestore
                        let group = DispatchGroup()
                        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".datastorage.queue", attributes: .concurrent)
                        // Request user's top artists from Spotify and save to Firebase
                        group.enter()
                        queue.async {
                            Spotify.getUserTopArtists(accessToken: accessToken) { (result, artists) in
                                DataStorage.storeUserTopArtists(artists: artists) { (result) in
                                    print("Finished storing top artists")
                                    group.leave()
                                }
                            }
                        }
                
                        // Request user's top songs from Spotify and save to Firebase
                        group.enter()
                        queue.async(group: group) {
                            Spotify.getUserTopSongs(accessToken: accessToken) { (result, songs) in
                                DataStorage.storeUserTopSongs(songs: songs) { (result) in
                                    print("Finished storing top songs")
                                    group.leave()
                                }
                            }
                        }
                
                        group.notify(queue: .main) {
                            print("Finished storing data to Firestore")
                            self.performSegue(withIdentifier: "startToMain", sender: self)
                        }
                    }
                }
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
        self.navigationController?.overrideUserInterfaceStyle = .light

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
