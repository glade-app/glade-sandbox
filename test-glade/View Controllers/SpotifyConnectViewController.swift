//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit
import Alamofire

class SpotifyConnectViewController: UIViewController, SPTSessionManagerDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
        
    var configuration = SPTConfiguration(clientID: Constants.clientID, redirectURL: Constants.redirectURI)
    
    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = Constants.tokenSwapURL,
           let tokenRefreshURL = Constants.tokenRefreshURL {
            self.configuration.tokenSwapURL = tokenSwapURL
            self.configuration.tokenRefreshURL = tokenRefreshURL
          // self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        return manager
    }()
    
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
        
        // Glade
        gladeNameLabel.text = "Glade"
        //gladeNameLabel.textColor
        gladeNameLabel.font = UIFont.boldSystemFont(ofSize: 72)
        gladeNameLabel.textAlignment = .center
        gladeNameLabel.numberOfLines = 0
        
        // Connect Button
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        connectButton.setTitleColor(UIColor.systemGreen, for: .normal)
        
        // Error Label
        errorLabel.text = " "
        errorLabel.textColor = .systemRed
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .right
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Successfully created Spotify session:", session)
        
        // Request account info
        print("\nAccount Info Request...")
        let spotifyAccessToken = session.accessToken
        let spotifyRefreshToken = session.refreshToken
        
        // Store tokens to Keychain
        try? Token.setToken(spotifyAccessToken, "Access Token")
        try? Token.setToken(spotifyRefreshToken, "Refresh Token")
        
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: spotifyAccessToken)]
        let request = AF.request("https://api.spotify.com/v1/me", headers: headers)
        request.responseDecodable(of: User.self) { (response) in
            guard var user = response.value else {
                print("Failed to decode")
                return
            }
            user.school = UserDefaults.standard.string(forKey: "school")
            print(user)
            
            let username = user.id!
            
            // Save username to UserDefaults
            let userDefaults = UserDefaults.standard
            userDefaults.set(username, forKey: "username")
            
            // Save user data to Firebase
            DataStorage.storeUserData(user: user) { result in
                // Request user's top artists from Spotify and save to Firebase
                DataStorage.storeUserTopArtists()
                
                // Request user's top songs from Spotify and save to Firebase
                DataStorage.storeUserTopSongs()
            }
        }
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed with Error:", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renewed", session)
    }
    
    @IBAction func connectButtonTapped(_ sender: Any) {
        let scopes: SPTScope = [.userReadEmail, .userTopRead]

        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sessionManager.initiateSession(with: scopes, options: .default)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
            sessionManager.initiateSession(with: scopes, options: .clientOnly, presenting: self)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        if UserDefaults.standard.string(forKey: "username") != nil {
            errorLabel.text = " "
            performSegue(withIdentifier: "toDescription", sender: self)
        }
        else {
            errorLabel.text = "Please connect your Spotify account"
        }
    }
}
