//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit
import Alamofire

class SpotifyConnectViewController: UIViewController, SPTSessionManagerDelegate {

    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    var currentUser = User()
    
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
        
        // Next Button
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor.systemGreen, for: .normal)
        nextButton.titleLabel!.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        nextButton.titleLabel!.textAlignment = .right
    }

    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Success:", session)
        
        // Request account info
        print("\nAccount Info Request...")
        let spotifyAccessToken = session.accessToken
        let spotifyRefreshToken = session.refreshToken
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: spotifyAccessToken)]
        let request = AF.request("https://api.spotify.com/v1/me", headers: headers)
        request.responseDecodable(of: User.self) { (response) in
            guard let user = response.value else {
                print("Failed to decode")
                return
            }
            self.currentUser = user
            print(user)
            
            try? Token.setToken(spotifyAccessToken, "Access Token")
            try? Token.setToken(spotifyRefreshToken, "Refresh Token")
        }
        // Creates dictionary from JSON response
//        request.responseJSON { response in
//            switch response.result {
//            case let .success(value):
//                print(value)
//            case let .failure(error):
//                print(error)
//            }
//        }
    }

    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed with Error:", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renewed", session)
    }
    
    @IBAction func connectButtonTapped(_ sender: Any) {
        let scopes: SPTScope = [.userReadEmail]

        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sessionManager.initiateSession(with: scopes, options: .default)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
            sessionManager.initiateSession(with: scopes, options: .clientOnly, presenting: self)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSchools", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSchools" {
            let schoolsVC: SchoolScrollViewController = segue.destination as! SchoolScrollViewController
            schoolsVC.currentUser = currentUser
        }
    }
}
