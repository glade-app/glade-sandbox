//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit
import Alamofire

struct User: Decodable {
    let displayName: String
    let email: String
    let href: String
    let id: String
//    let images: [Image]
    let type: String
    let uri: String


    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case email
        case href
        case id
//        case images
        case type
        case uri
    }
}
//
//struct Image: Decodable {
//    let height: String
//    let url: String
//    let width: String
//}

class SpotifyConnectViewController: UIViewController, SPTSessionManagerDelegate {

//    var currentUser = User(displayName: "", email: "", href: "", id: "", images: [Image(height: "", url: "", width: "")], type: "", uri: "")
    var currentUser = User(displayName: "", email: "", href: "", id: "", type: "", uri: "")
    
    var configuration = SPTConfiguration(clientID: Constants.clientID, redirectURL: Constants.redirectURI)

    lazy var sessionManager: SPTSessionManager = {
        if let tokenSwapURL = URL(string: "https://test-glade-token-swap.herokuapp.com/api/token"),
           let tokenRefreshURL = URL(string: "https://test-glade-token-swap.herokuapp.com/api/refresh_token") {
          self.configuration.tokenSwapURL = tokenSwapURL
          self.configuration.tokenRefreshURL = tokenRefreshURL
          self.configuration.playURI = ""
        }
        let manager = SPTSessionManager(configuration: self.configuration, delegate: self)
        self.configuration.playURI = ""
        return manager
    }()

    
    @IBOutlet weak var verticalStack: UIStackView!
    @IBOutlet weak var gladeNameLabel: UILabel!
    @IBOutlet var connectButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
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
    
    @IBAction func connectButtonTapped(_ sender: Any) {
        let scopes: SPTScope = [.appRemoteControl, .userReadEmail]

        if #available(iOS 11, *) {
            // Use this on iOS 11 and above to take advantage of SFAuthenticationSession
            sessionManager.initiateSession(with: scopes, options: .default)
        } else {
            // Use this on iOS versions < 11 to use SFSafariViewController
            sessionManager.initiateSession(with: scopes, options: .clientOnly, presenting: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDescription" {
            let descriptionVC: DescriptionViewController = segue.destination as! DescriptionViewController
            descriptionVC.currentUser = currentUser
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Success:", session)
        
        // Request account info
        print("\nAccount Info Request...")
        let spotifyAccessToken = session.accessToken
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: spotifyAccessToken)]
        let request = AF.request("https://api.spotify.com/v1/me", headers: headers)
        request.responseDecodable(of: User.self) { (response) in
            guard let user = response.value else {
                print("Failed to decode")
                return
            }
            self.setUser(user: user)
            print(self.currentUser)
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
    
    func setUser(user: User) {
        self.currentUser = user
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed with Error:", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renewed", session)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toSchools", sender: self)
    }
}
