//
//  SpotifyConnectViewController.swift
//  test-glade
//
//  Created by Allen Gu on 10/11/20.
//

import UIKit
import Alamofire

class SpotifyConnectViewController: UIViewController, SPTSessionManagerDelegate {

    var userData: [String: String] = [:]
    
    // This configuration code probably shouldn't be here? Not sure
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

//    lazy var appRemote: SPTAppRemote = {
//        let appRemote = SPTAppRemote(configuration: configuration, logLevel: .debug)
//        appRemote.delegate = self
//        return appRemote
//    }()
    
    @IBOutlet var connectButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupItems()
    }
    
    func setupItems() {
        // Customized button, move to custom view later?
        connectButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 32)
        connectButton.setTitleColor(UIColor.white, for: .normal)
        connectButton?.layer.cornerRadius = (connectButton?.frame.size.height ?? 0)/2.0
        connectButton?.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        connectButton.backgroundColor = UIColor(red: 47/255, green: 156/255, blue: 90/255, alpha: 0.8)
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
            descriptionVC.userData = userData
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
        print("Success:", session)
        print("Here is the access token:", sessionManager.session?.accessToken)
        let spotifyAccessToken = sessionManager.session?.accessToken ?? ""
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/json"), .authorization(bearerToken: spotifyAccessToken)]
        print("\nAccount Info Request...")
        AF.request("https://api.spotify.com/v1/me", headers: headers).responseJSON { response in
            print(response)
        }
    }
    
    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
        print("Failed with Error:", error)
    }
    
    func sessionManager(manager: SPTSessionManager, didRenew session: SPTSession) {
        print("Renewed", session)
    }
    
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        print("Established connection")
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        print("Failed connection attempt")
//    }
//
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        print("Disconnected with error")
//    }
//
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//        print("Player state changed")
//    }
//
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "toDescription", sender: self)
    }
}
