//
//  Account.swift
//  test-glade
//
//  Created by Allen Gu on 11/8/20.
//

import Foundation
import Security
import Alamofire

enum TokenError: Error {
    case failedConversion
    case didNotSetToken
    case didNotGetToken
    case didNotUpdateToken
    case tokenNotFound
}

extension TokenError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .failedConversion:
            return NSLocalizedString("Failed to convert token to Data", comment: "")
        case .didNotSetToken:
            return NSLocalizedString("Could not set token in Keychain", comment: "")
        case .didNotGetToken:
            return NSLocalizedString("Could not get token from Keychain", comment: "")
        case .didNotUpdateToken:
            return NSLocalizedString("Could not update token from Keychain", comment: "")
        case .tokenNotFound:
            return NSLocalizedString("Could not find token", comment: "")
        }
    }
}

struct Token {
    private static let serviceName: String = {
        guard let bundleID = Bundle.main.bundleIdentifier else {
            return "Bundle ID Not Found"
        }
        return bundleID
    }()
    
    static func setToken(_ token: String, _ tokenType: String, username: String) throws {        
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrAccount as String: "\(username)_\(tokenType)",
                                    kSecAttrService as String: serviceName]
        let encodedToken = token.data(using: .utf8)
        var status = SecItemCopyMatching(query as CFDictionary, nil)
        switch status {
        case errSecSuccess:
            let tokenToUpdate: [String: Any] = [kSecValueData as String: encodedToken!]
            status = SecItemUpdate(query as CFDictionary, tokenToUpdate as CFDictionary)
            if status != errSecSuccess {
                throw TokenError.didNotUpdateToken
            }
            print("Finished updating token - \(tokenType)")
        case errSecItemNotFound:
            query[kSecValueData as String] = encodedToken
            SecItemAdd(query as CFDictionary, nil)
            print("Finished setting token - \(tokenType)")
        default:
            print("Unable to set token - \(tokenType)")
            throw TokenError.didNotSetToken
        }
    }
    
    static func getToken(_ tokenType: String, username: String) throws -> String {

        let getquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrAccount as String: "\(username)_\(tokenType)",
                                       kSecAttrService as String: serviceName,
                                       kSecMatchLimit as String: kSecMatchLimitOne,
                                       kSecReturnAttributes as String: kCFBooleanTrue!,
                                       kSecReturnData as String: kCFBooleanTrue!]
    
        var item: CFTypeRef?
        let status = SecItemCopyMatching(getquery as CFDictionary, &item)
        print("Finished getting token - \(tokenType) - with status: \(status)")
        guard status == errSecSuccess else {
            throw TokenError.tokenNotFound
        }
        
        guard let existingItem = item as? [String : Any],
            let tokenData = existingItem[kSecValueData as String] as? Data,
            let token = String(data: tokenData, encoding: .utf8)
        else {
            throw TokenError.didNotGetToken
        }
        return token
    }
    
    static func refreshAccessToken(completion: @escaping (_ result: Bool) -> ()) {
        let username = UserDefaults.standard.string(forKey: "username")
        let refreshToken = try? getToken("refreshToken", username: username!)
        
        let parameters: Parameters = ["refresh_token": refreshToken! as Any]
        let headers: HTTPHeaders = [.accept("application/json"), .contentType("application/x-www-form-urlencoded")]
        AF.request(Constants.tokenRefreshURLString, method: .post, parameters: parameters, headers: headers).responseJSON { (response) in

            switch response.result {
            case let .success(value):
                if let responseDict = value as? [String: Any] {
                    do {
                        let accessToken: String = responseDict["access_token"]! as! String
                        try setToken(accessToken, "accessToken", username: username!)
                        print("Successfully refreshed Spotify access token")
                        completion(true)
                    }
                    catch {
                        print("Failed to refresh Spotify access token")
                    }
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
